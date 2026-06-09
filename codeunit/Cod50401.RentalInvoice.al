codeunit 50401 "Rental Invoice"
{
    procedure CreateSalesInvoice(var RentalHeader: Record "Rental Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RentalLine: Record "Rental Line";
        LineNo: Integer;
    begin
        if RentalHeader.Status <> RentalHeader.Status::Returned then
            Error('Prodajni račun je možno ustvariti samo za zaključene izposoje (status Returned).');

        // Ustvari Sales Header
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Validate("Sell-to Customer No.", RentalHeader."Customer No.");
        SalesHeader."Posting Date" := Today;
        SalesHeader."Document Date" := Today;
        SalesHeader.Insert(true);

        // Ustvari Sales Lines iz Rental Lines
        LineNo := 10000;

        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.FindSet() then
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", 'RENTAL');
                SalesLine.Validate(Description, RentalLine.Description);
                SalesLine.Validate(Quantity, RentalLine."Rental Days");
                SalesLine.Validate("Unit Price", RentalLine."Daily Rate");
                SalesLine.Insert(true);

                LineNo += 10000;
            until RentalLine.Next() = 0;

        Message('Prodajni račun %1 je bil uspešno ustvarjen.', SalesHeader."No.");
    end;
}
