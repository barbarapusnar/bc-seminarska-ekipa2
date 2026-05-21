page 50403 "Bicycle Card"
{
    ApplicationArea = All;
    Caption = 'Bicycle Card';
    PageType = Card;
    SourceTable = Bicycle;

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
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ToolTip = 'Specifies the value of the Rental Type Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Current location"; Rec."Current location")
                {
                    ToolTip = 'Specifies the value of the Current location field.', Comment = '%';
                }
                field("Last service Date "; Rec."Last service Date ")
                {
                    ToolTip = 'Specifies the value of the Last service Date field.', Comment = '%';
                }
            }
            group("Purchase info")
            {
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ToolTip = 'Specifies the value of the Purchase Date field.', Comment = '%';
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ToolTip = 'Specifies the value of the Purchase Price field.', Comment = '%';
                }
            }

        }
    }
}
