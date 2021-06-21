pageextension 50224 BBXReleasedProductionOrder extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {

            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            field("BBX BootFile"; Rec."BBX BootFile")
            {
                ApplicationArea = All;
            }
            field(BBXKey; Rec.BBXKey) { ApplicationArea = all; }
            field("BBXTest Date"; Rec."BBXTest Date") { ApplicationArea = all; }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware") { ApplicationArea = all; }
            field("BBXLink Main Prod. Order No."; Rec."BBXLink Main Prod. Order No.") { ApplicationArea = all; }
        }
        addafter("Last Date Modified")
        {
            field("BBX Sales Order No."; Rec."BBX Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("BBX Sell-to Customer No."; Rec."BBX Customer No.")
            {
                ApplicationArea = All;
            }
            field("BBX Sell-to Customer Name"; Rec."BBX Customer Name")
            {
                ApplicationArea = All;
            }
            field("BBX Sticker Code"; Rec."BBX Sticker Code")
            {
                ApplicationArea = All;
            }
        }
    }
}