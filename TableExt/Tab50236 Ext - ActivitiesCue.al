tableextension 50236 "BBX Activities Cue" extends "Activities Cue"
{
    fields
    {
        field(50200; "BBX PO All"; Integer)
        {
            Caption = 'PO All';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order)));
        }
        field(50201; "BBX PO Pending Approval"; Integer)
        {
            Caption = 'PO Pending Approval';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order),
                                                        Status = CONST("Pending Approval")));
        }
        field(50202; "BBX PO Not Sent Yet"; Integer)
        {
            Caption = 'PO Not Sent Yet';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order),
                                                        BBXSentByMail = const(false)));
        }
        field(50203; "BBX PO Partially Received"; Integer)
        {
            Caption = 'PO Partially Received';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order),
                                                        Receive = const(true),
                                                        "Completely Received" = const(false)));
        }
        field(50204; "BBX PO Completely Received"; Integer)
        {
            Caption = 'PO Completely Received';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order),
                                                        Status = const(Released),
                                                        "Completely Received" = const(true)));
        }
        field(50205; "BBX PO Not Received"; Integer)
        {
            Caption = 'PO No Received';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = const(Order),
                                                        Receive = const(false)));
        }
    }
}