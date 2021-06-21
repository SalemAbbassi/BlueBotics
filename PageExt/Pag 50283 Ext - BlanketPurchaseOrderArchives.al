pageextension 50283 "BBX Blanket Purch. Order Archs" extends "Blanket Purch. Order Archives"
{
    layout
    {
        addfirst(Control29)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            field(BBXDescription; Rec.BBXDescription)
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
                SubPageLink = "Table ID" = CONST(5109),
                              "No." = FIELD("No.");
            }
        }
    }
}