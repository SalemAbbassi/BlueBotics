pageextension 50278 "BBX Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("BBX Task Type"; Rec."BBX Task Type")
            {
                ApplicationArea = All;
            }
        }
    }
}