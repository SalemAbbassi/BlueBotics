tableextension 50237 "BBX Sales Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50200; "BBX PackingNos"; code[20])
        {
            caption = 'Packing Nos.';
            TableRelation = "No. Series";
        }
    }
}