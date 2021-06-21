pageextension 50254 BBXPostedWhseShipment extends "Posted Whse. Shipment"
{
    layout
    {
        addlast(General)
        {
            field("BBX Parcel 1 Size"; Rec."BBX Parcel 1 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 1 Weight"; Rec."BBX Parcel 1 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 2 Size"; Rec."BBX Parcel 2 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 2 Weight"; Rec."BBX Parcel 2 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 3 Size"; Rec."BBX Parcel 3 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 3 Weight"; Rec."BBX Parcel 3 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 4 Size"; Rec."BBX Parcel 4 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 4 Weight"; Rec."BBX Parcel 4 Weight")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {

            field("BBX Sell-to Customer No."; Rec."BBX Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("BBX Sell-to Customer Name"; Rec."BBX Sell-to Customer Name")
            {
                ApplicationArea = All;
            }
        }

    }
}