pageextension 50245 "BBX Sales Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("BBX PackingNos"; Rec."BBX PackingNos")
            {
                ApplicationArea = all;
            }
        }
    }
}