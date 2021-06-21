tableextension 50216 BBXPurchaseReceiptHeaderExt extends "Purch. Rcpt. Header"
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
        field(50205; BBXConfirmationReceived; Boolean)
        {
            Caption = 'Confirmation Received';
        }
        field(50206; BBXDescription; text[100])
        {
            Caption = 'Description';
        }
    }
}