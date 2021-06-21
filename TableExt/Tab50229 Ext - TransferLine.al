tableextension 50229 BBXTransferLine extends "Transfer Line"
{
    fields
    {
        field(50200; "BBX Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            trigger OnLookup()
            var
                RecLTranferHeader: Record "Transfer Header";
                RecLSalesLine: Record "Sales Line";
            begin
                if RecLTranferHeader.Get("Document No.") then begin
                    RecLTranferHeader.TestField("BBX Sales Order No.");
                    RecLSalesLine.SetRange("Document Type", RecLSalesLine."Document Type"::Order);
                    RecLSalesLine.SetRange("Document No.", RecLTranferHeader."BBX Sales Order No.");
                    if RecLSalesLine.FindSet() then
                        if Page.RunModal(Page::"Sales Lines", RecLSalesLine) = Action::LookupOK then
                            Validate("BBX Sales Line No.", RecLSalesLine."Line No.");
                end;
            end;
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