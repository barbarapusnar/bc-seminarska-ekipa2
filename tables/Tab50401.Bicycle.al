table 50401 Bicycle
{
    Caption = 'Bicycle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            TableRelation = "Rental Type".Code;
            NotBlank = true;
        }
        field(3; Description; Text[255])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Rental Type".Description where(Code = field("Rental Type Code")));
        }
        field(4; Status; Enum "Bicycle Status")
        {
            Caption = 'Status';
            InitValue = Avalible;
        }
        field(5; "Purchase Date"; Date)
        {
            Caption = 'Purchase Date';
        }
        field(6; "Purchase Price"; Decimal)
        {
            Caption = 'Purchase Price';
            trigger OnValidate()
            begin
                if ("Purchase Price" < 0) then
                    Error('Nabavna cena nesme biti negativna');
            end;
        }
        field(7; "Current location"; Text[50])
        {
            Caption = 'Current location';
        }
        field(8; "Last service Date "; Date)
        {
            Caption = 'Last service Date ';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
