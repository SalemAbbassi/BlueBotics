pageextension 50214 "BBX ItemList" extends "Item List"
{
    layout
    {
        addafter(Description)
        {

            field("BBX No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field("BBX Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("BBX Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                ApplicationArea = All;
            }
            field("BBX Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                ApplicationArea = All;
            }
            field("BBX Qty on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("BBX Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
        }
    }

}