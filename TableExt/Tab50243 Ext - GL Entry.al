tableextension 50243 "BBX G/L Entry" extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
    }

    var
        myInt: Integer;

    procedure GetOriginalCurrencyCode() CurrencyCode: Code[10]
    var
        RecLCustLedgerEntry: Record "Cust. Ledger Entry";
        RecLVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecLBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        CurrencyCode := '';
        if "Source Type" = "Source Type"::Customer then begin
            RecLCustLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLCustLedgerEntry.IsEmpty then
                if RecLCustLedgerEntry.FindFirst() then
                    CurrencyCode := RecLCustLedgerEntry."Currency Code";
        end;

        if "Source Type" = "Source Type"::Vendor then begin
            RecLVendorLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLVendorLedgerEntry.IsEmpty then
                if RecLVendorLedgerEntry.FindFirst() then
                    CurrencyCode := RecLVendorLedgerEntry."Currency Code";
        end;
        if "Source Type" = "Source Type"::"Bank Account" then begin
            RecLBankAccountLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLBankAccountLedgerEntry.IsEmpty then
                if RecLBankAccountLedgerEntry.FindFirst() then
                    CurrencyCode := RecLBankAccountLedgerEntry."Currency Code";
        end;
        exit(CurrencyCode);
    end;

    procedure GetOriginalAmount() ResPAmount: Decimal
    var
        RecLCustLedgerEntry: Record "Cust. Ledger Entry";
        RecLVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecLBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        ResPAmount := 0;
        if "Source Type" = "Source Type"::Customer then begin
            RecLCustLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLCustLedgerEntry.IsEmpty then
                if RecLCustLedgerEntry.FindFirst() then begin
                    RecLCustLedgerEntry.CalcFields(Amount, "Amount (LCY)");
                    if RecLCustLedgerEntry."Amount (LCY)" <> 0 then
                        ResPAmount := (Rec.Amount * RecLCustLedgerEntry.Amount) / RecLCustLedgerEntry."Amount (LCY)"
                    else
                        ResPAmount := 0;
                end;
        end;

        if "Source Type" = "Source Type"::Vendor then begin
            RecLVendorLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLVendorLedgerEntry.IsEmpty then
                if RecLVendorLedgerEntry.FindFirst() then begin
                    RecLVendorLedgerEntry.CalcFields(Amount, "Amount (LCY)");
                    if RecLVendorLedgerEntry."Amount (LCY)" <> 0 then
                        ResPAmount := (Rec.Amount * RecLVendorLedgerEntry.Amount) / RecLVendorLedgerEntry."Amount (LCY)"
                    else
                        ResPAmount := 0;
                end;
        end;
        if "Source Type" = "Source Type"::"Bank Account" then begin
            RecLBankAccountLedgerEntry.SetRange("Document No.", "Document No.");
            if not RecLBankAccountLedgerEntry.IsEmpty then
                if RecLBankAccountLedgerEntry.FindFirst() then begin
                    if RecLBankAccountLedgerEntry."Amount (LCY)" <> 0 then
                        ResPAmount := (Rec.Amount * RecLBankAccountLedgerEntry.Amount) / RecLBankAccountLedgerEntry."Amount (LCY)"
                    else
                        ResPAmount := 0;
                end;
        end;
        exit(ResPAmount);
    end;
}