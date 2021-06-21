pageextension 50240 "BBX Released Production Orders" extends "Released Production Orders"
{
    layout
    {
        addafter(Description)
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
        }
        addafter(Quantity)
        {
            field("BBX Finished Quantity"; Rec."BBX Finished Quantity")
            {
                ApplicationArea = All;
            }
        }
    }
}