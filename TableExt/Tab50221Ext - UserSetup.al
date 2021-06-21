tableextension 50221 BBXUserSetupExt extends "User Setup"
{
    fields
    {
        field(50200; "BBX Signature"; MediaSet)
        {
            Caption = 'Signature';
        }
        field(50201; "BBX Full Name"; Text[80])
        {
            Caption = 'Full Name';
        }
        field(50202; "BBX Signatory PROFORMA"; Boolean)
        {
            Caption = 'Signatory PROFORMA';
        }
    }
}