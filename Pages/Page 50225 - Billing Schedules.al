page 50225 "BBX Billing Schedules Activ."
{
    Caption = 'Billing Schedules Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Approvals Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Billing Schedules")
            {
                field(IntGCurrBSCount; IntGCurrBSCount)
                {
                    ApplicationArea = All;
                    Caption = 'Current Billing Schedules';
                    trigger OnDrillDown()
                    var
                        RecLDBEJobBillingSchedule: Record "DBE Job Billing Schedule";
                        PagLDBEJobBillingScheduleList: Page "DBE Job Billing Schedule List";
                    begin
                        RecLDBEJobBillingSchedule.SetFilter(Date, '%1..%2', CALCDATE('<CM+1D-1M>', Today), CALCDATE('<CM>', Today));
                        RecLDBEJobBillingSchedule.SetFilter(Invoiced, '%1', false);
                        PagLDBEJobBillingScheduleList.SetTableView(RecLDBEJobBillingSchedule);
                        PagLDBEJobBillingScheduleList.LookupMode(true);
                        PagLDBEJobBillingScheduleList.RunModal();
                    end;
                }
                field(IntGPrevBSCount; IntGPrevBSCount)
                {
                    ApplicationArea = All;
                    Caption = 'Previous Billing Schedules';
                    trigger OnDrillDown()
                    var
                        RecLDBEJobBillingSchedule: Record "DBE Job Billing Schedule";
                        PagLDBEJobBillingScheduleList: Page "DBE Job Billing Schedule List";
                    begin
                        RecLDBEJobBillingSchedule.SetFilter(Date, '<%1', Today);
                        RecLDBEJobBillingSchedule.SetFilter(Invoiced, '%1', false);
                        PagLDBEJobBillingScheduleList.SetTableView(RecLDBEJobBillingSchedule);
                        PagLDBEJobBillingScheduleList.LookupMode(true);
                        PagLDBEJobBillingScheduleList.RunModal();
                    end;
                }
                field(IntGNextBSCount; IntGNextBSCount)
                {
                    ApplicationArea = All;
                    Caption = 'Next Billing Schedules';
                    trigger OnDrillDown()
                    var
                        RecLDBEJobBillingSchedule: Record "DBE Job Billing Schedule";
                        PagLDBEJobBillingScheduleList: Page "DBE Job Billing Schedule List";
                    begin
                        RecLDBEJobBillingSchedule.SetFilter(Date, '>%1', Today);
                        RecLDBEJobBillingSchedule.SetFilter(Invoiced, '%1', false);
                        PagLDBEJobBillingScheduleList.SetTableView(RecLDBEJobBillingSchedule);
                        PagLDBEJobBillingScheduleList.LookupMode(true);
                        PagLDBEJobBillingScheduleList.RunModal();
                    end;
                }
                field("DBE Requests to Approve"; Rec."BBX Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "CEM Approval Entries";
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        RecLDBEJobBillingSchedule: Record "DBE Job Billing Schedule";
    begin
        RecLDBEJobBillingSchedule.SetRange(Invoiced, false);
        RecLDBEJobBillingSchedule.SetFilter(Date, '>%1', Today);
        IntGNextBSCount := RecLDBEJobBillingSchedule.Count;
        RecLDBEJobBillingSchedule.SetFilter(Date, '<%1', Today);
        IntGPrevBSCount := RecLDBEJobBillingSchedule.Count;
        RecLDBEJobBillingSchedule.SetFilter(Date, '%1..%2', CALCDATE('<CM+1D-1M>', Today), CALCDATE('<CM>', Today));
        IntGCurrBSCount := RecLDBEJobBillingSchedule.Count;
    end;

    var
        IntGPrevBSCount: Integer;
        IntGNextBSCount: Integer;
        IntGCurrBSCount: Integer;
}