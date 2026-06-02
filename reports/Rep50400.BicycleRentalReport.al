report 50400 "Bicycle Rental Report"
{
    ApplicationArea = All;
    Caption = 'Bicycle Rental Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Bicycle-Rental-Report.docx';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CurrentDate_; CurrentDate)
            {

            }

            column(CustomerNo_; "No.")
            {
                IncludeCaption = true;
            }

            column(CustomerName; Name)
            {
                IncludeCaption = true;
            }

            dataitem("Rental Header"; "Rental Header")
            {
                DataItemLink = "Customer No." = field("No.");

                column(No_; "No.")
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

                column(Status; Status)
                {
                    IncludeCaption = true;
                }

                dataitem("Rental Line"; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");

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
            area(Content)
            {
                group(Filters)
                {
                }
            }
        }
    }

    labels
    {
        ReportTitle = 'Izposoja kolesa';
    }

    trigger OnPreReport()
    begin
        CurrentDate := Today();
    end;

    var
        CurrentDate: Date;
}