pageextension 50255 "BBX Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact"; Rec."BBX Invoicing Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact"; Rec."BBX Logistics Contact")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(SendCustom)
        {
            trigger OnBeforeAction()
            begin
                if Rec.BBXSentByMail then
                    exit;
            end;
        }
    }
}