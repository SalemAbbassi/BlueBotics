pageextension 50265 "BBX Business Manager RC" extends "Business Manager Role Center"
{
    layout
    {
        addafter(ApprovalsActivities)
        {
            part("Billing Schedules Activ."; "BBX Billing Schedules Activ.")
            {
                ApplicationArea = Suite;
                Caption = '';
            }
        }
    }
}