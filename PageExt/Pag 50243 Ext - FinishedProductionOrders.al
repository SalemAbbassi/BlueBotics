pageextension 50243 "BBX Finished Production Orders" extends "Finished Production Orders"
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

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}