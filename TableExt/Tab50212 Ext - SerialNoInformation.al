tableextension 50212 BBXSerialNoInformationExt extends "Serial No. Information"
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
        field(50202; "BBX License No."; Text[50])
        {
            Caption = 'License No.';
            TableRelation = "License Information";
        }
        field(50203; "BBX Installation Name"; Text[100])
        {
            Caption = 'Installation Name ';
        }
        field(50204; "BBX Installation Address"; Text[250])
        {
            Caption = 'Installation Address';
        }
        field(50205; "BBX Quantity Of Vehicles"; Integer)
        {
            Caption = 'Quantity Of Vehicles';
        }
        field(50206; "BBX Requested By"; Text[150])
        {
            Caption = 'Requested By';
        }
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