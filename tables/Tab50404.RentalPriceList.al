table 50404 "Rental Price List"
{
    Caption = 'Rental Price List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[25])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[25])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if ("Starting Date" < "Ending Date") then
                    Error('Staring date nemore biti manjši od ending date');
            end;
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
