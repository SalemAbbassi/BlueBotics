pageextension 50222 "BBXPlanned Production Order" extends "Planned Production Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Source No.")
        {
            field("BBXLink Main Prod. Order No."; Rec."BBXLink Main Prod. Order No.")
            {
                ApplicationArea = all;
                Editable = false;
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