page 50409 "Bicycle API"
{
    PageType = API;
    APIPublisher = 'DefaultPublisher';
    APIGroup = 'bicycles';
    APIVersion = 'v1.0';
    SourceTable = Bicycle;

    EntityName = 'Bicycle';
    EntitySetName = 'Bicycles';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Items)
            {
                field(No; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(RentalType; Rec."Rental Type Code")
                {
                    Caption = 'Rental Type';
                }
            }
        }
    }
}
