pageextension 50262 "BBX Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Last Issued Reminder Level"; Rec."Last Issued Reminder Level")
            {
                ApplicationArea = All;
            }
        }
    }
}