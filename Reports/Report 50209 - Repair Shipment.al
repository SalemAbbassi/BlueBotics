report 50209 "BBX Repair Shipment"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Repair Shipment.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Repair Shipment';
    ApplicationArea = All;

    dataset
    {
        dataitem(ServiceShpHeader; "Service Shipment Header")
        {
            RequestFilterFields = "No.";
            column(No_ServiceShpHeader; "No.")
            {
            }

            column(InvoivingAddress_Header; TxtGInvoivingAddress)
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(Date; Format(WorkDate, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OrderDate; FORMAT("Order Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OurReference_ServiceShpHeader; "User ID")
            {
            }
            column(FinishingDate_ServiceShpHeader; FORMAT("Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {
            }
            column(Expected_Finishing_Date; FORMAT("Expected Finishing Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(ShiptoContact_ServiceShpHeader; "Ship-to Contact")
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                FormatAddressFields(ServiceShpHeader);
                If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                CurrencyCode := GetCurrencySymbol();
                if RecGCustomer.Get("Bill-to Customer No.") then;
                TxtGInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5', CustAddr[1], CustAddr[2], CustAddr[3], CustAddr[4], CustAddr[5], CustAddr[6]);
            end;
        }
        dataitem(ServiceShipItemLine; "Service Shipment Item Line")
        {
            DataItemLinkReference = ServiceShpHeader;
            DataItemTableView = SORTING("No.", "Line No.");
            DataItemLink = "No." = field("No.");
            column(ServiceItemNo_ServiceShipItemLine; "Service Item No.")
            {
            }
            column(Description_ServiceShipItemLine; Description)
            {
            }
            column(Warranty_ServiceShipItemLine; TxtGWarranty)
            {
            }
            dataitem(ServiceShipmentLine; "Service Shipment Line")
            {
                DataItemLinkReference = ServiceShipItemLine;
                DataItemLink = "Document No." = FIELD("No."),
                                "Service Item Line No." = field("Line No.");

                column(PartNo_ServiceShipmentLine; "No.")
                {
                }
                column(Desc_ServiceShipmentLine; Description)
                {
                }
                column(Qty_ServiceShipmentLine; FORMAT(Quantity, 0, '<Integer Thousand><Decimals,3>'))
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Warranty then
                    TxtGWarranty := 'YES'
                else
                    TxtGWarranty := 'NO';
            end;
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = Const(1));

            column(PhoneNoCaption; PhoneNoCaptionLbl)
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
            column(Footer; TxtGFooter)
            {
            }
            column(RepairShipmentCaption; RepairShipmentCaptionLbl)
            {
            }
            column(CustomerEORICaption; CustomerEORICaptionLbl)
            {
            }
            column(DeliveryAddressCaption; DeliveryAddressCaptionLbl)
            {
            }
            column(YourReferenceCaption; YourReferenceCaptionLbl)
            {
            }
            column(InvoicingAddressCaption; InvoicingAddress)
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
            column(PhoneNo_Customer; RecGCustomer."Phone No.")
            {
            }
            column(EORINumber_Customer; RecGCustomer."BBX EORI Number")
            {
            }
        }
    }

    var
        PhoneNoCaptionLbl: Label 'Phone:';
        DateCaptionLbl: Label 'Delivery Date';
        YourPurchaseOrderCaptionLbl: Label 'Your purchase order:';
        DateOfOrderCaptionLbl: Label 'Date of order:';
        OurQuotationCaptionLbl: Label 'Our Quotation:';
        OurReferenceCatptionLbl: Label 'Our reference:';
        TermsOfDeliveryCaptionLbl: Label 'Terms of delivery:';
        TermsOfPaymentCaptionLbl: Label 'Terms of payment:';
        PartNoCaptionLbl: Label 'Part no.';
        ServiceItemNoCaptionLbl: Label 'Service Item No.';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        WarrantyCaptionLbl: Label 'Warranty';
        RepairShipmentCaptionLbl: Label 'REPAIR DELIVERY BILL';
        CustomerEORICaptionLbl: Label 'EORI Number:';
        DeliveryAddressCaptionLbl: Label 'Delivery address:';
        InvoicingAddress: Label 'Invoicing address:';
        YourReferenceCaptionLbl: Label 'Your reference:';
        CompanyInfo: Record "Company Information";
        TxtGWarranty: Text;
        TxtGFooter: Text;
        CurrencyCode: text;
        TxtGInvoivingAddress: Text;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        RespCenter: Record "Responsibility Center";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        RecGCountryRegion: Record "Country/Region";
        RecGCustomer: Record Customer;
        RecGServiceShipmentLine: Record "Service Shipment Line" temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";


    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure FormatAddressFields(VAR ServiceShipmentHeader: Record "Service Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(ServiceShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.ServiceShptShipTo(CustAddr, ServiceShipmentHeader);
    end;

    procedure GetCurrencySymbol(): Text[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
    begin
        if GeneralLedgerSetup.Get then
            if (ServiceShpHeader."Currency Code" = '') or (ServiceShpHeader."Currency Code" = GeneralLedgerSetup."LCY Code") then
                exit(GeneralLedgerSetup.GetCurrencySymbol);

        if Currency.Get(ServiceShpHeader."Currency Code") then
            exit(Currency.GetCurrencySymbol);

        exit(ServiceShpHeader."Currency Code");
    end;

    local procedure NumberWithCurrencyCode(Number: Decimal): Text
    begin
        exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')));
    end;
}