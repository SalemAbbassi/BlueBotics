tableextension 50239 BBXApprovalsActivitiesCue extends "Approvals Activities Cue"
{
    fields
    {
        field(50200; "BBX Requests to Approve"; Integer)
        {
            CalcFormula = Count("CEM Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
            ObsoleteState = Pending;
        }
    }
    procedure GetRequesToApproveNumber(): Integer
    var
        TempLCEMApprovalEntry: Record "CEM Approval Entry";
        CduLEmApprovalMgnt: Codeunit "CEM Approval Management";
    begin
        /*TempLCEMApprovalEntry.DeleteAll();
        CduLEmApprovalMgnt.BuildApprovalEntriesForUserExp(TempLCEMApprovalEntry, TRUE, TRUE, FALSE);
        exit(TempLCEMApprovalEntry.Count);*/
    end;
}