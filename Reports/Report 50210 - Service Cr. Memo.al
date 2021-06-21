report 50210 "BBX Service Cr. Memo"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Service Cr. Memo.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'BlueBotics Service Cr. Memo';
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Service Cr.Memo Header")
        {
            column(No_Header; "No.")
            {
            }
            column(Date_Header; Format(WorkDate, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OrderDate_Header; FORMAT("Document Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurReference_Header; "User ID")
            {
            }
            column(FinishingDate_Header; FORMAT("Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(TermsOfDelivery_Header; ShipmentMethod.Description)
            {
            }
            column(TermsOfPayment_Header; PaymentTerms.Description)
            {
            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {
            }
            column(PhoneNo_Header; "Phone No.")
            {
            }
            column(E_Mail_Header; "E-Mail")
            {
            }
            trigger OnAfterGetRecord()
            begin
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                CurrencyCode := GetCurrencySymbol();
            end;
        }
        dataitem(Lines; "Service Cr.Memo Line")
        {
            DataItemLinkReference = Header;
            DataItemTableView = sorting("Document No.", "Line No.");
            DataItemLink = "Document No." = field("No.");
            column(No_Lines; "No.")
            {
            }
            column(Description_Lines; Description)
            {
            }
            column(Quantity_Lines; FORMAT(Quantity, 0, '<Integer Thousand><Decimals,3>'))
            {
            }
            column(Unit_Price_Lines; FORMAT("Unit Price", 0, '<Integer Thousand><Decimals,3>'))
            {
            }
            column(Amount_Lines; FORMAT(Amount, 0, '<Integer Thousand><Decimals,3>'))
            {
            }
            trigger OnPreDataItem()
            begin
                DecGSumAmount := 0;
                DecGTotalAmountInclVAT := 0;
                VATAmountLine.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            begin
                DecGSumAmount += Amount;
                DecGTotalAmountInclVAT += "Amount Including VAT";

                VATAmountLine.INIT;
                VATAmountLine."VAT Identifier" := "VAT Identifier";
                VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                VATAmountLine."Tax Group Code" := "Tax Group Code";
                VATAmountLine."VAT %" := "VAT %";
                VATAmountLine."VAT Base" := Amount;
                VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                VATAmountLine."Line Amount" := "Line Amount";
                IF "Allow Invoice Disc." THEN
                    VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                VATAmountLine.InsertLine;
                VATAmount := VATAmountLine.GetTotalVATAmount;
            end;
        }
        dataitem(VATCounter; Integer)
        {
            column(VATAmtLineVATAmt; NumberWithCurrencyCode(VATAmountLine."VAT Amount"))
            {
            }
            column(VATAmtLineVAT; StrSubstNo('%1 %', FORMAT(VATAmountLine."VAT %", 0, '<Integer Thousand><Decimals,3>')))
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            trigger OnPreDataItem()
            begin
                if VATAmountLine.Count <> 0 then
                    SETRANGE(Number, 1, VATAmountLine.COUNT)
                else
                    SETRANGE(Number, 1);
            end;

            trigger OnAfterGetRecord()
            begin
                if not VATAmountLine.IsEmpty then
                    VATAmountLine.GetLine(Number);
            end;
        }
        dataitem(Totals; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(TotalAmount; NumberWithCurrencyCode(DecGSumAmount))
            {
            }
            column(TotalAmountInclVAT; NumberWithCurrencyCode(DecGTotalAmountInclVAT))
            {
            }
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));
            column(ServiceCrMemoCaption; ServiceCrMemoCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(YourPurchaseOrderCaption; YourPurchaseOrderCaptionLbl)
            {
            }
            column(DateOfOrderCaption; DateOfOrderCaptionLbl)
            {
            }
            column(OurQuotationCaption; OurQuotationCaptionLbl)
            {
            }
            column(OurReferenceCatption; OurReferenceCatptionLbl)
            {
            }
            column(TermsOfDeliveryCaption; TermsOfDeliveryCaptionLbl)
            {
            }
            column(TermsOfPaymentCaption; TermsOfPaymentCaptionLbl)
            {
            }
            column(ExpectedDeliveryDateCaption; ExpectedDeliveryDateCaptionLbl)
            {
            }
            column(ServiceItemNoCaption; ServiceItemNoCaptionLbl)
            {
            }
            column(PartNoCaption; PartNoCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(WarrantyCaption; WarrantyCaptionLbl)
            {
            }
            column(UnitPriceExclVAT; UnitPriceExclVATCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(IntermTotalCaption; IntermTotalCaptionLbl)
            {
            }
            column(TotaCaption; TotaCaptionLbl)
            {
            }
            column(Footer; TxtGFooter)
            {
            }
        }
        dataitem(CustomerAddr; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        RespCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";
        RecGCountryRegion: Record "Country/Region";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        VATAmountLine: Record "VAT Amount Line";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        DecGSumAmount: Decimal;
        VATAmount: Decimal;
        DecGTotalAmountInclVAT: Decimal;
        TxtGFooter: Text;
        CurrencyCode: text;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ServiceCrMemoCaptionLbl: Label 'Service Cr. Memo';
        PhoneNoCaptionLbl: Label 'Phone No.';
        EmailCaptionLbl: Label 'Email';
        DateCaptionLbl: Label 'Date';
        YourPurchaseOrderCaptionLbl: Label 'Your purchase order:';
        DateOfOrderCaptionLbl: Label 'Date of order:';
        OurQuotationCaptionLbl: Label 'Our Quotation:';
        OurReferenceCatptionLbl: Label 'Our reference:';
        TermsOfDeliveryCaptionLbl: Label 'Terms of delivery:';
        TermsOfPaymentCaptionLbl: Label 'Terms of payment:';
        ExpectedDeliveryDateCaptionLbl: Label 'Expected delivery date:';
        PartNoCaptionLbl: Label 'Part no.';
        ServiceItemNoCaptionLbl: Label 'Service Item No.';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        WarrantyCaptionLbl: Label 'Warranty';
        UnitPriceExclVATCaptionLbl: Label 'Unit Price Excl. VAT';
        AmountCaptionLbl: Label 'Amount';
        VATCaptionLbl: Label 'VAT';
        IntermTotalCaptionLbl: Label 'Total Excl VAT';
        TotaCaptionLbl: Label 'Total';

    local procedure FormatAddressFields(var ServiceCrMemoHeader: Record "Service Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(ServiceCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.ServiceCrMemoBillTo(CustAddr, ServiceCrMemoHeader);
    end;

    local procedure FormatDocumentFields(ServiceCrMemoHeader: Record "Service Cr.Memo Header")
    begin
        with ServiceCrMemoHeader do begin
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            //FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    procedure GetCurrencySymbol(): Text[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
    begin
        if GeneralLedgerSetup.Get then
            if (Header."Currency Code" = '') or (Header."Currency Code" = GeneralLedgerSetup."LCY Code") then
                exit(GeneralLedgerSetup.GetCurrencySymbol);

        if Currency.Get(Header."Currency Code") then
            exit(Currency.GetCurrencySymbol);

        exit(Header."Currency Code");
    end;

    local procedure NumberWithCurrencyCode(Number: Decimal): Text
    begin
        exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')));
    end;
}