tableextension 50255 "BBX Transfer Shipment Line" extends "Transfer Shipment Line"
{
    fields
    {
        field(50200; "BBX Value"; Decimal)
        {
            Caption = 'Value';
        }
        field(50201; "BBX Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
    }
}