pageextension 50232 BBXGeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        addafter(SEPANonEuroExport)
        {
            field("BBX Claim %"; Rec."BBX Claim %") { ApplicationArea = All; }

            field("BBX Auto. Expense type"; Rec."BBX Auto. Expense type") { ApplicationArea = All; }
        }
    }
}