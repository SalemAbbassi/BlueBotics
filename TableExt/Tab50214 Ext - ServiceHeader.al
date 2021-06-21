tableextension 50214 BBXServiceHeaderExt extends "Service Header"
{
    fields
    {
        field(50201; "BBX Freshdesk Description"; Text[200])
        {
            Caption = 'Initial feedback';
        }
        field(50202; "BBX Work performed"; Text[200])
        {
            Caption = 'Work performed:';
        }
        field(50203; "BBX Analysis BlueBotics"; Text[250])
        {
            Caption = 'Analysis BlueBotics';
        }
    }
}