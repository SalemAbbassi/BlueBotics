pageextension 50201 "BBX BlanketSalesOrderExt" extends "Blanket Sales Order"
{
    layout
    {
        addbefore("External Document No.")
        {
            field("BBX Effective date"; Rec."BBX Effective date")
            {
                ApplicationArea = all;
            }
            field("BBX Ending Date"; Rec."BBX Ending Date")
            {
                ApplicationArea = All;
            }
            field("BBX Project Manager"; Rec."BBX Project Manager")
            {
                ApplicationArea = All;
            }
            field("BBX Quote No."; Rec."Quote No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("BBX Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
        }
    }
}