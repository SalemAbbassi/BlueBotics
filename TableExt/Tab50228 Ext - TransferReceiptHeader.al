tableextension 50228 BBXTransferReceiptHeader extends "Transfer Receipt Header"
{
    fields
    {
        field(50200; "BBX Validated By"; Code[20])
        {
            Caption = 'Validated By';
            TableRelation = "User Setup"."User ID";
        }
        field(50201; "BBX Validated"; Boolean)
        {
            Caption = 'Validated';
        }
        field(50202; "BBX Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
    }
}