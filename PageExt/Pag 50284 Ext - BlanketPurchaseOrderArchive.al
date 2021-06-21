pageextension 50284 "BBX Blanket Purch. Order Arch." extends "Blanket Purchase Order Archive"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5109),
                              "No." = FIELD("No.");
            }
        }
    }
}