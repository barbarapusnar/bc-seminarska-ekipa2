codeunit 50400 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Preveri statuss
        if RentalHeader.Status <> RentalHeader.Status::Open then
            Error('Izposoja more imeti status Open');

        //ali izposoja vsebuje vsaj eno vrstico 
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja nima nobene vrstice');

        // ali so vsa izbrana kolesa na voljo (Status = Available) 
        RentalLine.FindSet();

        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja.', RentalLine."Bicycle No.");

            if Bicycle.Status <> Bicycle.Status::Avalible then
                Error(
                    'Kolo %1 ni na voljo.',
                    Bicycle."No.");

        until RentalLine.Next() = 0;

        // Nastavi bicycle -> Rented
        RentalLine.FindSet();

        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Rented;
            Bicycle.Modify();

        until RentalLine.Next() = 0;

        // Rental -> Active
        RentalHeader.Status := RentalHeader.Status::Active;
        RentalHeader.Modify();

        Message('Izposoja se je začela');
    end;

    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Status mora biti Active
        if RentalHeader.Status <> RentalHeader.Status::Active then
            Error('Izposoja mora imeti aktiven staus');

        // Mora obstajati vsaj ena vrstica
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja nima nobene vrstice');

        // Preveri če vsa kolesa obstajajo
        RentalLine.FindSet();

        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja', RentalLine."Bicycle No.");

        until RentalLine.Next() = 0;

        // Nastavi bicycles -> Available
        RentalLine.FindSet();

        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Avalible;
            Bicycle.Modify();

        until RentalLine.Next() = 0;

        // Nastavi return date
        RentalHeader."Actual Return Date" := Today;

        // Status -> Returned
        RentalHeader.Status := RentalHeader.Status::Returned;

        RentalHeader.Modify();

        Message('Kolo je bilo uspešno vrnjeno');
    end;
}
