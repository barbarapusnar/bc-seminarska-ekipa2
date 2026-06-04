table 50405 "Rental Price List1"
{
    Caption = 'Rental PRice List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[255])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
            TableRelation = "Rental Type".Code;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            trigger OnValidate()
            begin
                if "Starting Date" > "Ending Date" then
                    Error('Expected starting date: %1 nemora bit večji od ending date: %2', "Starting Date", "Ending Date");
            end;
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0;
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
