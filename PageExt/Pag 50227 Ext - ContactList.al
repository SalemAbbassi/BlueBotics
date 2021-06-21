pageextension 50227 BBXContactList extends "Contact List"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("BBX Job Title"; Rec."Job Title")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}