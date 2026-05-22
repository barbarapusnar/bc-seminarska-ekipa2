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
        //NE DELA, POPRAVI in TESTIRAJ
        field(4; Description; Text[255])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Bicycle.Description where("No." = field("Bicycle No.")));
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            trigger OnValidate()
            begin
                CalculateLineAmount();
            end;
        }
        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days ';
            MinValue = 0;
            trigger OnValidate()
            begin
                CalculateLineAmount();
            end;
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Editable = false;
        }
    }
    keys
    {
        //Dodal Line No. da imam več Line na en rental testirej če je to sploh potreba
        key(PK; "Rental No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure CalculateLineAmount()
    begin
        "Line Amount" := "Daily Rate" * "Rental Days";
    end;
}
