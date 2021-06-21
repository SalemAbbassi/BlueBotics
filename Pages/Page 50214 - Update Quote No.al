page 50214 "BBX Update Quote No"
{
    PageType = ConfirmationDialog;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {

            field(codQuoteNo; codQuoteNo)
            {
                ApplicationArea = All;
                Caption = 'Quote No.';
                /*
                trigger OnLookup(var Text: Text): Boolean
                var
                    recSalesHeader: Record "Sales Header";
                    pagSalesQuotes: Page "Sales Quotes";
                begin
                    Clear(pagSalesQuotes);
                    pagSalesQuotes.LookupMode(true);
                    recSalesHeader.SetFilter("Document Type", '%1', recSalesHeader."Document Type"::Quote);
                    recSalesHeader.SetFilter("Sell-to Customer No.", '%1', codCustNo);
                    pagSalesQuotes.SetRecord(recSalesHeader);
                    if pagSalesQuotes.RunModal = Action::LookupOK then begin
                        pagSalesQuotes.GetRecord(recSalesHeader);
                        codQuoteNo := recSalesHeader."No.";
                    end;
                end;

                trigger OnValidate()
                var
                    recSalesHeader: Record "Sales Header";
                begin
                    recSalesHeader.SetFilter("Document Type", '%1', recSalesHeader."Document Type"::Quote);
                    recSalesHeader.SetFilter("Sell-to Customer No.", '%1', codCustNo);
                    recSalesHeader.SetFilter("No.", '%1', codQuoteNo);
                    recSalesHeader.FindFirst();
                end;
                */
            }

        }
    }

    actions
    {

    }

    var
        myInt: Integer;
        codQuoteNo: Code[20];
        codCustNo: code[20];

    procedure getInputValue(): code[20]
    begin
        exit(codQuoteNo);
    end;

    procedure SetCustNo(codPCustNo: code[20])
    begin
        codCustNo := codPCustNo;
    end;

    procedure SetQuoteNo(CodPQuoteNo: Code[20])
    begin
        codQuoteNo := CodPQuoteNo;
    end;
}