report 50204 "BBX Proforma Invoice"
{
    WordLayout = './BlueBotics Proforma Invoice.docx';
    Caption = 'BlueBotics Proforma Invoice';
    DefaultLayout = Word;
    WordMergeDataItem = CopyLoop;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending);
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                RequestFilterFields = "No.", "Sell-to Customer No.";
                RequestFilterHeading = 'Posted Sales Shipment';
                column(No_SalesShipHeader; ReplaceString("No."))
                {
                }
                column(ExterDocNo_Header; "External Document No.")
                {
                }
                column(Order_No_Header; "Order No.")
                {
                }
                column(PostingDate_Header; FORMAT("Posting Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(OrderDate_Header; FORMAT("Order Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(SellingCaption; SellingCaptionLbl)
                {
                }
                column(ShipMethodCde_Header; "Shipment Method Code")
                {
                }
                column(YourReference_Header; "Your Reference")
                {
                }
                column(SelltoPhoneNo_Header; "Sell-to Phone No.")
                {
                }
                column(CustomerEORI_Header; RecGCustomer."BBX EORI Number")
                {
                }
                column(UserID_Header; RecGUserSetup."BBX Full Name")
                {
                }
                column(UserIDSignature_Header; RecGTenantMedia.Content)
                {
                }
                column(ShipToAddr1; ShipToAddr[1])
                {
                }
                column(ShipToAddr2; ShipToAddr[2])
                {
                }
                column(ShipToAddr3; ShipToAddr[3])
                {
                }
                column(ShipToAddr4; ShipToAddr[4])
                {
                }
                column(ShipToAddr5; ShipToAddr[5])
                {
                }
                column(ShipToAddr6; ShipToAddr[6])
                {
                }
                column(ShipToAddr7; ShipToAddr[7])
                {
                }
                column(ShipToAddr8; ShipToAddr[8])
                {
                }
                column(InvoivingAddress_Header; TxtGInvoivingAddress)
                {
                }
                column(Footer; TxtGFooter)
                {
                }
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(DeclareStatementCaption; DeclareStatementTxt)
                {
                }
                dataitem(Captions; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = CONST(1));
                    column(DocumentTitleCaption; DocumentTitleLbl)
                    {
                    }
                    column(DeliveryAddressCaption; DeliveryAddressCaptionLbl)
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
                    column(ReasonForExportCaption; ReasonForExportCaptionLbl)
                    {
                    }
                    column(IncotermCaption; IncotermCaptionLbl)
                    {
                    }
                    column(YourReferenceCaption; YourReferenceCaptionLbl)
                    {
                    }
                    column(PhoneCapionLbl; PhoneCapionLbl)
                    {
                    }
                    column(CustomerEORICaption; CustomerEORICaptionLbl)
                    {
                    }
                    column(InvoicingAddressCaption; InvoicingAddressCaptionLbl)
                    {
                    }
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
                    column(VATCaption; VATCaptionLbl)
                    {
                    }
                }

                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLinkReference = "Sales Shipment Header";
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    column(CrossReferenceNo_Line; "Cross-Reference No.")
                    {
                    }
                    column(Quantity_Line; TxtGQuantity)
                    {
                    }
                    column(ItemNo_Line; "No.")
                    {
                    }
                    column(Description_Line; Description)
                    {
                    }
                    column(UnitPriceLine; TxtGUnitPrice)
                    {
                    }
                    column(LineAmount; TxtGLineAmount)
                    {
                        AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                        AutoFormatType = 2;
                    }
                    column(ContryOfOrigin_Line; TxTGCountryOfOrigin)
                    {
                    }
                    column(TarrifNo_Line; TexTGHSClassification)
                    {
                    }
                    column(VAT_Line; TxTGVAT)
                    {

                    }

                    column(ForbbidenCaption; ForbbidenCaptionLbl)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        DecGTotalAmount := 0;
                        SetFilter(Type, '<>%1', Type::" ");
                        SetFilter(Quantity, '<>%1', 0);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        if RecGItem.Get("Sales Shipment Line"."No.") then begin
                            if RecGItem."Tariff No." <> '' then
                                TexTGHSClassification := StrSubstNo('%1 %2', HSClassificationLabel, RecGItem."Tariff No.");
                            if RecGCountryRegion.Get(RecGItem."Country/Region of Origin Code") then
                                TxTGCountryOfOrigin := StrSubstNo('%1 %2', CountryOfOriginLabel, RecGCountryRegion.Name)
                            else
                                TxTGCountryOfOrigin := '';
                        end else
                            TexTGHSClassification := '';
                        TxtGLineAmount := BlankZeroWithCurrencyCode(Quantity * "Unit Price");

                        DecGTotalAmount += Quantity * "Unit Price";

                        if Type = Type::" " then begin
                            TxtGQuantity := '';
                            TxtGUnitPrice := ''
                        end
                        else begin
                            TxtGQuantity := Format(Quantity);
                            TxtGUnitPrice := Format("Unit Price", 0, '<Integer Thousand><Decimals,3>');
                        end;
                        TxTGVAT := StrSubstNo('%1%', Format("VAT %", 0, '<Integer Thousand><Decimals,3>'));
                    end;
                }
                dataitem(BillToAddress; Integer)
                {
                    DataItemTableView = where(Number = const(1));
                    column(BillToAddr1; BillToAddr[1])
                    {
                    }
                    column(BillToAddr2; BillToAddr[2])
                    {
                    }
                    column(BillToAddr3; BillToAddr[3])
                    {
                    }
                    column(BillToAddr4; BillToAddr[4])
                    {
                    }
                    column(BillToAddr5; BillToAddr[5])
                    {
                    }
                    column(BillToAddr6; BillToAddr[6])
                    {
                    }
                    column(BillToAddr7; BillToAddr[7])
                    {
                    }
                    column(BillToAddr8; BillToAddr[8])
                    {
                    }
                }
                dataitem(SalesCommentLine; "Sales Comment Line")
                {
                    DataItemLinkReference = "Sales Shipment Line";
                    DataItemTableView = where("Document Type" = const(6));
                    DataItemLink = "No." = field("Document No."), "Document Line No." = field("Line No.");
                    column(Comment_SalesCommentLine; Comment)
                    {
                    }
                }
                dataitem("Extended Text Line"; "Extended Text Line")
                {
                    DataItemLinkReference = "Sales Shipment Line";
                    column(Text_ExtendedTextLine; Text)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        //Standard Text Management
                        BooGPrintSpecialStandardText := false;
                        if RecGCountryRegion.Get("Sales Shipment Header"."Sell-to Country/Region Code") then
                            if RecGCountryRegion."BBX CH PREF ORIGIN" then
                                BooGPrintSpecialStandardText := true
                            else
                                if ((CurrencyCode = 'EUR') AND (DecGTotalAmount < 10000)) OR
                                       ((CurrencyCode = 'CHF') AND (DecGTotalAmount < 6000)) then
                                    BooGPrintSpecialStandardText := true;

                        if not BooGPrintSpecialStandardText then
                            CurrReport.Break();

                        RecGStandardText.SetRange("BBX CH PREF ORIGIN", true);
                        RecGStandardText.SetRange("BBX Partner cust", false);
                        if RecGStandardText.FindFirst() then begin
                            RecGExtendedTextHeader.SetRange("Table Name", RecGExtendedTextHeader."Table Name"::"Standard Text");
                            RecGExtendedTextHeader.SetRange("No.", RecGStandardText.Code);
                            If RecGExtendedTextHeader.FindFirst() then begin
                                SetRange("Table Name", RecGExtendedTextHeader."Table Name");
                                SetRange("No.", RecGExtendedTextHeader."No.");
                            end else
                                CurrReport.Break();
                        end else
                            CurrReport.Break();
                    end;
                }
                dataitem(Totals; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(TotalAmount; TxtGTotalAmount)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        TxtGTotalAmount := BlankZeroWithCurrencyCode(DecGTotalAmount);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    RecLCountryRegion: Record "Country/Region";
                begin
                    IF "Currency Code" = '' THEN BEGIN
                        GLSetup.GET;
                        GLSetup.TESTFIELD("LCY Code");
                        CurrencyCode := GLSetup."LCY Code"
                    end else
                        CurrencyCode := "Currency Code";

                    If RecGCustomer.Get("Sell-to Customer No.") then;
                    FormatAddressFields("Sales Shipment Header");
                    If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                    TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");

                    /*if RecLCountryRegion.Get("Ship-to Country/Region Code") then;
                    TxtGInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5, %6', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5], ShipToAddr[6], RecLCountryRegion."County Name");
                    */
                    TxtGInvoivingAddress := GetInvocingAddress();

                    RecGUserSetup.SetRange("BBX Signatory PROFORMA", true);
                    if RecGUserSetup.FindFirst() then
                        CalcSignature(RecGUserSetup, RecGTenantMedia);
                end;
            }

            trigger OnPreDataItem()
            begin
                NoOfLoops := "Sales Shipment Header".Count * (Abs(NoOfCopies) + 1);
                SetRange(Number, 1, NoOfLoops);
                OldHeader.COPY("Sales Shipment Header");
                RunningHeader.COPY(OldHeader);
            end;

            trigger OnAfterGetRecord()
            begin
                IF RunningHeader.NEXT = 0 then begin
                    RunningHeader.Copy(OldHeader);
                    RunningHeader.findfirst;
                END;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        DocumentTitleLbl: Label 'PROFORMA INVOICE';
        DateCaptionLbl: Label 'Date:';
        YourPurchaseOrderCaptionLbl: Label 'Your purchase order:';
        DateOfOrderCaptionLbl: Label 'Date of order:';
        ReasonForExportCaptionLbl: Label 'Reason for export:';
        IncotermCaptionLbl: Label 'Incoterm:';
        YourReferenceCaptionLbl: Label 'Your reference:';
        PhoneCapionLbl: Label 'Phone:';
        CustomerEORICaptionLbl: Label 'EORI Number:';
        InvoicingAddressCaptionLbl: Label 'Invoicing address:';
        DeliveryAddressCaptionLbl: Label 'Delivery address:';
        QTYCaptionLbl: Label 'Qty';
        ItemNoCaptionLbl: Label 'Art. N°';
        DescCaptionLbl: Label 'Designation';
        UnitPriceCaptionLbl: Label 'Unit price';
        TotalPriceCaptionLbl: Label 'Total price';
        VATCaptionLbl: Label 'VAT';
        TotalCaptionLbl: Label 'Total';
        SellingCaptionLbl: Label 'Selling';
        TxTGCountryOfOrigin: Text;
        TexTGHSClassification: Text;
        TxtGQuantity: Text;
        TxtGUnitPrice: Text;
        CurrencyCode: Text;
        CountryOfOriginLabel: Label 'Country of origin: ';
        HSClassificationLabel: Label 'HS. Classification: ';
        DeclareStatementTxt: Label 'I declare that all the information contained in this invoice is true and correct';
        ForbbidenCaptionLbl: Label 'Don’t pay this invoice, for customs purpose only';
        ShowCustAddr: Boolean;
        BooGPrintSpecialStandardText: Boolean;
        TxtGFooter: Text;
        TxtGLineAmount: Text;
        TxtGInvoivingAddress: Text;
        TxtGTotalAmount: Text;
        TxTGVAT: Text;
        DecGTotalAmount: Decimal;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        RecGCustomer: Record Customer;
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RecGItem: Record Item;
        RecGCountryRegion: Record "Country/Region";
        GLSetup: Record "General Ledger Setup";
        RecGUserSetup: Record "User Setup";
        RecGTenantMedia: Record "Tenant Media";
        RecGStandardText: Record "Standard Text";
        RecGExtendedTextHeader: Record "Extended Text Header";
        FormatAddr: Codeunit "Format Address";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OldHeader: Record "Sales Shipment Header";
        RunningHeader: Record "Sales Shipment Header";

    local procedure FormatAddressFields(var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        FormatAddr.SalesShptBillTo(BillToAddr, CustAddr, "Sales Shipment Header");
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure BlankZeroWithCurrencyCode(Number: Decimal): Text
    begin
        if Number <> 0 then
            exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')))
        else
            exit('');
    end;

    local procedure CalcSignature(var RecPUserSetup: Record "User Setup"; var RecPTenantMedia: Record "Tenant Media")
    var
        IntLIndex: Integer;
    begin
        if RecPUserSetup."BBX Signature".Count = 0 then
            exit
        else
            for IntLIndex := 1 to RecPUserSetup."BBX Signature".Count do begin
                if RecPTenantMedia.Get(RecPUserSetup."BBX Signature".Item(IntLIndex)) then begin
                    RecPTenantMedia.calcfields(Content);
                end;
            end;
    end;

    local procedure ReplaceString(String: Text[250]) NewString: Text[250]
    var
    begin
        WHILE STRPOS(String, 'BL') > 0 DO
            String := DELSTR(String, STRPOS(String, 'BL')) + 'PF' + COPYSTR(String, STRPOS(String, 'BL') + STRLEN('BL'));
        NewString := String;
    end;

    local procedure GetInvocingAddress() TxtRInvoivingAddress: Text
    begin
        TxtRInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5]);
        if ShipToAddr[6] <> '' then
            TxtRInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5, %6', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5], ShipToAddr[6]);

        if ShipToAddr[7] <> '' then
            TxtRInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5, %6, %7', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5], ShipToAddr[6], ShipToAddr[7]);

        if ShipToAddr[8] <> '' then
            TxtRInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5, %6, %7, %8', ShipToAddr[1], ShipToAddr[2], ShipToAddr[3], ShipToAddr[4], ShipToAddr[5], ShipToAddr[6], ShipToAddr[7], ShipToAddr[8]);

        exit(TxtRInvoivingAddress);
    end;
}