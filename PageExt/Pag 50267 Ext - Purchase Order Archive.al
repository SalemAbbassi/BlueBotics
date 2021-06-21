pageextension 50267 "BBX Purchase Order Archive" extends "Purchase Order Archive"
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