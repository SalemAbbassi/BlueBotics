pageextension 50276 "BBX Places" extends "DBE Places"
{
    layout
    {
        addlast(repeatergroup)
        {
            field("BBX Default"; Rec."BBX default")
            {
                ApplicationArea = All;
            }
        }
    }
}