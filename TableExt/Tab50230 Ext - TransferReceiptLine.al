tableextension 50230 BBXTransferReceiptLine extends "Transfer Receipt Line"
{
    fields
    {
        field(50200; "BBX Sales Line No."; Integer)
        {
            Caption = 'DBE Sales Line No.';
        }
        field(50201; "BBX Value"; Decimal)
        {
            Caption = 'Value';
        }
        field(50202; "BBX Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
    }
}