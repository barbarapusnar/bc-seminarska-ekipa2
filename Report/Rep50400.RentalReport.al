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
            column(PrintDate; Today)
            {
            }
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
                column(Total_Amount; "Total Amount")
                {
                    IncludeCaption = true;
                }
                dataitem("Rental Line"; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");
                    DataItemTableView = sorting("Rental No.");

                    column(Bicycle_No_; "Bicycle No.")
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
            // area(Content)
            // {
            //     group(Extras)
            //     {
            //         Caption = 'Extras';

            //         field(ReportDate; ReportDate)
            //         {
            //             Caption = 'Datum izpisa';
            //             Editable = false;
            //         }
            //     }
            // }
        }
        // trigger OnOpenPage()
        // begin
        //     ReportDate := Today();
        // end;
    }
    labels
    {
        ReportTitle = 'Poročilo o izposoji koles';
    }
    // var
    //     ReportDate: Date;
}
