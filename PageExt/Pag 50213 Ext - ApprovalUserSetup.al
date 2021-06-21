pageextension 50213 "BBX ApprovalUserSetupExt" extends "Approval User Setup"
{
    layout
    {
        addfirst(factboxes)
        {
            part("BBX Signature Factbox"; "BBX Signature Factbox")
            {
                ApplicationArea = all;
            }
        }
    }
}