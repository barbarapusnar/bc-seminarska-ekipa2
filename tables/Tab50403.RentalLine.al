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
                if BicycleStat.Get("Bicycle No.") then begin

                    if BicycleStat.Status <> BicycleStat.Status::Avalible then
                        Error('Kolo mora imeti status Available');

                    //Najprej se more izračunati
                    BicycleStat.CalcFields(Description);

                    Description := BicycleStat.Description;
                end;
                SetDailyRateFromPriceList();
            end;
        }
        field(4; Description; Text[255])
        {
            Caption = 'Description';
            Editable = false;
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

    local procedure SetDailyRateFromPriceList()
    var
        RentalHeader: Record "Rental Header";
        Bicycle: Record Bicycle;
        RentalType: Record "Rental Type";
        RentalPriceList: Record "Rental Price List";
        RentalDate: Date;
    begin
        // 1. Glava izposoje mora obstajati
        if not RentalHeader.Get("Rental No.") then
            Error('Za izbrano vrstico ne obstaja glava izposoje (Rental Header) s številko %1.', "Rental No.");

        RentalDate := RentalHeader."Rental Date";

        // 2. Kolo mora obstajati
        if not Bicycle.Get("Bicycle No.") then
            Error('Izbranega kolesa %1 ni mogoče najti.', "Bicycle No.");

        // 3. Kolo mora imeti določen Rental Type
        if Bicycle."Rental Type Code" = '' then
            Error('Izbrano kolo %1 nima določenega tipa kolesa (Rental Type Code).', "Bicycle No.");

        // 4. Poišči cenik: Rental Type Code ujema + datum znotraj obdobja
        RentalPriceList.Reset();
        RentalPriceList.SetRange("Rental Type Code", Bicycle."Rental Type Code");
        RentalPriceList.SetFilter("Starting Date", '<=%1', RentalDate);
        RentalPriceList.SetFilter("Ending Date", '>=%1', RentalDate);

        if RentalPriceList.FindFirst() then begin
            // Cenik najden → uporabi Daily Rate iz cenika
            "Daily Rate" := RentalPriceList."Daily Rate";
        end else begin
            // Cenik ni najden → fallback na osnovno ceno iz Rental Type
            if not RentalType.Get(Bicycle."Rental Type Code") then
                Error('Za izbrani tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena v tabeli Rental Type.', Bicycle."Rental Type Code");

            if RentalType."Daily Rate" = 0 then
                Error('Za izbrani tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena v tabeli Rental Type.', Bicycle."Rental Type Code");

            "Daily Rate" := RentalType."Daily Rate";
        end;

        // 5. Posodobi znesek vrstice
        CalculateLineAmount();
    end;
}
