pageextension 50229 BBXPostedTransferReceipt extends "Posted Transfer Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BBX Sales Order No."; Rec."BBX Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("BBX Validated"; Rec."BBX Validated")
            {
                ApplicationArea = All;
            }
            field("BBX Validated By"; Rec."BBX Validated By")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}