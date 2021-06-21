report 50211 "BBX Sales Cr. Memo"
{
    WordLayout = './BlueBotics Sales Cr. Memo.docx';
    Caption = 'BlueBotics Sales Cr. Memo';
    DefaultLayout = Word;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    Permissions = TableData "Sales Shipment Buffer" = rimd;

    dataset
    {
        dataitem(Header; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Posted Sales Cr.Memo';
            DataItemTableView = sorting("No.");
            column(No_Header; "No.")
            {
            }
            column(PostingDate_Header; Format("Posting Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(YourReference_Header; "Your Reference")
            {
            }
            column(OrederDate_Header; Format("Document Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            Column(BilltoContact_Header; "Bill-to Contact")
            {
            }
            column(OurDeliveryBill; RecGTempSalesShptline."document No.")
            {
            }
            column(DeliveryDate; format(RecGTempSalesShptline."posting date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurMail; 'accounting@bluebotics.com')//CompanyInfo."E-Mail")
            {
            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {
            }
            column(ApproverSignature; RecGTenantMedia.Content)
            {
            }
            column(ApproverName; RecGUserSetup."BBX Full Name")
            {

            }
            column(CPSignature; RecGTenantMedia2.Content)
            {
            }
            column(CPName; RecGUserSetup2."BBX Full Name")
            {
            }
            column(UserID_Header; "User ID")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                //CurrencyCode := GetCurrencySymbol();
                IF "Currency Code" = '' THEN
                    CurrencyCode := RecGGeneralLedgerSetup."LCY Code"
                else
                    CurrencyCode := "Currency Code";

                PostedApprovalEntry.SetRange("Table ID", 114);
                PostedApprovalEntry.SetRange("Document No.", Header."No.");
                if PostedApprovalEntry.FindFirst() then
                    RecGUserSetup.Get(PostedApprovalEntry."Approver ID");

                if RecGUserSetup2.Get(Header."BBX Project Manager") then;

                CalcSignature(RecGUserSetup, RecGTenantMedia);
                CalcSignature(RecGUserSetup2, RecGTenantMedia2);
                SearchBankAccount(Header);
            end;
        }
        dataitem(Lines; "Sales Cr.Memo Line")
        {
            DataItemLinkReference = Header;
            DataItemTableView = sorting("Document No.", "Line No.");
            DataItemLink = "Document No." = field("No.");

            column(Quantity_Lines; Quantity)
            {
                DecimalPlaces = 0 : 5;
            }
            column(No_Lines; "No.")
            {
            }
            column(Description_Lines; Description)
            {
            }
            column(UnitPrice_Lines; BlankZero("Unit Price"))
            {
            }
            column(ContryOfOriginLine_Lines; TxTGCountryOfOrigin)
            {
            }
            column(TarrifNo_Line; TexTGHSClassification)
            {
            }
            column(LineAmount_Lines; TxtGLineAmount)
            {
            }
            trigger OnPreDataItem()
            begin
                VATAmountLine.DELETEALL;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                TxtGLineAmount := BlankZeroWithCurrencyCode("Line Amount");
                Clear(TxTGCountryOfOrigin);
                Clear(TexTGHSClassification);
                if RecGItem.Get("No.") then begin
                    if RecGItem."Tariff No." <> '' then
                        TexTGHSClassification := StrSubstNo('%1 %2', HSClassificationLabel, RecGItem."Tariff No.");
                    if RecGCountryRegion.Get(RecGItem."Country/Region of Origin Code") then
                        TxTGCountryOfOrigin := StrSubstNo('%1 %2', CountryOfOriginLabel, RecGCountryRegion.Name)
                end;

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
                IF ("VAT %" <> 0) OR ("VAT Clause Code" <> '') OR (Amount <> "Amount Including VAT") THEN
                    VATAmountLine.InsertLine;
                VATAmount := VATAmountLine.GetTotalVATAmount;

                TotalAmount += Amount;
                TotalAmountVAT += "Amount Including VAT" - Amount;
                TotalAmountInclVAT += "Amount Including VAT";
            end;
        }
        dataitem(ShipmentLine; "Sales Shipment Buffer")
        {
            DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
            UseTemporary = true;
            column(DocumentNo_ShipmentLine; "Document No.")
            {
            }
            column(PostingDate_ShipmentLine; "Posting Date")
            {
            }
            column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
            {
            }
            column(Quantity_ShipmentLine; Quantity)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange("Line No.", Lines."Line No.");
            end;
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
        dataitem(VATCounter; Integer)
        {
            column(VATAmtLineVATAmt; NumberWithCurrencyCode(VATAmountLine."VAT Amount"))
            {
            }
            column(VATPct_VatAmountLine; StrSubstNo('%1 %', FORMAT(VATAmountLine."VAT %", 0, '<Integer Thousand><Decimals,3>')))
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
                    SETRANGE(Number, 1)
            end;

            trigger OnAfterGetRecord()
            begin
                if not VATAmountLine.IsEmpty then
                    VATAmountLine.GetLine(Number);
            end;
        }
        dataitem(Totals; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));
            column(TotalAmount; NumberWithCurrencyCode(TotalAmount))
            {
            }
            column(TotalAmountInclVAT; NumberWithCurrencyCode(TotalAmountInclVAT))
            {
            }
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));
            column(PostingDateCaption; StrSubstNo('%1:', Header.FieldCaption("Posting Date")))
            {
            }
            column(YourReferenceCaption; StrSubstNo('%1:', Header.FieldCaption("Your Reference")))
            {
            }
            column(OrderDateCaption; OrderDateLbl)
            {
            }
            column(BillToContactCpation; StrSubstNo('%1:', Header.FieldCaption("Bill-to Contact")))
            {
            }
            column(OurDeliveryBillCaption; OurDeliveryBillLbl)
            {
            }
            column(DeliveryDateCaption; StrSubstNo('%1:', Header.FieldCaption("Posting date")))
            {
            }
            column(OurMailCaption; OurMailCaptionLbl)
            {
            }
            column(InvoiceAddrCaption; InvoiceAddrCaptionLbl)
            {
            }
            column(DocumentTitleCaption; DocumentTitleCaptionLbl)
            {
            }
            column(OurReferenceCaption; OurReferenceCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(DescCaption; DescCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(TotalPriceCaption; TotalPriceCaptionLbl)
            {
            }
            column(TotalExclVatCaption; TotalExclVatCaptionLbl)
            {
            }
            column(PaymentTermsDescriptionCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
        }
        dataitem(FooterFields; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));
            column(BankAccount_IBAN; RecGBankAccount.IBAN)
            {
            }
            column(BankAccount_IBAN_Lbl; StrSubstNo('%1:', IbanCaptionLbl))
            {
            }
            column(BankAccount_SWIFT; RecGBankAccount."SWIFT Code")
            {
            }
            column(BankAccount_SWIFT_Lbl; StrSubstNo('%1:', SwiftCaptionLbl))
            {
            }
            column(BankAccount_AccountNo; RecGBankAccount."Bank Account No.")
            {
            }
            column(BankAccount_AccountNo_Lbl; StrSubstNo('%1:', CompanyInfoBankAccNoLbl))
            {
            }
            column(BankAccount_Name; RecGBankAccount."Name")
            {
            }
            column(BankAccount_Address; STRSUBSTNO('%1 - %2 %3', RecGBankAccount."Country/Region Code", RecGBankAccount."Post Code", RecGBankAccount.city))
            {
            }
            column(BankAccount_CountryName; TxtGBankCountryName)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; VATRegistrationNoLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(Footer; TxtGFooter)
            {
            }
            column(CompanyBankNameCaption; CompanyInfoBankNameCaptionLbl)
            {
            }
        }

    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        RecGGeneralLedgerSetup.Get();
    end;

    var
        DocumentTitleCaptionLbl: Label 'Credit Note';
        InvoiceAddrCaptionLbl: Label 'Invoicing address:';
        OurReferenceCaptionLbl: Label 'Our Reference: ';
        OrderDateLbl: label 'Date of Order';
        DeliveryDateLbl: label 'Delivery date';
        OurDeliveryBillLbl: label 'Our delivery bill';
        OurMailCaptionLbl: label 'Our mail';
        QtyCaptionLbl: label 'QTY';
        ItemNoCaptionLbl: Label 'Art. N°';
        DescCaptionLbl: Label 'Designation';
        UnitPriceCaptionLbl: Label 'Unit price';
        TotalPriceCaptionLbl: Label 'Total price';
        VATRegistrationNoLbl: Label 'VAT :';
        TotalExclVatCaptionLbl: Label 'Total Exl VAT';
        IbanCaptionLbl: Label 'IBAN';
        SwiftCaptionLbl: Label 'SWIFT';
        CompanyInfoBankAccNoLbl: Label 'Account Number';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CountryOfOriginLabel: Label 'Country of origin: ';
        HSClassificationLabel: Label 'HS. Classification: ';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        PaymentCaptionLbl: Label 'Payment must be done net of any bank charge & commission (code SEPA "OUR")';
        VATCaptionLbl: Label 'VAT';
        TotalCaptionLbl: Label 'Total due';
        TxtGBankCountryName: Text;
        TxtGLineAmount: Text;
        CustAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        TxtGFooter: Text;
        CurrencyCode: text;
        TxTGCountryOfOrigin: Text;
        TexTGHSClassification: Text;
        TotalAmount: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        RecGTempSalesShptline: Record "Sales Shipment Line" temporary;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        RespCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";
        RecGCountryRegion: Record "Country/Region";
        RecGBankAccount: Record "Bank Account";
        PostedApprovalEntry: Record "Posted Approval Entry";
        RecGUserSetup: Record "User Setup";
        RecGUserSetup2: Record "User Setup";
        RecGTenantMedia: Record "Tenant Media";
        RecGTenantMedia2: Record "Tenant Media";
        VATAmountLine: Record "VAT Amount Line";
        RecGItem: Record Item;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        RecGGeneralLedgerSetup: Record "General Ledger Setup";

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        with SalesCrMemoHeader do begin
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
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

    local procedure SearchBankAccount(RecPSalesCrMemoHeader: record "Sales Cr.Memo Header")
    begin
        RecGBankAccount.RESET;
        RecGBankAccount.SETRANGE(BBXBankShowInvoiceFooter, true);
        RecGBankAccount.SETfilter("Currency Code", '%1', RecPSalesCrMemoHeader."Currency Code");
        IF NOT RecGBankAccount.FindSet() then
            RecGBankAccount.Init();

        IF Not RecGCountryRegion.GET(RecGBankAccount."Country/Region Code") then
            RecGCountryRegion.init;
        TxtGBankCountryName := RecGCountryRegion.Name;
    end;

    local procedure CalcSignature(var RecPUserSetup: Record "User Setup"; var RecPMediaTenant: Record "Tenant Media")
    var
        IntLIndex: Integer;
    begin
        if RecPUserSetup."BBX Signature".Count = 0 then
            exit
        else
            for IntLIndex := 1 to RecPUserSetup."BBX Signature".Count do begin
                if RecPMediaTenant.Get(RecPUserSetup."BBX Signature".Item(IntLIndex)) then begin
                    RecPMediaTenant.calcfields(Content);
                end;
            end;
    end;

    local procedure BlankZeroWithCurrencyCode(DecPNumber: Decimal): Text
    begin
        if DecPNumber <> 0 then
            exit(StrSubstNo('%1 %2', CurrencyCode, Format(DecPNumber, 0, '<Integer Thousand><Decimals,3>')))
        else
            exit('');
    end;

    local procedure BlankZero(DecPNumber: Decimal): Text
    begin
        if DecPNumber <> 0 then
            exit(Format(DecPNumber))
        else
            exit('');
    end;

}