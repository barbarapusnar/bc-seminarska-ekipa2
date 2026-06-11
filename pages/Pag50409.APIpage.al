page 50409 "Bicycle API"
{
    //link do dostopa api preko postman= http://bcsandbox-default:7048/BC/api/school/rental/v1.0/companies(5952822c-7949-f111-b477-7ced8d3e5aa7)/bicycles
    PageType = API;
    Caption = 'Bicycle API';

    APIPublisher = 'school';
    APIGroup = 'rental';
    APIVersion = 'v1.0';

    EntityName = 'bicycle';
    EntitySetName = 'bicycles';

    SourceTable = Bicycle;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    ApplicationArea = All;
                }

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }

                field(rentalTypeCode; Rec."Rental Type Code")
                {
                    Caption = 'Rental Type';
                    ApplicationArea = All;
                }
            }
        }
    }
}
