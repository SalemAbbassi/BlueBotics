pageextension 50282 "BBX Sales Order Arvhices" extends "Sales Order Archives"
{
    layout
    {
        addafter("No.")
        {
            field("DBE Job No."; Rec."DBE Job No.")
            {
                ApplicationArea = all;
            }
            field("DBE Job Description"; Rec."DBE Job Description")
            {
                ApplicationArea = all;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = all;
            }
        }
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5159),
                              "No." = FIELD("No.");
            }
        }
    }
}