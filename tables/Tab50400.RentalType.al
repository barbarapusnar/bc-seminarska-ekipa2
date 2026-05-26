table 50400 "Rental Type"
{
    Caption = 'Rental Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[255])
        {
            Caption = 'Description';
        }
        field(3; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0;
        }
        field(4; "Max Rental Days"; Integer)
        {
            Caption = ' Max Rental Days';
            MinValue = 1;
            trigger OnValidate()
            begin
                if "Max Rental Days" < 1 then
                    Error('Maksimalno število dni mora biti vsaj 1.');
            end;
        }

        field(5; "Requies Deposit"; Boolean)
        {
            Caption = 'Requies Deposit';
        }
        field(6; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';

            trigger OnValidate()
            begin
                if "Requies Deposit" then
                    if "Deposit Amount" <= 0 then
                        Error('Deposit Amount mora biti večji kot 0.');
            end;
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
