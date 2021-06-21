pageextension 50266 "BBX Purchase Order Archives" extends "Purchase Order Archives"
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