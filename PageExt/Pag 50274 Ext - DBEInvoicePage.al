pageextension 50274 "BBX Invoice Page" extends "DBE Invoice Page"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify("Times Sheet")
        {
            Visible = false;
        }
        addafter("Times Sheet")
        {
            action("BBX Times Sheet")
            {
                ApplicationArea = all;
                Caption = 'Times Sheet';
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction();
                var
                    RecLJob: Record Job;
                    PlanItSetup: record "DBE Plan It Setup";
                begin
                    PlanItSetup.get;
                    PlanItSetup.TestField("Default Starting Inv Period");
                    PlanItSetup.TestField("Default Ending Inv Period");
                    RecLJob.SetRange("No.", Rec."Job No.");
                    //RecLJob.SETRECFILTER;
                    RecLJob.SETFILTER("Planning Date Filter", FORMAT(CALCDATE(PlanItSetup."Default Starting Inv Period", TODAY)) + '..' + FORMAT(CALCDATE(PlanItSetup."Default Ending Inv Period", TODAY)));
                    REPORT.RUN(REPORT::"BBX Times Sheet", true, false, RecLJob);
                end;
            }
        }
    }

    var
        myInt: Integer;
}