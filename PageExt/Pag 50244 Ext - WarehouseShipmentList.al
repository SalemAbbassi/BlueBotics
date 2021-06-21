pageextension 50244 "BBX Warehouse Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addafter("Location Code")
        {

            field("BBX Source No."; Rec."BBX Source No.")
            {
                Caption = 'Sales Order No.';
                ApplicationArea = All;
            }
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