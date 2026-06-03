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

            trigger OnValidate()
            begin
                CheckDateOverlap();
            end;
        }

        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if ("Ending Date" <> 0D) and ("Starting Date" > "Ending Date") then
                    Error('Starting Date mora biti manjši ali enak Ending Date.');

                CheckDateOverlap();
            end;
        }

        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                if ("Starting Date" > "Ending Date") then
                    Error('Starting Date mora biti manjši ali enak Ending Date.');

                CheckDateOverlap();
            end;
        }

        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';

            trigger OnValidate()
            begin
                if "Daily Rate" < 0 then
                    Error('Daily Rate ne sme biti negativen.');
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

    local procedure CheckDateOverlap()
    var
        RentalPriceList: Record "Rental Price List";
    begin
        if ("Rental Type Code" = '') or
           ("Starting Date" = 0D) or
           ("Ending Date" = 0D) then
            exit;

        RentalPriceList.Reset();
        RentalPriceList.SetRange("Rental Type Code", "Rental Type Code");

        // Izloči trenutni zapis pri urejanju
        RentalPriceList.SetFilter(Code, '<>%1', Code);

        if RentalPriceList.FindSet() then
            repeat
                if (RentalPriceList."Starting Date" <= "Ending Date") and
                   (RentalPriceList."Ending Date" >= "Starting Date") then
                    Error(
                        'Za Rental Type %1 že obstaja veljaven cenik v obdobju %2 - %3.',
                        "Rental Type Code",
                        RentalPriceList."Starting Date",
                        RentalPriceList."Ending Date");
            until RentalPriceList.Next() = 0;
    end;
}