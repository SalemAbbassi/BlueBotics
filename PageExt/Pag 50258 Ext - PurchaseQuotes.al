pageextension 50258 "BBX Purchase Quotes" extends "Purchase Quotes"
{
    layout
    {
        addafter("No.")
        {
            field(BBXDescription; Rec.BBXDescription)
            {
                ApplicationArea = All;
            }
        }
    }
}