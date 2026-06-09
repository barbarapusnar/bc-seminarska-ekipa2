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
                Image = Invoice;

                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    RentalLine: Record "Rental Line";
                    LineNo: Integer;
                begin
                    if Rec.Status <> Rec.Status::Returned then
                        Error('The rental must have status "Returned" before creating a sales invoice.');

                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := Rec."Customer No.";
                    SalesHeader."Bill-to Customer No." := Rec."Customer No.";
                    SalesHeader."Posting Date" := Today;
                    SalesHeader."Document Date" := Today;
                    SalesHeader.Insert();

                    RentalLine.SetRange("Rental No.", Rec."No.");
                    if RentalLine.FindSet() then begin
                        LineNo := 10000;
                        repeat
                            SalesLine.Init();
                            SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                            SalesLine."Document No." := SalesHeader."No.";
                            SalesLine."Line No." := LineNo;
                            SalesLine.Description := RentalLine.Description;
                            SalesLine.Quantity := RentalLine."Rental Days";
                            SalesLine."Unit Price" := RentalLine."Daily Rate";
                            SalesLine.Insert();

                            LineNo += 10000;
                        until RentalLine.Next() = 0;
                    end;

                    Page.RunModal(Page::"Sales Invoice", SalesHeader);
                end;
            }
        }
    }
}
