enum 50400 "Bicycle Status"
{
    Extensible = true;

    value(0; Avalible)
    {
        Caption = 'Na Voljo';
    }
    value(1; Rented)
    {
        Caption = 'Izposojeno';
    }
    value(2; Maintenance)
    {
        Caption = 'Na servisu';
    }
    value(3; Retired)
    {
        Caption = 'Izločeno';
    }
}
