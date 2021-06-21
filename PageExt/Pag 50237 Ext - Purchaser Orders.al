pageextension 50237 "BBX Purchase Orders" extends "purchase list"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("BBX No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("BBX Expected delivery date"; Rec."BBX Expected delivery date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}