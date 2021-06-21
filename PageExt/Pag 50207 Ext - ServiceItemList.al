pageextension 50207 "BBX ServiceItemListExt" extends "Service Item List"
{
    layout
    {
        addlast(Control1)
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
            field("BBX IO Board Firmware"; Rec."BBX IO Board Firmware")
            {
                ApplicationArea = All;
            }
            //<<PRO-GC22
        }
    }
}