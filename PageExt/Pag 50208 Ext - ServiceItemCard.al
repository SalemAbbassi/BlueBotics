pageextension 50208 "BBX ServiceItemCard" extends "Service Item Card"
{
    layout
    {
        addlast(General)
        {
            //>>PRO-GC22
            field("BBX BootFile"; Rec."BBX Boot File")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX CustomerID")
            {
                ApplicationArea = All;
            }
            //<<PRO-GC22
            field("BBX IO Board Firmware"; Rec."BBX IO Board Firmware")
            {
                ApplicationArea = All;
            }
        }
    }
}