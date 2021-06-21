tableextension 50213 BBXServiceItemExt extends "Service Item"
{
    fields
    {
        //>>PRO-GC22
        field(50200; "BBX BootFile"; Text[100])
        {
            Caption = 'BootFile';
            ObsoleteState = Removed;
        }
        field(50201; "BBX Customer ID"; Text[100])
        {
            Caption = 'Customer ID';
            ObsoleteState = Removed;
        }
        //<<PRO-GC22
        field(50202; "BBX Boot File"; Text[100])
        {
            Caption = 'BootFile';
            FieldClass = FlowField;
            CalcFormula = lookup("Serial No. Information"."BBX BootFile" where("Item No." = field("Item No."),
                                                                                "Serial No." = field("Serial No.")));
        }
        field(50203; "BBX CustomerID"; Text[100])
        {
            Caption = 'Customer ID';
            FieldClass = FlowField;
            CalcFormula = lookup("Serial No. Information"."BBX Customer ID" where("Item No." = field("Item No."),
                                                                                "Serial No." = field("Serial No.")));
        }
        field(50204; "BBX IO Board Firmware"; Text[50])
        {
            Caption = 'IO Board Firmware';
            FieldClass = FlowField;
            CalcFormula = lookup("Serial No. Information"."BBXIO Board Firmware" where("Item No." = field("Item No."),
                                                                                "Serial No." = field("Serial No.")));
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
            ObsoleteState = Pending;
        }
    }
}