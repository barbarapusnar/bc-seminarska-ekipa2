query 50400 "Bicycle Active Rentals"
{
    Caption = 'Bicycle Active Rentals';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            column(No_; "No.")
            {
                Caption = 'Številka izposoje';
            }

            column(Customer_No_; "Customer No.")
            {
                Caption = 'Številka Stranke';
            }

            filter(StatusFilter; Status)
            {
                Caption = 'Status Izposoje';
                ColumnFilter = StatusFilter = filter(Active);
            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = RentalHeader."Customer No.";
                SqlJoinType = InnerJoin;

                column(CustomerName; Name)
                {
                    Caption = 'Ime Stranke';
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
                        column(BicycleNo; "No.")
                        {
                            Caption = 'Šifra Kolesa';
                        }

                        column(BicycleDescription; Description)
                        {
                            Caption = 'Opis Kolesa';
                        }
                    }
                }
            }
        }
    }
}