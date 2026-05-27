report 50400 "Rental Report"
{
    Caption = 'Rental Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'RentalReport.docx';
    dataset
    {
        dataitem(Customer; "Customer")
        {
            column(Customer_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Name; Name)
            {
                IncludeCaption = true;
            }
            dataitem("Rental Header"; "Rental Header")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Rental_No; "No.")
                {
                    IncludeCaption = true;
                }
                column(Rental_Date; "Rental Date")
                {
                    IncludeCaption = true;
                }
                column(Expected_Return_Date; "Expected Return Date")
                {
                    IncludeCaption = true;
                }
                column(Actual_Return_Date; "Actual Return Date")
                {
                    IncludeCaption = true;
                }
                column(Status; Format(Status))
                {
                }
                dataitem("Rental Line"; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");
                    DataItemTableView = sorting("Rental No.");

                    column(Bicycle_No; "Bicycle No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(Rental_Days; "Rental Days")
                    {
                        IncludeCaption = true;
                    }
                    column(Daily_Rate; "Daily Rate")
                    {
                        IncludeCaption = true;
                    }
                    column(Line_Amount; "Line Amount")
                    {
                        IncludeCaption = true;
                    }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
