xmlport 50400 "Import Bicycles"
{
    Caption = 'Import Bicycles';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(Bicycle; Bicycle)
            {
                XmlName = 'Bicycle';
                fieldelement(No; Bicycle."No.")
                {
                    XmlName = 'No';
                }
                fieldelement(RentalTypeCode; Bicycle."Rental Type Code")
                {
                    XmlName = 'RentalTypeCode';
                }
                fieldelement(Description; Bicycle.Description)
                {
                    XmlName = 'Description';
                }

                trigger OnBeforeInsertRecord()
                var
                    RentalType: Record "Rental Type";
                begin
                    // Preskoči zapis, če No. ali RentalTypeCode sta prazna
                    if Bicycle."No." = '' then begin
                        exit;
                    end;

                    if Bicycle."Rental Type Code" = '' then begin
                        exit;
                    end;

                    // Preveri ali tip kolesa obstaja
                    if not RentalType.Get(Bicycle."Rental Type Code") then begin
                        exit;
                    end;

                    // Preveri ali kolo s to številko že obstaja
                    if Bicycle.Find() then begin
                        exit;
                    end;

                    // Nastavi privzet status
                    Bicycle.Status := Bicycle.Status::Avalible;
                end;
            }
        }
    }
}