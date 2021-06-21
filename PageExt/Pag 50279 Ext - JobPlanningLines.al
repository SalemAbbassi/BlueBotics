pageextension 50279 "BBX Job Planning Lines" extends "Job Planning Lines"
{
    layout
    {
        addafter(Description)
        {
            field("BBX Task Type"; Rec."BBX Task Type")
            {
                ApplicationArea = All;
            }
        }
    }
}