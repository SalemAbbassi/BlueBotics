report 50212 "BBX Try And Buy Delivery"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Try And Buy Dekivery.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Try And Buy Delivery';
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Transfer Receipt Header")
        {
            RequestFilterFields = "No.";
            column(No_Header; "No.")
            {
            }
            column(PostingDate_Header; FORMAT("Posting Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(YourPurchaseOrder_Header; RecGSalesHeader."No.")
            {
            }
            column(OrderDate_Header; FORMAT("Transfer Order Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurQuotation_Header; RecGSalesHeader."Quote No.")
            {
            }
            column(OurReference_Header; UserID)
            {
            }
            column(ValidateBy_Header; RecGUserSetup2."BBX Full Name")
            {
            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {
            }
            column(TermsOfPayment_Header; PaymentTerms.Description)
            {
            }
            column(TermsOfDelivery_Header; ShipmentMethod.Description)
            {
            }
            column(ExpectedDeliveryDate_Header; FORMAT(RecGSalesHeader."Promised Delivery Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(DeliveryAddress_Header; TxtDeliveryAddress)
            {
            }
            column(FirstApproverName_Header; RecGUserSetup1."BBX Full Name")
            {
            }
            column(SecondApproverName_Header; RecGUserSetup2."BBX Full Name")
            {
            }
            column(FirstApproverSignature; RecGTenantMedia1.Content)
            {
            }
            column(SecondApproverSignature; RecGTenantMedia2.Content)
            {
            }
            column(Footer; TxtGFooter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if RecGSalesHeader.Get(RecGSalesHeader."Document Type"::Order, Header."BBX Sales Order No.") then;
                if RecGCustomer.GET(RecGSalesHeader."Sell-to Customer No.") then
                    BooGPrintExtendedText := RecGCustomer."BBX Partner";

                RecGStandardText.SetRange("BBX Partner cust", true);
                if RecGStandardText.FindFirst() then begin
                    RecGExtendedTextHeader.SetRange("Table Name", RecGExtendedTextHeader."Table Name"::"Standard Text");
                    RecGExtendedTextHeader.SetRange("No.", RecGStandardText.Code);
                    if RecGExtendedTextHeader.FindFirst() then;
                end;

                FormatAddressFields(RecGSalesHeader);
                FormatDocumentFields(RecGSalesHeader);

                CurrencyCode := GetCurrencySymbol(RecGSalesHeader);

                If RecGUserSetup1.Get(UserId) then
                    CalcSignature(RecGUserSetup1, RecGTenantMedia1);
                if RecGUserSetup2.Get("BBX Validated By") then
                    CalcSignature(RecGUserSetup2, RecGTenantMedia2);

                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
            end;
        }
        dataitem("Extended Text Line"; "Extended Text Line")
        {
            column(Comment_Text; Text)
            {
            }
            trigger OnPreDataItem()
            begin
                if not RecGExtendedTextHeader.IsEmpty then begin
                    SetRange("Table Name", RecGExtendedTextHeader."Table Name");
                    SetRange("No.", RecGExtendedTextHeader."No.");
                end else
                    CurrReport.Break();
            end;

        }
        dataitem(Line; "Transfer Receipt Line")
        {
            DataItemLinkReference = Header;
            DataItemTableView = SORTING("Document No.", "Line No.");
            DataItemLink = "Document No." = field("No.");
            column(Quantity_Line; Quantity)
            {
            }
            column(ItemNo_Line; "Item No.")
            {
            }
            column(Description_Line; Description)
            {
            }
            column(UnitPrice_Line; RecGSalesLine."Unit Price")
            {
            }
            column(LineAmount_Line; TxtGLineAmount)
            {
            }
            trigger OnPreDataItem()
            begin
                VATAmountLine.DELETEALL;
                TotalLineAmount := 0;
                TotalAmount := 0;
                TotalAmountInclVAT := 0;
            end;

            trigger OnAfterGetRecord()
            var
                RecLTempSalesLine: Record "Sales Line" temporary;
            begin
                if RecGSalesLine.GET(RecGSalesHeader."Document Type", RecGSalesHeader."No.", Line."BBX Sales Line No.") then
                    TxtGLineAmount := NumberWithCurrencyCode(Quantity * RecGSalesLine."Unit Price");
                RecLTempSalesLine.Copy(RecGSalesLine);
                if not RecLTempSalesLine.IsEmpty then
                    RecLTempSalesLine.Validate(Quantity, Line.Quantity);

                with RecLTempSalesLine do begin
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

                    TotalLineAmount += "Line Amount";
                    TotalAmount += Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                end;

            end;
        }
        dataitem(VATCounter; Integer)
        {
            column(VATAmountLineVAT; StrSubstNo('%1 %', FORMAT(VATAmountLine."VAT %", 0, '<Integer Thousand><Decimals,3>')))
            {
            }
            column(VATAmtLineVATAmount; NumberWithCurrencyCode(VATAmountLine."VAT Amount"))
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, VATAmountLine.COUNT);
            end;

            trigger OnAfterGetRecord()
            begin
                VATAmountLine.GetLine(Number);
            end;
        }

        dataitem(Totals; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(TotalAmountInclVAT; NumberWithCurrencyCode(TotalAmountInclVAT))
            {
            }
            column(TotalAmtExclVAT; NumberWithCurrencyCode(TotalAmount))
            {
            }
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));

            column(DocumentTitleCaption; DocumentTitleCaptionLbl)
            {
            }
            column(InvoicingAddressCaption; InvoicingAddressCaptionLbl)
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
            column(ValidateByCaption; ValidateByCaptionLbl)
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

            /*-------Lines Caption------*/
            column(QTYCaption; QTYCaptionLbl)
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
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(InvoicingAddrCaption; InvoicingAddrCaptionLbl)
            {
            }
            column(DeliveryAddressCaption; DeliveryAddressCaptionLbl)
            {
            }
            column(IntermidaiteTotalCaption; IntermidaiteTotalCaptionLbl)
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
    var
        DocumentTitleCaptionLbl: Label 'TRY AND BUY DELIVERY BILL';
        InvoicingAddressCaptionLbl: Label 'Invocing address:';
        DateCaptionLbl: Label 'Date';
        YourPurchaseOrderCaptionLbl: Label 'Your purchase order:';
        DateOfOrderCaptionLbl: Label 'Date of order:';
        OurQuotationCaptionLbl: Label 'Our Quotation:';
        OurReferenceCatptionLbl: Label 'Our reference:';
        ValidateByCaptionLbl: Label 'Validated By:';
        TermsOfDeliveryCaptionLbl: Label 'Terms of delivery:';
        TermsOfPaymentCaptionLbl: Label 'Terms of payment:';
        ExpectedDeliveryDateCaptionLbl: Label 'Expected delivery date:';
        DeliveryAddressCaptionLbl: Label 'Delivery address:';
        QTYCaptionLbl: Label 'Qty';
        ItemNoCaptionLbl: Label 'Art. N°';
        DescCaptionLbl: Label 'Designation';
        UnitPriceCaptionLbl: Label 'Unit price';
        TotalPriceCaptionLbl: Label 'Total price';
        VATCaptionLbl: Label 'VAT';
        TotalCaptionLbl: Label 'Total';
        TxtGValidateBy: Label '.....';
        InvoicingAddrCaptionLbl: Label 'Invoicing address: ';
        IntermidaiteTotalCaptionLbl: Label 'Intermediate total';
        TxtGFooter: Text;
        TxtDeliveryAddress: Text;
        CurrencyCode: text;
        TxtGLineAmount: Text;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CompanyInfo: Record "Company Information";
        RecGCountryRegion: Record "Country/Region";
        RecGUserSetup1: Record "User Setup";
        RecGUserSetup2: Record "User Setup";
        RecGTenantMedia1: Record "Tenant Media";
        RecGTenantMedia2: Record "Tenant Media";
        RecGSalesHeader: Record "Sales Header";
        RecGSalesLine: Record "Sales Line";
        RecGCustomer: Record Customer;
        RecGStandardText: Record "Standard Text";
        RecGTranferHeader: Record "Transfer Header";
        RecGExtendedTextHeader: Record "Extended Text Header";
        VATAmountLine: Record "VAT Amount Line";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        BooGPrintExtendedText: Boolean;
        TotalLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;


    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    local procedure IntVATAmountLine(RecPSalesLine: Record "Sales Line")
    begin
        with RecPSalesLine do begin

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

            TotalLineAmount += "Line Amount";
            TotalAmount += Amount;
            TotalAmountInclVAT += "Amount Including VAT";
        end;
    end;

    local procedure FormatAddressFields(RecPSalesHeader: Record "Sales Header")
    begin
        FormatAddr.SalesHeaderBillTo(CustAddr, RecPSalesHeader);
        FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, RecPSalesHeader);
        TxtDeliveryAddress := StrSubstNo('%1, %2, %3, %4, %5', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5]);
    end;

    local procedure FormatDocumentFields(RecPSalesHeader: Record "Sales Header")
    begin
        with RecPSalesHeader do begin
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure NumberWithCurrencyCode(Number: Decimal): Text
    begin
        exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')));
    end;

    procedure GetCurrencySymbol(RecPSalesHeader: Record "Sales Header"): Text[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
    begin
        with RecPSalesHeader do begin
            if GeneralLedgerSetup.Get then
                if (RecGSalesHeader."Currency Code" = '') or (RecGSalesHeader."Currency Code" = GeneralLedgerSetup."LCY Code") then
                    exit(GeneralLedgerSetup.GetCurrencySymbol);

            if Currency.Get(RecGSalesHeader."Currency Code") then
                exit(Currency.GetCurrencySymbol);
        end;

        exit(RecGSalesHeader."Currency Code");
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
}