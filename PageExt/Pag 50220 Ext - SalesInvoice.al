pageextension 50220 "BBX SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("BBX Partner"; Rec."BBX Partner")
            {
                ApplicationArea = All;
            }
        }
    }
}