codeunit 50400 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Preveri status
        if RentalHeader.Status <> RentalHeader.Status::Open then
            Error('Izposoja mora imeti status Open.');

        // Ali izposoja vsebuje vsaj eno vrstico
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja nima nobene vrstice.');

        // Preveri max aktivnih izposoj za stranko
        CheckMaxActiveRentals(RentalHeader."Customer No.");

        // Ali so vsa izbrana kolesa na voljo (Status = Available)
        RentalLine.FindSet();

        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja.', RentalLine."Bicycle No.");

            if Bicycle.Status <> Bicycle.Status::Avalible then
                Error('Kolo %1 ni na voljo.', Bicycle."No.");

        until RentalLine.Next() = 0;

        // Nastavi Bicycle -> Rented
        RentalLine.FindSet();

        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Rented;
            Bicycle.Modify();

        until RentalLine.Next() = 0;

        // Nastavi Rental -> Active
        RentalHeader.Status := RentalHeader.Status::Active;
        RentalHeader.Modify();

        Message('Izposoja se je začela.');
    end;

    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Status mora biti Active
        if RentalHeader.Status <> RentalHeader.Status::Active then
            Error('Izposoja mora imeti aktiven status.');

        // Mora obstajati vsaj ena vrstica
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja nima nobene vrstice.');

        // Preveri, če vsa kolesa obstajajo
        RentalLine.FindSet();

        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja.', RentalLine."Bicycle No.");

        until RentalLine.Next() = 0;

        // Nastavi Bicycle -> Available
        RentalLine.FindSet();

        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Avalible;
            Bicycle.Modify();

        until RentalLine.Next() = 0;

        // Nastavi datum vrnitve in status -> Returned
        RentalHeader."Actual Return Date" := Today;
        RentalHeader.Status := RentalHeader.Status::Returned;
        RentalHeader.Modify();

        Message('Kolo je bilo uspešno vrnjeno.');
    end;

    // Preveri, al je stranka prekoračila max aktivnih izposoj
    local procedure CheckMaxActiveRentals(CustomerNo: Code[20])
    var
        Customer: Record Customer;
        RentalHeader: Record "Rental Header";
        ActiveRentalCount: Integer;
    begin
        if CustomerNo = '' then
            exit;

        if not Customer.Get(CustomerNo) then
            exit;

        if Customer."Max Active Rentals" = 0 then
            exit;

        RentalHeader.SetRange("Customer No.", CustomerNo);
        RentalHeader.SetRange(Status, RentalHeader.Status::Active);
        ActiveRentalCount := RentalHeader.Count();

        if ActiveRentalCount >= Customer."Max Active Rentals" then
            Error('Stranka je dosegla max dovoljenih aktivnih izposoj.');
    end;
}