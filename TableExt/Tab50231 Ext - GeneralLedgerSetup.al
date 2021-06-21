tableextension 50231 BBXGeneralLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        field(50200; "BBX Claim %"; Decimal)
        {
            Caption = 'Claim %';
        }
        field(50201; "BBX Auto. Expense type"; code[20])
        {
            Caption = 'Auto. Expense type';
            TableRelation = "CEM Expense Type".Code;
        }
    }
}