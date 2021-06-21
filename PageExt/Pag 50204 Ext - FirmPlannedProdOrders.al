pageextension 50204 "BBX FirmPlannedProdOrdersExt" extends "Firm Planned Prod. Orders"
{
    layout
    {
        //>>PRO-GC22
        addlast(Control1)
        {
            field("BBX BootFile"; Rec."BBX BootFile")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            field(BBXKey; Rec.BBXKey) { ApplicationArea = all; }
            field("BBXTest Date"; Rec."BBXTest Date") { ApplicationArea = all; }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware") { ApplicationArea = all; }
            field("BBXLink Main Prod. Order No."; Rec."BBXLink Main Prod. Order No.") { ApplicationArea = all; }
        }
        addafter(Description)
        {
            field("BBX Sales Order No."; Rec."BBX Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("BBX Customer No."; Rec."BBX Customer No.")
            {
                ApplicationArea = All;
            }
            field("BBX Customer Name"; Rec."BBX Customer Name")
            {
                ApplicationArea = All;
            }

        }
        //<<PRO-GC22
    }
}