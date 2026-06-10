XmlPort 50410 "Import Bicycle"
{
    Direction = Import;
    Format = Xml;
    Caption = 'Import Bicycle';

    schema
    {
        textelement(Bicycles)
        {
            tableelement(Bicycle; Bicycle)
            {
                AutoSave = false;

                fieldelement(No; Bicycle."No.")
                {
                }
                fieldelement(RentalType; Bicycle."Rental Type Code")
                {
                }

                trigger OnAfterInitRecord()
                var
                    RentalTypeRec: Record "Rental Type";
                begin
                    if Bicycle."No." = '' then
                        exit;

                    if not RentalTypeRec.Get(Bicycle."Rental Type Code") then
                        exit;

                    if Bicycle.Get(Bicycle."No.") then
                        exit;

                    Bicycle.Status := Bicycle.Status::Avalible;
                    Bicycle.Insert();
                end;
            }
        }
    }
}
