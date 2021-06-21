pageextension 50257 "BBX Posted Whse. Shipment List" extends "Posted Whse. Shipment List"
{
    layout
    {
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