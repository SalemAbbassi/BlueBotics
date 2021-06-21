pageextension 50225 BBXConfigTemplates extends "Config Templates"
{
    layout
    {
        addfirst(Repeater)
        {
            field("BBX Code"; Rec.Code)
            {
                ApplicationArea = All;
            }
        }
    }
}