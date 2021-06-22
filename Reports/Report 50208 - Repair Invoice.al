report 50208 "BBX Repair Invoice"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Repair Invoice.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Repair Invoice';
    ApplicationArea = All;

    dataset
    {
        dataitem(ServiceInvHeader; "Service Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_ServiceInvHeader; "No.")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Date; Format(WorkDate, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OrderDate; FORMAT("Order Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurReference_ServiceInvHeader; "User ID")
            {
            }
            column(FinishingDate_ServiceInvHeader; FORMAT("Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
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
            column(PhoneNo_ServiceInvHeader; "Phone No.")
            {
            }
            column(E_Mail_ServiceInvHeader; "E-Mail")
            {
            }
            column(Expected_Finishing_Date; FORMAT("Expected Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                FormatAddressFields(ServiceInvHeader);
                FormatDocumentFields(ServiceInvHeader);
                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                CurrencyCode := GetCurrencySymbol();
            end;
        }
        dataitem(ServiceInvoiceLine; "Service Invoice Line")
        {
            DataItemLinkReference = ServiceInvHeader;
            DataItemTableView = SORTING("Document No.", "Line No.");
            DataItemLink = "Document No." = field("No.");
            column(ServiceItemNo_ServiceInvoiceLine; "Service Item No.")
            {
            }
            column(Description_ServiceInvoiceLine; Description)
            {
            }
            column(Warranty_ServiceInvoiceLine; TxtGWarranty)
            {
            }
            dataitem(ServiceShipmentLine; Integer)
            {
                DataItemLinkReference = ServiceInvoiceLine;
                column(PartNo_ServiceShipmentLine; RecGServiceShipmentLine."No.")
                {
                }
                column(Desc_ServiceShipmentLine; RecGServiceShipmentLine.Description)
                {
                }
                column(Qty_ServiceShipmentLine; FORMAT(RecGServiceShipmentLine.Quantity, 0, '<Integer Thousand><Decimals,3>'))
                {
                }
                column(UnitPrice_ServiceShipmentLine; FORMAT(RecGServiceShipmentLine."Unit Price", 0, '<Integer Thousand><Decimals,3>'))
                {
                }
                column(Amt_ServiceShipmentLine; Amt)
                {
                }
                column(VAT_ServiceShipmentLine; StrSubstNo('%1%', RecGServiceShipmentLine."VAT %"))
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, RecGServiceShipmentLine.COUNT);
                    Clear(Amt);
                    Clear(GrossAmt);

                    //TotalAmt := 0;
                    //TotalGrossAmt := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Amt := Round((RecGServiceShipmentLine.Quantity * RecGServiceShipmentLine."Unit Price") * (1 - RecGServiceShipmentLine."Line Discount %" / 100));
                    GrossAmt := (1 + RecGServiceShipmentLine."VAT %" / 100) * Amt;

                    TotalAmt += Amt;
                    TotalGrossAmt += GrossAmt;
                    TotalVATAmount := TotalGrossAmt - TotalAmt;

                end;
            }
            trigger OnPreDataItem()
            begin
                VATAmountLine.DELETEALL;
                TotalLineAmount := 0;
                TotalAmount := 0;
                TotalAmountInclVAT := 0;
            end;

            trigger OnAfterGetRecord()
            begin
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

                GetServShptLines(ServiceInvoiceLine, RecGServiceShipmentLine);
                if Warranty then
                    TxtGWarranty := 'YES'
                else
                    TxtGWarranty := 'NO';
            end;
        }
        dataitem(VATCounter; Integer)
        {
            column(VATAmountLineVAT; StrSubstNo('%1 %', FORMAT(VATAmountLine."VAT %", 0, '<Integer Thousand><Decimals,3>')))
            {
            }
            column(VATAmtLineVATAmount; VATAmountLine."VAT Amount")
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            trigger OnPreDataItem()
            begin
                /*IF VATAmountLine.GetTotalVATAmount = 0 THEN
                    CurrReport.BREAK;*/
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
            column(Footer; TxtGFooter)
            {
            }
            column(RepairInvoiceCaption; RepairInvoiceCaptionLbl)
            {
            }
            column(TotaCaption; TotaCaptionLbl)
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
        IntermTotalCaptionLbl: Label 'Total Excl VAT';
        RepairInvoiceCaptionLbl: Label 'REPAIR INVOICE';
        TotaCaptionLbl: Label 'Total';
        VATCaptionLbl: Label 'VAT';
        Amt: Decimal;
        GrossAmt: Decimal;
        TotalAmt: Decimal;
        TotalGrossAmt: Decimal;
        TotalVATAmount: Decimal;
        TotalLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
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
        RecGServiceShipmentLine: Record "Service Shipment Line" temporary;
        VATAmountLine: Record "VAT Amount Line";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";


    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure FormatAddressFields(var ServiceInvHeader: Record "Service Invoice Header")
    begin
        FormatAddr.GetCompanyAddr(ServiceInvHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.ServiceInvBillTo(CustAddr, ServiceInvHeader);
    end;

    local procedure FormatDocumentFields(ServiceInvHeader: Record "Service Invoice Header")
    begin
        with ServiceInvHeader do begin
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
        end;
    end;

    procedure GetCurrencySymbol(): Text[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
    begin
        if GeneralLedgerSetup.Get then
            if (ServiceInvHeader."Currency Code" = '') or (ServiceInvHeader."Currency Code" = GeneralLedgerSetup."LCY Code") then
                exit(GeneralLedgerSetup.GetCurrencySymbol);

        if Currency.Get(ServiceInvHeader."Currency Code") then
            exit(Currency.GetCurrencySymbol);

        exit(ServiceInvHeader."Currency Code");
    end;

    local procedure NumberWithCurrencyCode(Number: Decimal): Text
    begin
        exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')));
    end;

    local procedure GetServShptLines(ServiceInvLine: Record "Service Invoice Line"; var TempServShptLine: Record "Service Shipment Line" temporary)
    var
        ServShptLine: Record "Service Shipment Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        TempServShptLine.Reset();
        TempServShptLine.DeleteAll();

        if ServiceInvLine.Type <> ServiceInvLine.Type::Item then
            exit;

        FilterPstdDocLineValueEntries(ServiceInvLine, ValueEntry);
        if ValueEntry.FindSet then
            repeat
                ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.");
                if ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Service Shipment" then
                    if ServShptLine.Get(ItemLedgEntry."Document No.", ItemLedgEntry."Document Line No.") then begin
                        TempServShptLine.Init();
                        TempServShptLine := ServShptLine;
                        if TempServShptLine.Insert() then;
                    end;
            until ValueEntry.Next = 0;
    end;

    procedure FilterPstdDocLineValueEntries(ServiceInvLine: Record "Service Invoice Line"; var ValueEntry: Record "Value Entry")
    begin
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", ServiceInvLine."Document No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Service Invoice");
        ValueEntry.SetRange("Document Line No.", ServiceInvLine."Line No.");
    end;
}