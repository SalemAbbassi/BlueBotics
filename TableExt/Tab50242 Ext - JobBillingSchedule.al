tableextension 50242 "Job Billing Schedule Ext" extends "DBE Job Billing Schedule"
{
    fields
    {
        field(50100; "DBE Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer No." where("Document Type" = const(Order),
                                                                            "No." = field("Sales Order No.")));
        }
        field(50101; "DBE Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("DBE Sell-to Customer No.")));
        }
    }
}