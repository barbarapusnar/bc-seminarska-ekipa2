query 50400 "Bycicle active rentals"
{
    Caption = 'Bycicle active rentals';
    QueryType = Normal;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            filter(StatusFilter; Status)
            {
                ColumnFilter = StatusFilter = filter(Active);
            }

            column(Header_No; "No.")
            {
                Caption = 'Številka izposoje';
            }
            column(Status; Status)
            {
                Caption = 'Status izposoje';
            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = RentalHeader."Customer No.";
                SqlJoinType = InnerJoin;
                column(Customer_No; "No.")
                {
                    Caption = 'Šifra stranke';
                }

                dataitem(Rental_Line; "Rental Line")
                {
                    DataItemLink = "Rental No." = RentalHeader."No.";
                    SqlJoinType = InnerJoin;
                    column(Rental_Days; "Rental Days")
                    {
                        Caption = 'Število dni izposoje';
                    }
                    column(Line_Amount; "Line Amount")
                    {
                        Caption = 'Znesek';
                    }

                    dataitem(Bicycle; Bicycle)
                    {
                        DataItemLink = "No." = Rental_Line."Bicycle No.";
                        SqlJoinType = InnerJoin;
                        column(Bicycle_No; "No.")
                        {
                            Caption = 'Šifra kolesa';
                        }
                        column(Description; Description)
                        {
                            Caption = 'Opis kolesa';
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
