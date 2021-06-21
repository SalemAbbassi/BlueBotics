report 50203 "BBX Sales Shipment"
{
    WordLayout = './BlueBotics Sales Shipment.docx';
    Caption = 'BlueBotics Sales Shipment';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = CopyLoop;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending);
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {

                column(No_SalesShipHeader; "No.")
                {
                }
                column(Parcel1Text; TxtGParcel1Text)
                {
                }
                column(Parcel2Text; TxtGParcel2Text)
                {
                }
                column(Parcel3Text; TxtGParcel3Text)
                {
                }
                column(Parcel4Text; TxtGParcel4Text)
                {
                }
                column(External_Document_No_; "External Document No.")
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
                column(QuoteNo_Header; "Quote No.")
                {
                }
                column(YourReference_Header; "Your Reference")
                {
                }
                column(OurReference_Header; RecGUserSetup."BBX Full Name")
                {
                }
                column(SelltoPhoneNo_Header; "Sell-to Phone No.")
                {
                }
                column(CustomerEORI_Header; RecGCustomer."BBX EORI Number")
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

                dataitem(Captions; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = CONST(1));
                    column(DocumentTitleCaption; DocumentTitleLbl)
                    {
                    }
                    column(DeliveryAddressCaption; DeliveryAddressCaptionLbl)
                    {
                    }
                    column(QuotationCaption; QuotationCaptionLbl)
                    {
                    }
                    column(DeliveryDateCaption; DeliveryDateCaptionLbl)
                    {
                    }
                    column(YourPurchaseOrderCaption; YourPurchaseOrderCaptionLbl)
                    {
                    }
                    column(DateOfOrderCaption; DateOfOrderCaptionLbl)
                    {
                    }
                    column(OurReferenceCaption; OurReferenceCaptionLbl)
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

                    column(QuantityCaption; QuantityCaptionLbl)
                    {
                    }
                    column(SerialNoCaption; SerialNoCaptionLbl)
                    {
                    }
                    column(LotNoCaption; LotNoCaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(NoCaption; NoCaptionLbl)
                    {
                    }
                }

                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLinkReference = "Sales Shipment Header";
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    column(Quantity_Line; TxtGQuantity)
                    {
                    }
                    column(CrossReferenceNo_Line; "Cross-Reference No.")
                    {
                    }
                    column(ItemNo_Line; "No.")
                    {
                    }
                    column(Description_Line; Description)
                    {
                    }
                    column(TarrifNo_Line; TexTGHSClassification)
                    {
                    }
                    column(ContryOfOrigin_Line; TxTGCountryOfOrigin)
                    {
                    }

                    dataitem("Sales Comment Line"; "Sales Comment Line")
                    {
                        DataItemLinkReference = "Sales Shipment Line";
                        DataItemTableView = where("Document Type" = const(6), Code = const('Customer'));
                        DataItemLink = "No." = field("Document No."), "Document Line No." = field("Line No.");

                        column(Comment_SalesCommentLine; Comment)
                        {
                        }
                    }
                    trigger OnPostDataItem()
                    begin
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                        TrackingSpecCount :=
                          ItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer,
                            "Sales Shipment Header"."No.", DATABASE::"Sales Shipment Header", 0);
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(false);
                    end;

                    trigger OnAfterGetRecord()
                    var
                        RecLCountryRegion: Record "Country/Region";
                    begin
                        if RecGItem.Get("No.") then begin
                            if RecGItem."Tariff No." <> '' then
                                TexTGHSClassification := StrSubstNo('%1 %2', HSClassificationLabel, RecGItem."Tariff No.");
                            if (RecGItem."Country/Region of Origin Code" <> '') AND RecLCountryRegion.Get(RecGItem."Country/Region of Origin Code") then
                                TxTGCountryOfOrigin := StrSubstNo('%1 %2', CountryOfOriginLabel, RecLCountryRegion.Name)
                            else
                                TxTGCountryOfOrigin := '';
                        end else
                            TexTGHSClassification := '';

                        If "Sales Shipment Line".Type = "Sales Shipment Line".Type::" " then
                            TxtGQuantity := ''
                        else
                            TxtGQuantity := format("Sales Shipment Line".Quantity)
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter(Type, '<>%1', Type::" ");
                        SetFilter(Quantity, '<>%1', 0);
                    end;
                }

                dataitem(Comments; "Sales Comment Line")
                {
                    DataItemLinkReference = "Sales Shipment Header";
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = where("Document Type" = const(6));

                    column(CommentsLines; Comment)
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    SetRange("No.", RunningHeader."No.");
                    TxtGParcel1Text := '';
                    TxtGParcel2Text := '';
                    TxtGParcel3Text := '';
                    TxtGParcel4Text := '';
                end;

                trigger OnAfterGetRecord()
                var
                    RecLCountryRegion: Record "Country/Region";
                begin
                    If RecGCustomer.Get("Sell-to Customer No.") then;
                    FormatAddressFields("Sales Shipment Header");
                    If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                    TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");
                    /*If RecLCountryRegion.Get("Bill-to Country/Region Code") then;
                    TxtGInvoivingAddress := StrSubstNo('%1, %2, %3, %4, %5, %6', BillToAddr[1], BillToAddr[2], BillToAddr[3], BillToAddr[4], BillToAddr[5], BillToAddr[6], RecLCountryRegion."County Name");
                    */
                    TxtGInvoivingAddress := GetInvocingAddress();
                    if RecGUserSetup.Get("User ID") then;

                    if ("BBX Parcel 1 Size" <> '') or ("BBX Parcel 1 Weight" <> 0) then
                        TxtGParcel1Text := StrSubstNo('%1 %2%3', Parcel1CaptionLbl, "BBX Parcel 1 Size", BlankZero("BBX Parcel 1 Weight"));
                    if ("BBX Parcel 2 Size" <> '') or ("BBX Parcel 2 Weight" <> 0) then
                        TxtGParcel2Text := StrSubstNo('%1 %2%3', Parcel2CaptionLbl, "BBX Parcel 2 Size", BlankZero("BBX Parcel 2 Weight"));
                    if ("BBX Parcel 3 Size" <> '') or ("BBX Parcel 3 Weight" <> 0) then
                        TxtGParcel3Text := StrSubstNo('%1 %2%3', Parcel3CaptionLbl, "BBX Parcel 3 Size", BlankZero("BBX Parcel 3 Weight"));
                    if ("BBX Parcel 4 Size" <> '') or ("BBX Parcel 4 Weight" <> 0) then
                        TxtGParcel4Text := StrSubstNo('%1 %2%3', Parcel4CaptionLbl, "BBX Parcel 4 Size", BlankZero("BBX Parcel 4 Weight"));
                end;

            }
            dataitem(ItemTrackingLine; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(TrackingSpecBufferNo; TrackingSpecBuffer."Item No.")
                {
                }
                column(TrackingSpecBufferDesc; TrackingSpecBuffer.Description)
                {
                }
                column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                {
                }
                column(TrackingSpecBufferSerNo; TrackingSpecBuffer."Serial No.")
                {
                }
                column(TrackingSpecBufferQtyBase; TrackingSpecBuffer."Quantity (Base)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        TrackingSpecBuffer.FindSet
                    else
                        TrackingSpecBuffer.Next;

                    /*if not ShowCorrectionLines and TrackingSpecBuffer.Correction then
                        CurrReport.Skip();*/
                    if TrackingSpecBuffer.Correction then
                        TrackingSpecBuffer."Quantity (Base)" := -TrackingSpecBuffer."Quantity (Base)";

                    /*ShowTotal := false;
                    if ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer) then
                        ShowTotal := true;*/

                    //ShowGroup := false;
                    if (TrackingSpecBuffer."Source Ref. No." <> OldRefNo) or
                       (TrackingSpecBuffer."Item No." <> OldNo)
                    then begin
                        OldRefNo := TrackingSpecBuffer."Source Ref. No.";
                        OldNo := TrackingSpecBuffer."Item No.";
                        TotalQty := 0;
                    end;/* else
                        ShowGroup := true;*/
                    TotalQty += TrackingSpecBuffer."Quantity (Base)";
                end;

                trigger OnPreDataItem()
                begin
                    if TrackingSpecCount = 0 then
                        CurrReport.Break();
                    SetRange(Number, 1, TrackingSpecCount);
                    TrackingSpecBuffer.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                      "Source Prod. Order Line", "Source Ref. No.");
                end;
            }
            dataitem(TotalItemTracking; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Quantity1; TotalQty)
                {
                }
            }

            trigger OnPreDataItem()
            begin
                TrackingSpecCount := 0;
                OldRefNo := 0;
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

                TotalQty := 0;
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
        DocumentTitleLbl: Label 'DELIVERY BILL';
        DeliveryAddressCaptionLbl: Label 'Delivery address:';
        QuotationCaptionLbl: Label 'Quotation:';
        DeliveryDateCaptionLbl: Label 'Delivery date:';
        YourPurchaseOrderCaptionLbl: Label 'Your purchase order:';
        DateOfOrderCaptionLbl: Label 'Date of order:';
        OurReferenceCaptionLbl: Label 'Our reference:';
        YourReferenceCaptionLbl: Label 'Your reference:';
        PhoneCapionLbl: Label 'Phone:';
        CustomerEORICaptionLbl: Label 'EORI Number:';
        InvoicingAddressCaptionLbl: Label 'Invoicing address:';
        QTYCaptionLbl: Label 'Qty';
        ItemNoCaptionLbl: Label 'Art. N°';
        DescCaptionLbl: Label 'Designation';
        TxTGCountryOfOrigin: Text;
        TexTGHSClassification: Text;
        CountryOfOriginLabel: Label 'Country of origin: ';
        HSClassificationLabel: Label 'HS. Classification: ';
        Parcel1CaptionLbl: Label 'Parcel 1:';
        Parcel2CaptionLbl: Label 'Parcel 2:';
        Parcel3CaptionLbl: Label 'Parcel 3:';
        Parcel4CaptionLbl: Label 'Parcel 4:';
        QuantityCaptionLbl: Label 'Quantity';
        SerialNoCaptionLbl: Label 'Serial No.';
        LotNoCaptionLbl: Label 'Lot No.';
        DescriptionCaptionLbl: Label 'Description';
        NoCaptionLbl: Label 'No.';
        ShowCustAddr: Boolean;
        TxtGFooter: Text;
        TxtGQuantity: Text;
        TxtGParcel1Text: Text;
        TxtGParcel2Text: Text;
        TxtGParcel3Text: Text;
        TxtGParcel4Text: Text;
        TxtGInvoivingAddress: Text;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        RecGCustomer: Record Customer;
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RecGItem: Record Item;
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        RecGCountryRegion: Record "Country/Region";
        RecGUserSetup: Record "User Setup";
        FormatAddr: Codeunit "Format Address";
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        TotalQty: Decimal;
        NoOfCopies: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        TrackingSpecCount: Integer;
        NoOfLoops: Integer;
        OldHeader: Record "Sales Shipment Header";
        RunningHeader: Record "Sales Shipment Header";

    local procedure FormatAddressFields(var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        FormatAddr.SalesShptBillTo(BillToAddr, CustAddr, "Sales Shipment Header");
        //ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure BlankZero(DecPNumber: Decimal): Text
    begin
        if DecPNumber <> 0 then
            exit(StrSubstNo(', %1 kg', Format(DecPNumber, 0, '<Integer Thousand><Decimals,3>')))
        else
            exit('');
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