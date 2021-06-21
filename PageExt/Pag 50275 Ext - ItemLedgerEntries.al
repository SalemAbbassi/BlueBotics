pageextension 50275 "BBX Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Customer No."; CodGCustomerNo)
            {
                ApplicationArea = all;
                Caption = 'Customer No.';
            }
            field("Customer Name"; TxtGCustomerName)
            {
                ApplicationArea = all;
                Caption = 'Customer Name';
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        CodGCustomerNo := Rec.GetCustomerNo();
        TxtGCustomerName := Rec.GetCustomerName();
    end;

    var
        CodGCustomerNo: Code[20];
        TxtGCustomerName: Text[100];
}