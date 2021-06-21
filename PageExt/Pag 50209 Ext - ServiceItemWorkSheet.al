pageextension 50209 "BBX ServiceItemWorkSheet" extends "Service Item Worksheet"
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
                    PagLInsertRepairTemplateAct.FctSetParametersFromServiceItemLine(Rec);
                    PagLInsertRepairTemplateAct.LookupMode(true);
                    PagLInsertRepairTemplateAct.RunModal();
                end;
            }
        }
    }

}