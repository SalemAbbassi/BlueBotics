pageextension 50226 BBXContactCard extends "Contact Card"
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