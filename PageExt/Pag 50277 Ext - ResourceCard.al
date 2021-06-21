pageextension 50277 "BBX Resource Card" extends "Resource Card"
{
    layout
    {
        addafter(General)
        {
            field("BBX Tak type"; Rec."BBX Task type")
            {
                ApplicationArea = All;
            }
        }
    }
}