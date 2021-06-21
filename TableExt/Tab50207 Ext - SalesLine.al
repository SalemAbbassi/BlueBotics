tableextension 50207 BBXSalesLineExt extends "Sales Line"
{
    fields
    {
        //>>VTE-Gap01
        field(50200; "BBX Task Type"; Code[20])
        {
            Caption = 'Task Type';
            TableRelation = "BBX Task Types".Code;
        }
        field(50204; "BBX Effective date"; Date)
        {
            Caption = 'Effective date';
        }
        field(50205; "BBX Due Date"; Date)
        {
            Caption = 'Due date';
        }
        //<<VTE-Gap01
        field(50206; "BBX Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."BBX Expected Delivery Date" where("Document Type" = const(Order),
                                                                            "No." = field("Document No.")));
        }
    }

    procedure FctBlanketSalesOrderExist(): Boolean
    var
        RecLSalesLines: Record "Sales Line";
    begin
        RecLSalesLines.SetRange("Document Type", RecLSalesLines."Document Type"::"Blanket Order");
        RecLSalesLines.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
        RecLSalesLines.SetRange("No.", "No.");
        if RecLSalesLines.FindFirst() then
            exit(true);
        exit(false);
    end;
}