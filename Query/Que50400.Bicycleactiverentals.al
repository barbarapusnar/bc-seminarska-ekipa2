query 50400 "Bicycle active rentals"
{
    Caption = 'Bicycle active rentals';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;

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
                Caption = 'Header No.';
            }
            column(Status; Status)
            {
                Caption = 'Status';
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = RentalHeader."Customer No.";
                SqlJoinType = InnerJoin;
                column(Customer_No; "No.")
                {
                    Caption = 'Customer No.';
                }
                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = RentalHeader."No.";
                    SqlJoinType = InnerJoin;
                    column(Rental_Days; "Rental Days")
                    {
                        Caption = 'Rental Days';
                    }
                    column(Line_Amount; "Line Amount")
                    {
                        Caption = 'Line Amount';
                    }

                    dataitem(Bicycle; Bicycle)
                    {
                        DataItemLink = "No." = RentalLine."Bicycle No.";
                        SqlJoinType = InnerJoin;
                        column(Bicycle_No; "No.")
                        {
                            Caption = 'Bicycle No.';
                        }
                        column(Description; Description)
                        {
                            Caption = 'Description';
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
