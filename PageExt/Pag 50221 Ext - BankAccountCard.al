pageextension 50221 "BBX BankAccountCard" extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field(DBXBankShowInvoiceFooter; Rec.BBXBankShowInvoiceFooter)
            {
                ApplicationArea = all;
            }
        }
    }


}