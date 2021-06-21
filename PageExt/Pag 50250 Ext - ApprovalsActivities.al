pageextension 50250 BBXApprovalsActivities extends "Approvals Activities"
{
    layout
    {
        addafter("Requests to Approve")
        {
            // field("BBX Requests to Approve"; Rec."BBX Requests to Approve")
            // {
            //     ApplicationArea = All;
            //     DrillDownPageId = "CEM Approval Entries";
            // }
            field("BBX Requests to Approve"; IntGRequestsToApprove)
            {
                ApplicationArea = All;
                Caption = 'Requests to Approve';
                /*trigger OnDrillDown()
                var
                    TempRecCEMApprovalEntry: Record "CEM Approval Entry" temporary;
                    PagLCEMApprovalEntries: Page "CEM Approval Entries";
                    CduLEmApprovalMgnt: Codeunit "CEM Approval Management";
                begin
                    TempRecCEMApprovalEntry.DeleteAll();
                    CduLEmApprovalMgnt.BuildApprovalEntriesForUserExp(TempRecCEMApprovalEntry, TRUE, TRUE, FALSE);
                    TempRecCEMApprovalEntry.SetRange("Approver ID", Rec."User ID Filter");
                    PagLCEMApprovalEntries.LookupMode(true);
                    PagLCEMApprovalEntries.SetTableView(TempRecCEMApprovalEntry);
                    PagLCEMApprovalEntries.RunModal();
                end;*/
            }
        }
    }
    var
        IntGRequestsToApprove: Integer;

    trigger OnAfterGetRecord()
    begin
        IntGRequestsToApprove := Rec.GetRequesToApproveNumber();
    end;
}