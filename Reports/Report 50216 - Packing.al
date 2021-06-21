report 50216 "BBX Packing"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = 'BlueBotics Packing.docx';
    Caption = 'BlueBotics Packing';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(PackingLine; "BBX PackingLine")
        {
            column(CustAddr1; CustAddr[1])
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CustAddr5; CustAddr[5])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(Shipmentdate; FORMAT(SalesShipmentHeader."Shipment Date", 0, 4))
            {

            }
            column(SellToCustomer; SalesShipmentHeader."Sell-to Customer No.")
            {

            }
            column(SelltoCustomerCaptionLbl; SelltoCustomerCaptionLbl)
            {

            }
            column(CustAddr6; CustAddr[6])
            {
            }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoEMail; CompanyInfo."E-Mail")
            {
            }
            column(SalesPersonText; SalesPersonText)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }

            column(CustAddr7; CustAddr[7])
            {
            }
            column(CustAddr8; CustAddr[8])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }

            //column(DocDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Document Date", 0, 4))           
            column(OutputNo; OutputNo)
            {
            }

            column(PageCaption; PageCaptionCap)
            {
            }

            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(VATRegNoCaption; VATRegNoCaptionLbl)
            {
            }
            column(GiroNoCaption; GiroNoCaptionLbl)
            {
            }
            column(BankNameCaption; BankNameCaptionLbl)
            {
            }
            column(BankAccNoCaption; BankAccNoCaptionLbl)
            {
            }

            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(ShipmentDateLbl; ShipmentDateLbl)
            {

            }
            column(PaymentLbl; PaymentLbl)
            { }

            column(NoCaptionLbl; NoCaptionLbl)
            {

            }
            column(PackingNo; PackingNo)
            {

            }
            column(ItemRefLbl; ItemRefLbl)
            {

            }
            column(ItemNo; ItemNo)
            {

            }
            column(descriptionlbl; descriptionlbl)
            {

            }
            column(Description; Description)
            {

            }
            column(QuantityCaptionLbl; QuantityCaptionLbl)
            {

            }
            column(Qty; Qty)
            {

            }
            column(paletteNolbl; paletteNolbl)
            {

            }
            column(TariffLbl; TariffLbl)
            {

            }
            column(VariantCodeLbl; VariantCodeLbl)
            {

            }
            column(boxlbl; boxlbl)
            {

            }
            column(BoxNo; BoxNo)
            {

            }
            column(ShipmentNoCaptionLbl; ShipmentNoCaptionLbl)
            {

            }
            column(ShipmentNo; ShipmentNo)
            {

            }
            //column(ShipDate; FORMAT("Sales Invoice Header"."Shipment Date", 0, 4))
            column(variantcode; VariantCode)
            {

            }
            column(CountryRegionOriginCode; CountryRegionOriginCode)
            {

            }
            column(TariffNo; TariffNo)
            {

            }
            column(boxlblD; boxlbl)
            {

            }
            column(BoxNoD; PackingLine.BoxNo)
            {

            }

            column(totweightlbl; totweightlbl)
            {

            }
            column(totweighlblD; PackingLine.WeightLine)
            {

            }
            column(sizelbl; sizelbl)
            {

            }
            column(sizeD; PackingLine.Size)
            {

            }

            column(paletteNoD; PackingLine.PaletteNo)
            {

            }
            column(TotalPalettLbl; TotalPalettLbl)
            {

            }
            column(TotalPalett; TotalPalett)
            {

            }
            column(TotalBoxLbl; TotalBoxLbl)
            {

            }
            column(TotalBox; TotalBox)
            {

            }
            column(TotalWeightPackingLbl; TotalWeightPackingLbl)
            {

            }
            column(TotalWeightPacking; TotalWeightPacking)
            {

            }
            column(PackingLine_Quantity; PackingLine.Qty)
            {

            }
            trigger OnAfterGetRecord()
            var
                Item: Record Item;
            begin

                CountryRegionOriginCode := '';
                TariffNo := '';
                IF Item.get(ItemNo) THEN begin
                    CountryRegionOriginCode := Item."Country/Region of Origin Code";
                    TariffNo := Item."Tariff No.";
                END;

            end;

        }
        dataitem(Integer; Integer)
        {

            trigger OnPreDataItem()
            var
                recPackingLine: Record "BBX PackingLine";
                xcop: code[20];
            begin
                xcop := '-$ùm@ççè^l';
                //Message(PackingLine.GetFilter(PackingNo));
                recPackingLineTMP.DeleteAll();
                recPackingLine.SetFilter(PackingNo, '%1', PackingLine.GetFilter(PackingNo));
                if recPackingLine.FindSet() then begin
                    repeat
                        if xcop <> recPackingLine.BoxNo then begin
                            xcop := recPackingLine.BoxNo;
                            recPackingLineTMP.TransferFields(recPackingLine);
                            recPackingLineTMP.TotalBoxWeight := recPackingLine.WeightLine;
                            recPackingLineTMP.Insert();
                        end
                        else begin
                            recPackingLineTMP.TotalBoxWeight += recPackingLine.WeightLine;
                            recPackingLineTMP.Modify();
                        end;
                    until recPackingLine.Next() = 0;
                end;
                //Message(Format(recPackingLineTMP.Count()));
                Integer.SetRange(Number, 1, recPackingLineTMP.Count());

            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    recPackingLineTMP.FindFirst()
                else
                    recPackingLineTMP.Next();

            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        RecLPackingLine: Record "BBX PackingLine";
        TempPackingLinePalett: Record "BBX PackingLine" temporary;
        TempPackingLineBox: Record "BBX PackingLine" temporary;
        RecLPackaging: Record "BBX Packaging";
        CodLPaletNumber: Code[20];
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(Picture);
        RecLPackingLine.SetFilter(PackingNo, PackingLine.GetFilter(PackingNo));
        if RecLPackingLine.FindFirst() then BEGIN
            SalesShipmentHeader.GET(RecLPackingLine.ShipmentNo);
            FormatAddressFields(SalesShipmentHeader);
        END;
        RecLPackingLine.RESET;
        RecLPackingLine.SetFilter(PackingNo, PackingLine.GetFilter(PackingNo));
        IF RecLPackingLine.FindSet() THEN
            repeat
                TempPackingLinePalett.RESET;
                TempPackingLinePalett.Setrange(BoxType, RecLPackingLine.BoxType);
                IF TempPackingLinePalett.IsEmpty then begin
                    TempPackingLinePalett.TransferFields(RecLPackingLine);
                    TempPackingLinePalett.INSERT;


                    IF not RecLPackaging.Get(RecLPackaging.TypePackaging::Palette, TempPackingLinePalett.PaletteType) then
                        RecLPackaging.init;

                    TotalWeightPacking += RecLPackaging.Weight;

                end;
                TempPackingLineBox.RESET;
                TempPackingLineBox.Setrange(BoxNo, RecLPackingLine.BoxNo);
                IF TempPackingLineBox.IsEmpty then begin
                    TempPackingLineBox.TransferFields(RecLPackingLine);
                    TempPackingLineBox.INSERT;

                    IF not RecLPackaging.Get(RecLPackaging.TypePackaging::Box, TempPackingLineBox.BoxType) then
                        RecLPackaging.init;

                    TotalWeightPacking += RecLPackaging.Weight;

                end;
                TotalWeightPacking += RecLPackingLine.WeightLine;
            UNTIL RecLPackingLine.NEXT = 0;
        TempPackingLinePalett.RESET;
        TempPackingLineBox.RESET;
        //TotalPalett := TempPackingLinePalett.Count;
        TotalBox := TempPackingLineBox.Count;

        RecLPackingLine.SetCurrentKey(PackingNo);
        RecLPackingLine.SetFilter(PackingNo, PackingLine.GetFilter(PackingNo));
        IF RecLPackingLine.FindSet() THEN begin
            repeat
                if RecLPackingLine.PaletteNo = '' then
                    exit;

                if CodLPaletNumber = '' then begin
                    CodLPaletNumber := RecLPackingLine.PaletteNo;
                    TotalPalett += 1;
                end
                else begin
                    if CodLPaletNumber <> RecLPackingLine.PaletteNo then begin
                        CodLPaletNumber := RecLPackingLine.PaletteNo;
                        TotalPalett += 1;
                    end;
                end;
            until RecLPackingLine.Next() = 0;
        end;
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header");
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    var
        recPackingLineTMP: Record "BBX PackingLine" temporary;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record "language";
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        RespCenter: Record "Responsibility Center";
        recItem: Record Item;
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit "SegManagement";
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        ItemTrackingAppendixCaptionLbl: TextConst ENU = 'Item Tracking - Appendix', FRA = 'Traçabilité - Annexe';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        VariantCodeLbl: TextConst ENU = 'Variant Code', FRA = 'Code variante';

        VATRegNoCaptionLbl: TextConst ENU = 'VAT Reg. No.', FRA = 'N° id. intracomm.';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankNameCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° expédition';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'Email', FRA = 'E-mail';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        LineDimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        SelltoCustomerCaptionLbl: TextConst ENU = 'Sell-to Customer', FRA = 'Client';
        BilltoAddressCaptionLbl: TextConst ENU = 'Bill-to Address', FRA = 'Adresse facturation';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', FRA = 'Quantité';
        SerialNoCaptionLbl: TextConst ENU = 'Serial No.', FRA = 'N° de série';
        LotNoCaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        NoCaptionLbl: TextConst ENU = 'Packing No.', FRA = 'N° packing';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2';
        ShipQtyLbl: TextConst ENU = 'Shipped Qty.', FRA = 'Qté. livré';
        VATCaptionLbl: TextConst ENU = 'VAT', FRA = 'TVA';
        ItemRefLbl: TextConst ENU = 'Reference', FRA = 'Référence';
        OriginCountryLbl: TextConst ENU = 'Origin Country', FRA = 'Pays d''origine';
        TariffNoLbl: TextConst ENU = 'Customer', FRA = 'Douane';
        ShipmentDateLbl: TextConst ENU = 'Shipment Date', FRA = 'Date de livraison';
        PaymentLbl: TextConst ENU = 'Payment', FRA = 'Paiement';
        TotalWeightPackingLbl: TextConst ENU = 'Total Weight (kg)', FRA = 'Poids total (kg)';
        TotalPalettLbl: TextConst ENU = 'Total Palett Number', FRA = 'Nombre de Palette';
        TotalBoxLbl: TextConst ENU = 'Total Box Number', FRA = 'Nombre de Box';
        TotalWeightPacking: Decimal;
        TotalPalett: Decimal;
        TotalBox: Decimal;
        CurrencyFooterLbl: TextConst ENU = 'The Currency is in %1', FRA = 'La devise est %1';
        SentenceFooter1Lbl: TextConst ENU = 'Invoice payable %1 for Amount %2 %3 by %4', FRA = 'Facture payable le %1 pour la somme de %2 %3 par %4';
        PaletteLbl: TextConst ENU = 'Pallet number', FRA = 'N° Palette';
        BoxLbl: TextConst ENU = 'Box number', FRA = 'N° Box';

        TariffLbl: TextConst ENU = 'Tariff No', FRA = 'Code Douane';

        descriptionlbl: label 'Description';

        totweightlbl: TextConst ENU = 'Total Weight (kg)', FRA = 'Poids total (kg)';
        sizelbl: Label 'Size (cm)';
        paletteNolbl: Label 'Palette No.';
        CountryRegionOriginCode: code[10];
        TariffNo: Code[20];

}