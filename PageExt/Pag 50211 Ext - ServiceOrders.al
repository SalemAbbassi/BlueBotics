pageextension 50211 "BBX ServiceOrdersExt" extends "Service Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("BBX Freshdesk Description"; Rec."BBX Freshdesk Description")
            {
                ApplicationArea = All;
                ToolTip = 'Description coming from Freshdesk.';
            }
            field("BBX Work performed"; Rec."BBX Work performed")
            {
                ApplicationArea = All;
                ToolTip = 'Description of the work done';
            }
        }
    }
}