tableextension 50400 "Customer Bicycle Ext" extends Customer
{
    fields
    {
        field(50400; "Preferred Rental Type"; Code[25])
        {
            Caption = 'Preferred Rental Type';
            DataClassification = ToBeClassified;
            TableRelation = "Rental Type".Code;
        }
        field(50401; "VIP Customer"; Boolean)
        {
            Caption = 'VIP Customer';
            DataClassification = ToBeClassified;
        }
        field(50402; "Max Active Rentals"; Integer)
        {
            Caption = 'Max Active Rentals';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ("Max Active Rentals" < 0) then
                    Error('Max active rentals mora biti velji ali enak 0');
            end;
        }
    }
}
