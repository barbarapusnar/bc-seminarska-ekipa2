table 50403 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rental No."; Integer)
        {
            Caption = 'Rental No.';
            TableRelation = "Rental Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bicycle No."; Code[20])
        {
            Caption = 'Bicycle No.';
            TableRelation = Bicycle where(Status = CONST(Avalible));
            //•	Kolo mora imeti status Available (Na voljo), da ga lahko izbereš.

            trigger OnValidate()
            var
                BicycleStat: Record Bicycle;
            begin
                if BicycleStat.Get("Bicycle No.") then
                    if BicycleStat.Status <> BicycleStat.Status::Avalible then
                        Error('Kolo mora imeti status Available');
            end;
        }
        field(4; Description; Text[255])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Rental Type".Description where(Code = field("Bicycle No.")));
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
        }
        field(6; "Rental Days "; Integer)
        {
            Caption = 'Rental Days ';
            MinValue = 0;
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            //NIMAM POJMA
        }
    }
    keys
    {
        key(PK; "Rental No.")
        {
            Clustered = true;
        }
    }
}
