pageextension 50287 "BBX PostedTransferShptSubform" extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {

            field("BBX Value"; Rec."BBX Value")
            {
                ToolTip = 'Specifies the value of the Value field';
                ApplicationArea = All;
            }
            field("BBX Currency Code"; Rec."BBX Currency Code")
            {
                ToolTip = 'Specifies the value of the Currency Code field';
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