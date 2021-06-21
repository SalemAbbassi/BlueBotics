tableextension 50219 BBXPurchaseHeaderArchiveExt extends "Purchase Header Archive"
{
    fields
    {
        field(50200; "BBX Quotation Date"; Date)
        {
            Caption = 'Quotation Date';
        }
        field(50201; "BBX Approved By"; Code[50])
        {
            Caption = 'Approved By';
        }
        field(50202; BBXSentByMail; Boolean)
        {
            Caption = 'Sent by Mail';
        }
        field(50205; BBXConfirmationReceived; Boolean)
        {
            Caption = 'Confirmation Received';
        }
        field(50206; BBXDescription; text[100])
        {
            Caption = 'Description';
        }
        field(50207; "BBX Expected delivery date"; Date)
        {
            Caption = 'Expected delivery date';
        }
    }
}