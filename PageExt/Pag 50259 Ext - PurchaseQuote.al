pageextension 50259 "BBX Purchase Quote" extends "Purchase Quote"
{
    layout
    {
        addafter("Order Date")
        {
            field(BBXDescription; Rec.BBXDescription)
            {
                ApplicationArea = All;
            }
        }
    }
}