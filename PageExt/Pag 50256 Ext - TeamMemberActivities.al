pageextension 50256 "BBX Team Member ActivitiesExt" extends "Team Member Activities"
{
    layout
    {
        addafter("Pending Time Sheets")
        {
            cuegroup("BBX Settlmenet Activities")
            {
                Caption = 'Settlement Activities';
                field("BBX Settlement In Progress"; IntGSettlmentInProgress)
                {
                    Caption = 'Settlement In Progress';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownSettlments(1);
                    end;
                }

                field("BBX Posted Settlement"; IntGPostedSettlement)
                {
                    Caption = 'My Posted Settlement';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownSettlments(2);
                    end;
                }
                field("BBX Approved Settlement"; IntGApprovedSettlement)
                {
                    Caption = 'Approved Settlement';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownSettlments(3);
                    end;
                }
            }
            cuegroup("BBX Job Time Activities")
            {
                Caption = 'Entring Job Times Activities';
                field("BBX Non Posted Times"; IntGNonPostedTimes)
                {
                    Caption = 'Non Posted Times';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                    begin
                        OnDrillDownTimes(false);
                    end;
                }
                field("BBX Posted Times"; IntGPostedTimes)
                {
                    Caption = 'Posted Times';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                    begin
                        OnDrillDownTimes(true);
                    end;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        FctCalculSettlments();
        FctCalcTimes();
    end;

    var
        IntGSettlmentInProgress: Integer;
        IntGPostedSettlement: Integer;
        IntGNonPostedTimes: Integer;
        IntGPostedTimes: Integer;
        IntGApprovedSettlement: Integer;

    local procedure FctCalculSettlments()
    var
        RecLCEMExpenseHeader: Record "CEM Expense Header";
    begin
        //Calc InProgress Settlement
        IntGSettlmentInProgress := 0;
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserId);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        RecLCEMExpenseHeader.SetRange(Posted, false);
        If RecLCEMExpenseHeader.FindSet() then
            repeat
                IntGSettlmentInProgress += 1
            until RecLCEMExpenseHeader.Next() = 0;

        //Calc Posted Settlement
        IntGPostedSettlement := 0;
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserId);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        RecLCEMExpenseHeader.SetRange(Posted, true);
        If RecLCEMExpenseHeader.FindSet() then
            repeat
                IntGPostedSettlement += 1
            until RecLCEMExpenseHeader.Next() = 0;

        //Calc Approved Settlement
        IntGApprovedSettlement := 0;
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserId);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        RecLCEMExpenseHeader.SetRange(Posted, true);
        If RecLCEMExpenseHeader.FindSet() then
            repeat
                IntGApprovedSettlement += 1
            until RecLCEMExpenseHeader.Next() = 0;
    end;

    local procedure FctCalcTimes()
    var
        RecLJobPlanningLine: Record "Job Planning Line";
    begin
        //Calc Non Posted Times
        IntGNonPostedTimes := 0;
        RecLJobPlanningLine.SetRange("User ID", UserId);
        RecLJobPlanningLine.SetRange("Qty. Posted", 0);
        RecLJobPlanningLine.SetFilter("Planning Date", '%1..%2', CALCDATE('<-CM>', Today), CALCDATE('<-CM>', Today));
        if RecLJobPlanningLine.FindSet() then
            repeat
                IntGNonPostedTimes += 1;
            until RecLJobPlanningLine.Next() = 0;

        //Calc Posted Times
        IntGPostedTimes := 0;
        RecLJobPlanningLine.Reset();
        RecLJobPlanningLine.SetRange("User ID", UserId);
        RecLJobPlanningLine.SetFilter("Qty. Posted", '<>%1', 0);
        RecLJobPlanningLine.SetFilter("Planning Date", '%1..%2', CALCDATE('<-CM>', Today), CALCDATE('<-CM>', Today));
        if RecLJobPlanningLine.FindSet() then
            repeat
                IntGPostedTimes += 1;
            until RecLJobPlanningLine.Next() = 0;
    end;

    local procedure OnDrillDownSettlments(IntGValue: Integer)
    var
        PagLCEMSettelmentList: Page "CEM Settlement List";
        PagLCEMPostedettlementList: Page "CEM Posted Settlement List";
        RecLCEMExpenseHeader: Record "CEM Expense Header";
    begin
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserId);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        case IntGValue of
            1:
                RecLCEMExpenseHeader.SetRange(Posted, true);
            2, 3:
                RecLCEMExpenseHeader.SetRange(Posted, false);
        end;
        if IntGValue = 3 then begin
            PagLCEMPostedettlementList.SetTableView(RecLCEMExpenseHeader);
            PagLCEMPostedettlementList.RunModal();
        end else begin
            PagLCEMSettelmentList.SetTableView(RecLCEMExpenseHeader);
            PagLCEMSettelmentList.RunModal();
        end;
    end;

    local procedure OnDrillDownTimes(BooPPostedTimes: Boolean)
    var
        PagLDBEEnteringJobtimes: Page "DBE Entering Job times";
        RecLJobPlanningLine: Record "Job Planning Line";
    begin
        RecLJobPlanningLine.Reset();
        RecLJobPlanningLine.SetRange("User ID", UserId);
        RecLJobPlanningLine.SetFilter("Planning Date", '%1..%2', CALCDATE('<-CM>', Today), CALCDATE('<-CM>', Today));
        case BooPPostedTimes of
            false:
                RecLJobPlanningLine.SetRange("Qty. Posted", 0);
            true:
                RecLJobPlanningLine.SetFilter("Qty. Posted", '<>%1', 0);
        end;
        PagLDBEEnteringJobtimes.SetTableView(RecLJobPlanningLine);
        PagLDBEEnteringJobtimes.RunModal();
    end;
}