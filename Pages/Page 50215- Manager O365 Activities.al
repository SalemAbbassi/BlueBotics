page 50215 "BBX Manager O365 Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Ongoing Purchases")
            {

                Caption = 'Ongoing Purchases';
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies purchases orders that are not posted or only partially posted.';
                }
                field("Purch. Invoices Due Next Week"; Rec."Purch. Invoices Due Next Week")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of payments to vendors that are due next week.';
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the number of approval requests that require your approval.';
                }
            }
            cuegroup("BBX Settlmenet Activities")
            {
                Caption = 'Settlement Activities';
                field("BBX Settlement In Progress"; IntGSettlmentInProgress)
                {
                    Caption = 'Settlement In Progress';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownSettlments(false);
                    end;
                }

                field("BBX Posted Settlement"; IntGPostedSettlement)
                {
                    Caption = 'Posted Settlement';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownSettlments(true);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshData)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refreshes the data needed to make complex calculations.';

                trigger OnAction()
                begin
                    Rec."Last Date/Time Modified" := 0DT;
                    Rec.Modify;

                    CODEUNIT.Run(CODEUNIT::"Activities Mgt.");
                    CurrPage.Update(false);
                end;
            }
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }
    /*trigger OnOpenPage()
    begin
        FctCalculSettlments();
    end;*/
    trigger OnAfterGetCurrRecord()
    begin
        FctCalculSettlments();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        IntGSettlmentInProgress: Integer;
        IntGPostedSettlement: Integer;

    local procedure FctCalculSettlments()
    var
        RecLCEMExpenseHeader: Record "CEM Expense Header";
    begin
        //Calc InProgress Settlement
        IntGSettlmentInProgress := 0;
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserID);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        RecLCEMExpenseHeader.SetRange(Posted, false);
        If RecLCEMExpenseHeader.FindSet() then
            repeat
                IntGSettlmentInProgress += 1
            until RecLCEMExpenseHeader.Next() = 0;

        //Calc Posted Settlement
        IntGPostedSettlement := 0;
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserID);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        RecLCEMExpenseHeader.SetRange(Posted, true);
        If RecLCEMExpenseHeader.FindSet() then
            repeat
                IntGPostedSettlement += 1
            until RecLCEMExpenseHeader.Next() = 0;
    end;

    local procedure OnDrillDownSettlments(BooPPostedSettlment: Boolean)
    var
        PagLCEMSettelmentList: Page "CEM Settlement List";
        PagLCEMPostedSettemnetList: Page "CEM Posted Settlement List";
        RecLCEMExpenseHeader: Record "CEM Expense Header";
    begin
        RecLCEMExpenseHeader.Reset();
        RecLCEMExpenseHeader.SetRange("Continia User ID", UserID);
        RecLCEMExpenseHeader.SetRange("Document Type", RecLCEMExpenseHeader."Document Type"::Settlement);
        if BooPPostedSettlment then begin
            RecLCEMExpenseHeader.SetRange(Posted, true);
            PagLCEMPostedSettemnetList.SetTableView(RecLCEMExpenseHeader);
            PagLCEMPostedSettemnetList.RunModal();
        end else begin
            RecLCEMExpenseHeader.SetRange(Posted, false);
            PagLCEMSettelmentList.SetTableView(RecLCEMExpenseHeader);
            PagLCEMSettelmentList.RunModal();
        end;
    end;
}