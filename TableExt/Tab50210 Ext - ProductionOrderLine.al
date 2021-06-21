tableextension 50210 BBXProductionOrderLineExt extends "Prod. Order Line"
{
    fields
    {
        //>>PRO-GC22
        field(50200; "BBX BootFile"; Text[100])
        {
            Caption = 'BootFile';
        }
        field(50201; "BBX Customer ID"; Text[100])
        {
            Caption = 'Customer ID';
        }
        //<<PRO-GC22

        field(50250; "BBXKey"; text[100])
        {
            Caption = 'Key';
        }
        field(50251; "BBXTest Date"; Date)
        {
            Caption = 'Test Date';
        }
        field(50252; "BBXIO Board Firmware"; Text[50])
        {
            Caption = 'IO Board Firmware';
        }
    }
}