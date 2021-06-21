pageextension 50280 "BBX Payment Journal FactBox" extends "Payment Journal FactBox"
{
    layout
    {
        addafter(TotalPayment)
        {
            field(DecGTotalPayAmountFCY; DecGTotalPayAmountFCY)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Payments FCY';
                Editable = false;
                ToolTip = 'Specifies the total of payments in FCY.';
            }
        }
    }

    var
        DecGTotalPayAmountFCY: Decimal;

    trigger OnAfterGetRecord()
    begin
        FctGetBalance();
    end;


    procedure FctGetBalance()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.SetRange("Account Type", GenJnlLine."Account Type"::Vendor);
        GenJnlLine.SetFilter("Document Type", '%1|%2', GenJnlLine."Document Type"::Payment, GenJnlLine."Document Type"::Refund);
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Line No.");
        GenJnlLine.CalcSums("Amount");
        DecGTotalPayAmountFCY := -GenJnlLine."Amount";

        GenJnlLine.SetRange("Account Type");
        GenJnlLine.SetRange("Bal. Account Type", GenJnlLine."Bal. Account Type"::Vendor);
        GenJnlLine.CalcSums("Amount");
        DecGTotalPayAmountFCY += GenJnlLine."Amount";
    end;
}