pageextension 50248 BBXJobTaskLinesSubform extends "Job Task Lines Subform"
{
    layout
    {
        modify(Status)
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("BBX New Status"; Rec."BBX New Status")
            {
                ApplicationArea = All;
            }
            field("BBX Standby From"; Rec."BBX Standby From")
            {
                ApplicationArea = All;
            }
            field("BBX Task Type"; Rec."BBX Task Type")
            {
                ApplicationArea = All;
            }
        }
    }
}