pageextension 50400 "Customer card ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group("Rental Information")
            {
                Caption = 'Rental Information';

                field("Preferred Rental Type"; Rec."Preferred Rental Type")
                {
                    ApplicationArea = All;
                    Caption = 'Preferred Rental Type';
                    ToolTip = 'Specifies the customer''s preferred bicycle rental type.';
                }
                field("VIP Customer"; Rec."VIP Customer")
                {
                    ApplicationArea = All;
                    Caption = 'VIP Customer';
                    ToolTip = 'Specifies whether this customer is a VIP.';
                }
                field("Max Active Rentals"; Rec."Max Active Rentals")
                {
                    ApplicationArea = All;
                    Caption = 'Max Active Rentals';
                    ToolTip = 'Specifies the maximum number of active rentals allowed for this customer.';
                }
            }
        }
    }
}
