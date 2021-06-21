report 50221 "BBX Posted Transf. Sales Ship."
{
    WordLayout = './BlueBotics Posted transfer Sales Shipment.docx';
    Caption = 'BlueBotics Posted Transfer Sales Shipment';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = CopyLoop;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending);
            dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
            {
                column(TransferToAddr1; TransferToAddr[1])
                {
                }
                column(TransferFromAddr1; TransferFromAddr[1])
                {
                }
                column(TransferToAddr2; TransferToAddr[2])
                {
                }
                column(TransferFromAddr2; TransferFromAddr[2])
                {
                }
                column(TransferToAddr3; TransferToAddr[3])
                {
                }
                column(TransferFromAddr3; TransferFromAddr[3])
                {
                }
                column(TransferToAddr4; TransferToAddr[4])
                {
                }
                column(TransferFromAddr4; TransferFromAddr[4])
                {
                }
                column(TransferToAddr5; TransferToAddr[5])
                {
                }
                column(TransferToAddr6; TransferToAddr[6])
                {
                }

                column(No_SalesShipHeader; "No.")
                {
                }
                column(TransferOrderNo_; "Transfer Order No.")
                {
                }
                column(TransferOrderDate; format("Transfer Order Date", 0, '<day,2>.<month,2>.<year4>'))
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
                column(PostingDate_Header; FORMAT("Posting Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(OrderDate_Header; FORMAT("Transfer Order Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(YourReference_Header; "Transfer-to Contact")
                {
                }
                column(OurReference_Header; "Transfer-from Contact")
                {
                }
                column(Footer; TxtGFooter)
                {
                }
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                {
                    DataItemLinkReference = "Transfer Shipment Header";
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    column(Quantity_Line; Quantity)
                    {
                    }
                    column(ItemNo_Line; "Item No.")
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
                    column(CrossReferenceNo_Line; GetITemCorssReferenceNo("Transfer Shipment Line"))
                    {
                    }

                    /*dataitem("Sales Comment Line"; "Sales Comment Line")
                    {
                        DataItemLinkReference = "Transfer Shipment Line";
                        DataItemTableView = where("Document Type" = const(6), Code = const('Customer'));
                        DataItemLink = "No." = field("Document No."), "Document Line No." = field("Line No.");

                        column(Comment_SalesCommentLine; Comment)
                        {
                        }
                    }*/

                    trigger OnAfterGetRecord()
                    var
                        RecLCountryRegion: Record "Country/Region";
                    begin
                        if RecGItem.Get("Item No.") then begin
                            if RecGItem."Tariff No." <> '' then
                                TexTGHSClassification := StrSubstNo('%1 %2', HSClassificationLabel, RecGItem."Tariff No.");
                            if (RecGItem."Country/Region of Origin Code" <> '') AND RecLCountryRegion.Get(RecGItem."Country/Region of Origin Code") then
                                TxTGCountryOfOrigin := StrSubstNo('%1 %2', CountryOfOriginLabel, RecLCountryRegion.Name)
                            else
                                TxTGCountryOfOrigin := '';
                        end else
                            TexTGHSClassification := '';
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter(Quantity, '<>%1', 0);
                    end;

                    trigger OnPostDataItem()
                    var
                        CodLBatchName: Code[10];
                    begin
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                        ItemTrackingDocMgt.RetrieveEntriesFromShptRcpt(ItemLedgerEntryBuffer,
                            DATABASE::"Transfer Shipment Line", 0, "Document No.", '', 0, "Line No.");
                        TrackingSpecCount := ItemLedgerEntryBuffer.Count;
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(false);
                    end;
                }
                dataitem(Comments; "Sales Comment Line")
                {
                    DataItemLinkReference = "Transfer Shipment Header";
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = where("Document Type" = const(6));

                    column(CommentsLines; Comment)
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    SetRange("No.", RunningHeader."No.");
                end;

                trigger OnAfterGetRecord()
                begin
                    FormatAddressFields("Transfer Shipment Header");
                    If RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
                    TxtGFooter := StrSubstNo('%1, %2, %3-%4, %5, Tel: %6, email: %7', CompanyAddr[1], CompanyAddr[2], CompanyInfo."Country/Region Code", CompanyAddr[3], RecGCountryRegion.Name, CompanyInfo."Phone No.", CompanyInfo."E-Mail");


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
                column(TrackingSpecBufferNo; ItemLedgerEntryBuffer."Item No.")
                {
                }
                column(TrackingSpecBufferDesc; ItemLedgerEntryBuffer.Description)
                {
                }
                column(TrackingSpecBufferLotNo; ItemLedgerEntryBuffer."Lot No.")
                {
                }
                column(TrackingSpecBufferSerNo; ItemLedgerEntryBuffer."Serial No.")
                {
                }
                column(TrackingSpecBufferQtyBase; ItemLedgerEntryBuffer."Quantity")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        ItemLedgerEntryBuffer.FindSet
                    else
                        ItemLedgerEntryBuffer.Next;
                    if ItemLedgerEntryBuffer.Correction then
                        ItemLedgerEntryBuffer."Quantity" := -ItemLedgerEntryBuffer."Quantity";

                    if (ItemLedgerEntryBuffer."Source No." <> OldRefNo) or
                       (ItemLedgerEntryBuffer."Item No." <> OldNo)
                    then begin
                        OldRefNo := ItemLedgerEntryBuffer."Source No.";
                        OldNo := ItemLedgerEntryBuffer."Item No.";
                        TotalQty := 0;
                    end;

                    TotalQty += ItemLedgerEntryBuffer."Quantity";
                end;

                trigger OnPreDataItem()
                begin
                    if TrackingSpecCount = 0 then
                        CurrReport.Break();
                    SetRange(Number, 1, TrackingSpecCount);
                    ItemLedgerEntryBuffer.SetCurrentKey("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
                    /*TrackingSpecBuffer.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                      "Source Prod. Order Line", "Source Ref. No.");*/
                end;
            }
            dataitem(TotalItemTracking; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Quantity1; TotalQty)
                {
                }
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



            trigger OnPreDataItem()
            begin
                NoOfLoops := "Transfer Shipment Header".Count * (Abs(NoOfCopies) + 1);
                SetRange(Number, 1, NoOfLoops);
                OldHeader.COPY("Transfer Shipment Header");
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
        DocumentTitleLbl: Label 'TRANSFER DELIVERY BILL';
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
        CompanyAddr: array[8] of Text[100];
        TransferFromAddr: array[8] of Text[100];
        TransferToAddr: array[8] of Text[100];
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RecGItem: Record Item;
        RecGCountryRegion: Record "Country/Region";
        FormatAddr: Codeunit "Format Address";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OldHeader: Record "Transfer Shipment Header";
        RunningHeader: Record "Transfer Shipment Header";
        //TrackingSpecBuffer: Record "Tracking Specification" temporary;
        ItemLedgerEntryBuffer: Record "Item Ledger Entry" temporary;
        OldRefNo: Code[20];
        OldNo: Code[20];
        TrackingSpecCount: Integer;
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        TotalQty: Decimal;

    local procedure FormatAddressFields(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        FormatAddr.TransferShptTransferFrom(TransferFromAddr, "Transfer Shipment Header");
        FormatAddr.TransferShptTransferTo(TransferToAddr, "Transfer Shipment Header");
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    local procedure BlankZero(DecPNumber: Decimal): Text
    begin
        if DecPNumber <> 0 then
            exit(StrSubstNo(', %1', Format(DecPNumber, 0, '<Integer Thousand><Decimals,3>')))
        else
            exit('');
    end;

    local procedure GetITemCorssReferenceNo(RecPTransferShipmentLine: Record "Transfer Shipment Line") CodRResult: Code[20]
    var
        RecLItemCrossReference: Record "Item Cross Reference";
    begin
        CodRResult := '';
        RecLItemCrossReference.SetRange("Item No.", RecLItemCrossReference."Item No.");
        RecLItemCrossReference.SetRange("Variant Code", RecLItemCrossReference."Variant Code");
        if RecLItemCrossReference.FindFirst() then
            CodRResult := RecLItemCrossReference."Cross-Reference No.";
        exit(CodRResult)
    end;
}