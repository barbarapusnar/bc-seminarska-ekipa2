page 50404 "Rental List"
{
    ApplicationArea = All;
    Caption = 'Rental List';
    PageType = List;
    SourceTable = "Rental Header";
    UsageCategory = Lists;
    CardPageId = "Rental Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                //Lahko je za odstraniti nekatere podatke
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
                field("Rental Date"; Rec."Rental Date")
                {
                    ToolTip = 'Specifies the value of the Rental Date field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
            }
        }
    }
}
