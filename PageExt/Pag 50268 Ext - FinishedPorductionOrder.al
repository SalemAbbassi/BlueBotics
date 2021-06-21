pageextension 50268 "BBX Finished Production Order" extends "Finished Production Order"
{
    layout
    {
        addafter("Source No.")
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
            field(BBXKey; Rec.BBXKey)
            {
                ApplicationArea = All;
            }
            field("BBX BootFile"; Rec."BBX BootFile")
            {
                ApplicationArea = All;
            }
            field("BBXTest Date"; Rec."BBXTest Date")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware")
            {
                ApplicationArea = All;
            }
            field("BBX Finished Quantity"; Rec."BBX Finished Quantity")
            {
                ApplicationArea = All;
            }
            field("BBXLink Main Prod. Order No."; Rec."BBXLink Main Prod. Order No.")
            {
                ApplicationArea = All;
            }

        }
    }
}