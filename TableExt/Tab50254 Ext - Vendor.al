tableextension 50254 "BBX Vendor" extends Vendor
{
    fields
    {
        field(50200; "BBX IOSS"; Code[20])
        {
            Caption = 'IOSS';
        }
    }

    var
        myInt: Integer;
}