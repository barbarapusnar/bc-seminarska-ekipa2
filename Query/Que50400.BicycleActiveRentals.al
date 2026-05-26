query 50400 "Bicycle Active Rentals"
{
    Caption = 'Bicycle Active Rentals';
    QueryType = Normal;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            column(No_; "No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Status; Status)
            {

            }
        }
        dataitem


    }

    trigger OnBeforeOpen()
    begin

    end;
}
