tableextension 50232 BBXExpense extends "CEM Expense"
{
    fields
    {
        // Add changes to table fields here
        field(50200; BBXClaimPercentSystem; Boolean)
        {
            Caption = 'Claim Percent System';
        }
    }

    var
        myInt: Integer;
}