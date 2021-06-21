pageextension 50269 "Job Billing Schedule List Ext" extends "DBE Job Billing Schedule List"
{
    layout
    {
        addafter("Item No.")
        {
            field("DBE Sell-to Customer No."; Rec."DBE Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("DBE Sell-to Customer Name"; Rec."DBE Sell-to Customer Name")
            {
                ApplicationArea = All;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Invoiced, false);
    end;
}