report 50207 "BBX Service Order"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Service Order.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Service Order';
    ApplicationArea = All;

    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            RequestFilterFields = "No.";
            column(No_ServiceHeader; "No.")
            {
            }
            column(Date; Format(WorkDate, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OrderDate; FORMAT("Order Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurQuotation; "Quote No.")
            {
            }
            column(OurReference_ServiceHeader; "Assigned User ID")
            {
            }
            column(FinishingDate_ServiceHeader; FORMAT("Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(TermsOfDelivery; ShipmentMethod.Description)
            {
            }
            column(TermsOfPayment; PaymentTerms.Description)
            {
            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {
            }
            column(PhoneNo_ServiceHeader; "Phone No.")
            {
            }
            column(E_Mail_ServiceHeader; "E-Mail")
            {
            }
            column(Expected_Finishing_Date; FORMAT("Expected Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                FormatAddressFields(ServiceHeader);
                FormatDocumentFields(ServiceHeader);
                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                CurrencyCode := GetCurrencySymbol();
                if not RecGUserSetup.Get("Assigned User ID") then RecGUserSetup.Init();
            end;
        }
        dataitem(ServiceItemLine; "Service Item Line")
        {
            DataItemLinkReference = ServiceHeader;
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
            DataItemLink = "Document No." = field("No.");
            column(ServiceItemNo_ServiceItemLine; "Service Item No.")
            {
            }
            column(Description_ServiceItemLine; Description)
            {
            }
            column(Warranty_ServiceItemLine; TxtGWarranty)
            {
            }
            dataitem(ServiceLine; "Service Line")
            {
                DataItemLinkReference = ServiceItemLine;
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                DataItemLink = "Document Type" = field("Document Type"),
                            "Document No." = field("Document No."),
                            "Service Item Line No." = field("Line No.");
                column(PartNo_ServiceLine; "No.")
                {
                }
                column(Desc_ServiceLine; Description)
                {
                }
                column(Qty_ServiceLine; FORMAT(Quantity, 0, '<Integer Thousand><Decimals,3>'))
                {
                }
                column(UnitPrice_ServiceLine; FORMAT("Unit Price", 0, '<Integer Thousand><Decimals,3>'))
                {
                }
                column(Amount_ServiceLine; FORMAT(Amount, 0, '<Integer Thousand><Decimals,3>'))
                {
                }
                column(Amt_ServiceLine; Amt)
                {
                }
                column(VAT_ServiceLine; StrSubstNo('%1%', "VAT %"))
                {
                }

                trigger OnPreDataItem()
                begin
                    Clear(Amt);
                    Clear(GrossAmt);

                    //TotalAmt := 0;
                    //TotalGrossAmt := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Amt := Round((Quantity * "Unit Price") * (1 - "Line Discount %" / 100));
                    GrossAmt := (1 + "VAT %" / 100) * Amt;

                    TotalAmt += Amt;
                    TotalGrossAmt += GrossAmt;
                    TotalVATAmount := TotalGrossAmt - TotalAmt;

                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Warranty then
                    TxtGWarranty := 'YES'
                else
                    TxtGWarranty := 'NO';
            end;
        }

        dataitem(Totals; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(TotalGrossAmt; NumberWithCurrencyCode(TotalGrossAmt))
            {
            }
            column(TotalAmt; NumberWithCurrencyCode(TotalAmt))
            {
            }
            column(TotalVATAmount; NumberWithCurrencyCode(TotalVATAmount))
            {
            }
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));

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
            /*------ Line Captions ---*/
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
            column(VATCaption; VATCaptionLbl)
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

    var
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
        IntermTotalCaptionLbl: Label 'Intermediate total';
        TotaCaptionLbl: Label 'Total';
        RecGUserSetup: Record "User Setup";
        Amt: Decimal;
        GrossAmt: Decimal;
        TotalAmt: Decimal;
        TotalGrossAmt: Decimal;
        TotalVATAmount: Decimal;
        CompanyInfo: Record "Company Information";
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        TxtGWarranty: Text;
        TxtGFooter: Text;
        CurrencyCode: text;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        RespCenter: Record "Responsibility Center";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        RecGCountryRegion: Record "Country/Region";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";


    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure FormatAddressFields(var ServiceHeader: Record "Service Header")
    begin
        FormatAddr.GetCompanyAddr(ServiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.ServiceOrderSellto(CustAddr, ServiceHeader);
    end;

    local procedure FormatDocumentFields(ServiceHeader: Record "Service Header")
    begin
        with ServiceHeader do begin
            //FormatDocument.SetTotalLabels(GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
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
            if (ServiceHeader."Currency Code" = '') or (ServiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") then
                exit(GeneralLedgerSetup.GetCurrencySymbol);

        if Currency.Get(ServiceHeader."Currency Code") then
            exit(Currency.GetCurrencySymbol);

        exit(ServiceHeader."Currency Code");
    end;

    local procedure NumberWithCurrencyCode(Number: Decimal): Text
    begin
        exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')));
    end;
}