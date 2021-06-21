pageextension 50206 "BBX SerialNoInformationCardExt" extends "Serial No. Information Card"
{
    layout
    {
        addafter(General)
        {
            //>>PRO-GC22
            field("BBX BootFile"; Rec."BBX BootFile")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            //<<PRO-GC22
            field(BBXKey; Rec.BBXKey)
            {
                ApplicationArea = All;
            }
            field("BBXTest Date"; Rec."BBXTest Date")
            {
                ApplicationArea = All;
            }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware")
            {
                ApplicationArea = All;
            }
            field("BBX License No."; Rec."BBX License No.")
            {
                ApplicationArea = All;
            }
            field("BBX Installation Name"; Rec."BBX Installation Name")
            {
                ApplicationArea = All;
            }
            field("BBX Installation Address"; Rec."BBX Installation Address")
            {
                ApplicationArea = All;
            }
            field("BBX Quantity Of Vehicles"; Rec."BBX Quantity Of Vehicles")
            {
                ApplicationArea = All;
            }
            field("BBX Requested By"; Rec."BBX Requested By")
            {
                ApplicationArea = All;
            }

        }
    }
}