page 50402 "Bicycle List"
{
    ApplicationArea = All;
    Caption = 'Bicycle List';
    PageType = List;
    SourceTable = Bicycle;
    UsageCategory = Lists;
    CardPageId = "Bicycle Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {

                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Current location"; Rec."Current location")
                {
                    ToolTip = 'Specifies the value of the Current location field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
