page 50405 "Rental Card"
{
    ApplicationArea = All;
    Caption = 'Rental Card';
    PageType = Card;
    SourceTable = "Rental Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
                field("Rental Date"; Rec."Rental Date")
                {
                    ToolTip = 'Specifies the value of the Rental Date field.', Comment = '%';
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ToolTip = 'Specifies the value of the Expected Return Date field.', Comment = '%';
                }
                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ToolTip = 'Specifies the value of the Actual Return Date field.', Comment = '%';
                }
            }
            part(Lines; "Rental Line Subpage")
            {
                SubPageLink = "Rental No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartRental)
            {
                Caption = 'Start Rental';
                Image = Start;

                ApplicationArea = All;

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.StartRental(Rec);

                    CurrPage.Update();
                end;
            }

            action(ProcessReturn)
            {
                Caption = 'Process Return';
                Image = Return;

                ApplicationArea = All;

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.ProcessReturn(Rec);

                    CurrPage.Update();
                end;
            }
            action(CreateSalesInvoice)
            {
                Caption = 'Create Sales Invoice';
                Image = NewInvoice;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RentalLine: Record "Rental Line";
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    LineNo: Integer;
                begin
                    Rec.TestField("Customer No.");

                    // Sales Header
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader.Insert(true);

                    SalesHeader.Validate("Sell-to Customer No.", Rec."Customer No."); // Customer No. iz izposoje
                    SalesHeader.Validate("Document Date", Today());                    // datum = današnji dan
                    SalesHeader.Modify(true);

                    // Sales Lines iz Rental Lines
                    LineNo := 10000;
                    RentalLine.SetRange("Rental No.", Rec."No.");
                    if RentalLine.FindSet() then
                        repeat
                            SalesLine.Init();
                            SalesLine."Document Type" := SalesHeader."Document Type";
                            SalesLine."Document No." := SalesHeader."No.";
                            SalesLine."Line No." := LineNo;
                            SalesLine.Insert(true);

                            SalesLine.Validate(Type, SalesLine.Type::Item);
                            SalesLine.Validate("No.", 'RENTAL');
                            SalesLine.Validate(Description, RentalLine.Description);  // opis kolesa
                            SalesLine.Validate(Quantity, RentalLine."Rental Days");   // Rental Days
                            SalesLine.Validate("Unit Price", RentalLine."Daily Rate"); // Daily Rate
                                                                                       // Amount (Line Amount) se izračuna avtomatsko: Quantity * Unit Price
                            SalesLine.Modify(true);

                            LineNo += 10000;
                        until RentalLine.Next() = 0
                    else
                        Error('Ni najdenih vrstic za izposojo %1.', Rec."No.");

                    Message('Sales Invoice %1 je bil uspešno ustvarjen.', SalesHeader."No.");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
