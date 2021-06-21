pageextension 50251 BBXBlanketPurchaseOrders extends "Blanket Purchase Orders"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BBX Status"; Rec.Status)
            {
                ApplicationArea = All;
            }
            field(BBXDescription; Rec.BBXDescription)
            {
                ApplicationArea = All;
            }
        }
    }
}