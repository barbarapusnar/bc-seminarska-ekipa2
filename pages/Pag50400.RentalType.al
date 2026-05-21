page 50400 "Rental Type"
{
    ApplicationArea = All;
    Caption = 'Rental Type';
    PageType = List;
    SourceTable = "Rental Type";
    UsageCategory = Lists;
    CardPageId = "Rental Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ToolTip = 'Specifies the value of the Daily Rate field.', Comment = '%';
                }
            }
        }
    }
}
