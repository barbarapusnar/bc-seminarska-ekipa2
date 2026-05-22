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
}
