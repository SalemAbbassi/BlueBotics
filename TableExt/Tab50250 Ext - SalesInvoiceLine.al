tableextension 50250 "BBX Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
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
        field(50206; "BBX Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."BBX Expected Delivery Date" where("Document Type" = const(Order),
                                                                            "No." = field("Document No.")));
        }
    }
}