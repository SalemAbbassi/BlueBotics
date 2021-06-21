report 50202 "BBX Purchase Order"
{
    WordLayout = './BlueBotics Purchase Order.docx';
    Caption = 'BlueBotics Purchase Order';
    DefaultLayout = Word;
    WordMergeDataItem = "Purchase Header";

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'BlueBotics Purchase Order';

            column(BlanketPurchaseOrderCaption; BlanketPurchaseOrderCaptionLbl)
            {
            }
            column(BlanketPurchOrderNo; RecGPurchaseLine."Blanket Order No.")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(DocumentTitle_Lbl; DocumentTitleLbl)
            {
            }
            column(DocumentDate; Format("Order Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(YourRef_PurchHeader; "Your Reference")
            {
            }
            column(OurAccountNon; Vendor."Our Account No.")
            {
            }
            column(ApprovedBy; TxtGApproverNames[1])
            {
            }
            column(DeliveryDate; FORMAT("Requested Receipt Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(FirstApproverName; TxtGApproverNames[1])
            {
            }
            column(SecondApproverName; TxtGApproverNames[2])
            {
            }
            column(FirstApproverSignature; RecGTenantMedia1.Content)
            {
            }
            column(SecondApproverSignature; RecGTenantMedia2.Content)
            {
            }
            column(FooterLine1; TxtGFooterLine1)
            {
            }
            column(FooterLine2; TxtGFooterLine2)
            {
            }

            column(DateCaption; DateCpationLbl)
            {

            }
            column(QuotationDate_PurchHeader; Format("BBX Quotation Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(QuotationCaption; QuotationCaptionLbl)
            {
            }
            column(DateOfQuotation; DateOfQuotationLbl)
            {
            }
            column(YourReferenceCaption; StrSubstNo('%1:', "Purchase Header".FieldCaption("Your Reference")))
            {
            }
            column(OurCustomerCaption; OurCustomerCaptionLbl)
            {
            }
            column(AuthorizedByCaption; AuthorizedByCaptionLbl)
            {
            }
            column(DeliveryDateCaption; DeliveryDateCaptionLbl)
            {
            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {
            }
            column(BuyFromAddr6; BuyFromAddr[6])
            {
            }
            column(BuyFromAddr7; BuyFromAddr[7])
            {
            }
            column(BuyFromAddr8; BuyFromAddr[8])
            {
            }

            column(Vendor_Order_No_; "Vendor Order No.")
            {

            }
            Column(Vendor_Order_No_Caption; FieldCaption("Vendor Order No."))
            {

            }

            dataitem(CompanyInformation; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = CONST(1));

                column(CompanyAddress1; CompanyAddr[1])
                {
                }
                column(CompanyAddress2; CompanyAddr[2])
                {
                }
                column(CompanyAddress3; CompanyAddr[3])
                {
                }
                column(CompanyAddress4; CompanyAddr[4])
                {
                }
                column(CompanyAddress5; CountryRegion.Name)
                {
                }
                column(CompanyEMail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(CompanyPhoneNo; CompanyInfo."Phone No.")
                {
                }
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                DataItemLinkReference = "Purchase Header";

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
                column(Qty_PurchLine; FormattedQuanitity)
                {
                }
                column(No_PurchLine; "No.")
                {
                }
                column(Desc_PurchLine; Description)
                {
                }

                column(DirUnitCost_PurchLine; FormattedDirectUnitCost)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(LineAmount; TxtGLineAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(CurrencyCode_PurchLine; CurrencyCode)
                {
                }
                Column(Cross_Reference_No_PurchLine; "Purchase Line"."Cross-Reference No.")
                {

                }

                Column(VendorItemNoCaptionLbl; VendorItemNoCaptionLbl)
                {

                }
                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode then
                        CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;


                trigger OnAfterGetRecord()
                begin
                    AllowInvDisctxt := Format("Allow Invoice Disc.");
                    TotalSubTotal += "Line Amount";
                    TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                    //TotalAmount += Amount;
                    TotalAmount += "Amount Including VAT";

                    FormatDocument.SetPurchaseLine("Purchase Line", FormattedQuanitity, FormattedDirectUnitCost);
                    TxtGLineAmount := BlankZeroWithCurrencyCode("Line Amount");
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(VATCaption; VATCaptionLbl)
                {
                }
                column(VATAmountText; TempVATAmountLine.VATAmountText)
                {
                }
                column(VAT; StrSubstNo('%1%', TempVATAmountLine."VAT %"))
                {
                }
                column(VATIdentifier; TempVATAmountLine."VAT Identifier")
                {

                }
                column(TotalVATAmount; TxtGVATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmount; TxTGTotalAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountExclVat; TxtGTotalAmountExclVAT)
                {

                }
                column(TotalText; TotalText)
                {
                }
                column(TotalExclVatCaption; TotalExclVatCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(TempPurchLine);
                    Clear(PurchPost);
                    TempPurchLine.DeleteAll();
                    TempVATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT;

                    TxtGVATAmount := BlankZeroWithCurrencyCode(VATAmount);
                    TxTGTotalAmount := BlankZeroWithCurrencyCode(TotalAmount);
                    TxtGTotalAmountExclVAT := BlankZeroWithCurrencyCode(TotalAmount - VATAmount);
                end;
            }
            trigger OnAfterGetRecord()
            var
                IntLCount: Integer;
            begin
                TotalAmount := 0;

                FormatAddressFields("Purchase Header");
                Vendor.GET("Buy-from Vendor No.");

                ApprovalEntry.SetRange("Table ID", 38);
                ApprovalEntry.SetRange("Document Type", "Document Type");
                ApprovalEntry.SetRange("Document No.", "No.");
                IF ApprovalEntry.FINDSET then
                    repeat
                        IntLCount += 1;
                        RecGUSer.SetRange("User Name", ApprovalEntry."Approver ID");
                        IF RecGUSer.FindSet() then
                            TxtGApproverNames[IntLCount] := RecGUSer."Full Name";
                        IF IntLCount = 1 then
                            RecGUserSetup1.Get(ApprovalEntry."Approver ID")
                        ELSE
                            IF IntLCount = 2 then
                                RecGUserSetup2.Get(ApprovalEntry."Approver ID");
                    //until (IntLCount = 2) OR (ApprovalEntry.Next(-1) = 0);
                    until (IntLCount = 2) OR (ApprovalEntry.Next = 0);

                CalcSignature(RecGUserSetup1, RecGTenantMedia1);
                CalcSignature(RecGUserSetup2, RecGTenantMedia2);

                IF CountryRegion.Get(CompanyInfo."Country/Region Code") then;

                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.GET;
                    GLSetup.TESTFIELD("LCY Code");
                    CurrencyCode := GLSetup."LCY Code"
                end else
                    CurrencyCode := "Currency Code";
                TxtGFooterLine2 := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], CountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                RecGPurchaseLine.SetRange("Document Type", RecGPurchaseLine."Document Type"::Order);
                RecGPurchaseLine.SetRange("Document No.", "No.");
                If RecGPurchaseLine.FindFirst() then;
            end;
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        PurchSetup.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CurrencyCode: Text;
        DocumentTitleLbl: Label 'PURCHASE ORDER';
        QuotationCaptionLbl: Label 'Quotation';
        DateOfQuotationLbl: Label 'Date of quotation:';
        OurCustomerCaptionLbl: Label 'Our Customer #:';
        AuthorizedByCaptionLbl: Label 'Authorized By:';
        DeliveryDateCaptionLbl: Label 'Delivery date:';
        DateCpationLbl: Label 'Date';
        QTYCaptionLbl: Label 'Qty';
        ItemNoCaptionLbl: Label 'Art. N°';
        DescCaptionLbl: Label 'Designation';
        UnitPriceCaptionLbl: Label 'Unit price';
        TotalPriceCaptionLbl: Label 'Total price';
        VATCaptionLbl: Label 'VAT';
        TotalCaptionLbl: Label 'Total';

        TxtGFooterLine1: Label 'Please confirm the reception of this order';
        TotalExclVatCaptionLbl: Label 'Total Excl. VAT';
        VendorItemNoCaptionLbl: Label 'Vendor item No.';
        BlanketPurchaseOrderCaptionLbl: Label 'Blanket Purchase Order:';
        TxtGFooterLine2: Text;
        TxtGLineAmount: Text;
        TxtGVATAmount: Text;
        TxTGTotalAmount: Text;
        TxtGTotalAmountExclVAT: Text;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPurchLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        PurchSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        CountryRegion: Record "Country/Region";
        RecGUserSetup1: Record "User Setup";
        RecGUserSetup2: Record "User Setup";
        RecGUSer: Record User;
        RecGPurchaseLine: Record "Purchase Line";
        ApprovalEntry: Record "Approval Entry";
        RecGTenantMedia1: Record "Tenant Media";
        RecGTenantMedia2: Record "Tenant Media";
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        TxtGApproverNames: array[2] of Text;
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        FormattedQuanitity: Text;
        FormattedDirectUnitCost: Text;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        AllowInvDisctxt: Text[30];
        [InDataSet]
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        with PurchaseHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetPurchaser(SalespersonPurchaser, "Purchaser Code", PurchaserText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, "Prepmt. Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
        end;
    end;

    local procedure BlankZeroWithCurrencyCode(Number: Decimal): Text
    begin
        if Number <> 0 then
            exit(StrSubstNo('%1 %2', CurrencyCode, Format(Number, 0, '<Integer Thousand><Decimals,3>')))
        else
            exit('');
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

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;
}

