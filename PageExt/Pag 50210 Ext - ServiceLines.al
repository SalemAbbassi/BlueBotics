pageextension 50210 "BBX ServiceLinesExt" extends "Service Lines"
{

    actions
    {
        addlast("F&unctions")
        {
            action("BBX InsertTemplateActivities")
            {
                ApplicationArea = All;
                Caption = 'Insert Template Activities';
                Image = Insert;
                trigger OnAction()
                var
                    PagLInsertRepairTemplateAct: Page "BBX Insert Repair Template Act";
                begin
                    PagLInsertRepairTemplateAct.FctSetParametersFromServiceLine(Rec);
                    PagLInsertRepairTemplateAct.LookupMode(true);
                    PagLInsertRepairTemplateAct.RunModal();
                end;
            }
        }
    }
}