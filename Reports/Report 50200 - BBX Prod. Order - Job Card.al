report 50200 "BBC Prod. Order - Job Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BBX Prod. Order - Job Card.rdl';
    AdditionalSearchTerms = 'production order - job card,work order job card';
    ApplicationArea = Manufacturing;
    Caption = 'BlueBotics - Prod. Order - Job Card';
    UsageCategory = ReportsAndAnalysis;
    EnableExternalImages = true;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";

            column(ProdOrderNoCaption; ProdOrderNoCaptionLbl)
            {
            }
            column(CustomerIDCaption; CustomerIDCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(BootfileCaption; BootfileCaptionLbl)
            {
            }
            column(QuantityCaption; FieldCaption(Quantity))
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Status_ProdOrder; Status)
            {
            }
            column(StickerCodeCaption_ProdOrder; FieldCaption("BBX Sticker Code"))
            {
            }
            column(StickerCode_ProdOrder; RecGStickers.Name)
            {
            }
            column(No_ProdOrder; "No.")
            {
            }

            column(BootFile; "BBX BootFile")
            {
            }
            column(IDCustomer; "BBX Customer ID")
            {
            }
            column(CustomerName; RecGCustomer.Name)
            {
            }
            column(BarCode; RecGCompanyInfoTemp.Picture)//TxtGBarCodeText)
            {
            }
            column(Description; Description)
            {
            }
            column(DescriptionCaptionLbl; FieldCaption(Description))
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
                {
                }
                column(ProdOrderTableCaptionFilt; "Production Order".TABLECAPTION + ':' + ProdOrderFilter)
                {
                }
                column(ProdOrderFilter; ProdOrderFilter)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(ProdOrderJobCardCaption; ProdOrderJobCardCaptionLbl)
                {
                }
            }
            dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
            {
                DataItemLink = Status = FIELD(Status),
                               "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
                column(RtngNo_ProdOrderRtngLine; "Routing No.")
                {
                    IncludeCaption = true;
                }
                column(OPNo_ProdOrderRtngLine; "Operation No.")
                {
                    IncludeCaption = true;
                }
                column(Type_ProdOrderRtngLine; Type)
                {
                    IncludeCaption = true;
                }
                column(No_ProdOrderRtngLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(StrtTim_ProdOrderRtngLine; "Starting Time")
                {
                    IncludeCaption = true;
                }
                column(StrtDt_ProdOrderRtngLine; FORMAT("Starting Date"))
                {
                }
                column(EndTime_ProdOrderRtngLine; "Ending Time")
                {
                    IncludeCaption = true;
                }
                column(EndDate_ProdOrderRtngLine; FORMAT("Ending Date"))
                {
                }
                column(ExpCapNd_ProdOrderRtngLine; "Expected Capacity Need")
                {
                }
                column(Desc_ProdOrder; "Production Order".Description)
                {
                }
                column(SourceNo_ProdOrder; "Production Order"."Source No.")
                {
                }
                column(ProdOrdrRtngLineRTUOMCode; CapacityUoM)
                {
                }
                column(PrdOrdNo_ProdOrderRtngLine; "Prod. Order No.")
                {
                    IncludeCaption = true;
                }
                column(ProdOrderRtngLnStrtDtCapt; ProdOrderRtngLnStrtDtCaptLbl)
                {
                }
                column(ProdOrdRtngLnEndDatCapt; ProdOrdRtngLnEndDatCaptLbl)
                {
                }
                column(ProdOrdRtngLnExpcCapNdCpt; ProdOrdRtngLnExpcCapNdCptLbl)
                {
                }
                column(PrecalcTimesCaption; PrecalcTimesCaptionLbl)
                {
                }
                column(ProdOrderSourceNoCapt; ProdOrderSourceNoCaptLbl)
                {
                }
                column(OutputCaption; OutputCaptionLbl)
                {
                }
                column(ScrapCaption; ScrapCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(ByCaption; ByCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status = FIELD(Status),
                                   "Prod. Order No." = FIELD("Prod. Order No."),
                                   "Routing Link Code" = FIELD("Routing Link Code");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(Position_ProdOrderComp; Position)
                    {
                        IncludeCaption = true;
                    }
                    column(Position2_ProdOrderComp; "Position 2")
                    {
                        IncludeCaption = true;
                    }
                    column(LdTimOffset_ProdOrderComp; "Lead-Time Offset")
                    {
                        IncludeCaption = true;
                    }
                    column(ExpectedQty_ProdOrderComp; "Expected Quantity")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_ProdOrderComp; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
                    {
                    }
                    column(Desc_ProdOrderComp; Description)
                    {
                    }
                    column(OrderNo_ProdOrderComp; "Prod. Order No.")
                    {
                    }
                    column(MaterialRequirementsCapt; MaterialRequirementsCaptLbl)
                    {
                    }
                    column(VendorItemNo; RecGItem."Vendor Item No.")
                    {
                    }
                    column(VendorNo; RecGItem."Vendor No.")
                    {
                    }
                    column(VendorName; RecGVendor.Name)
                    {
                    }
                    column(VendorNameCaption; VendorNameCaptionLbl)
                    {
                    }
                    column(VendorItemNoCaption; RecGItem.FieldCaption("Vendor Item No."))
                    {
                    }
                    column(VendorNoCaption; RecGItem.FieldCaption("Vendor No."))
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if not RecGItem.Get("Item No.") then RecGItem.Init();
                        if not RecGVendor.Get(RecGItem."Vendor No.") then RecGVendor.Init();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    WorkCenter: Record 99000754;
                    CalendarMgt: Codeunit 99000755;
                begin
                    WorkCenter.GET("Work Center No.");
                    CapacityUoM := WorkCenter."Unit of Measure Code";
                    "Expected Capacity Need" := "Expected Capacity Need" / CalendarMgt.TimeFactor(CapacityUoM);
                end;
            }

            trigger OnAfterGetRecord()
            var
                ProdOrderRoutingLine: Record 5409;
            begin
                GetBarCode("Production Order");
                RecGCustomer.SetRange("BBX Customer ID", "BBX Customer ID");
                if RecGCustomer.FindFirst() then;

                ProdOrderRoutingLine.SETRANGE(Status, Status);
                ProdOrderRoutingLine.SETRANGE("Prod. Order No.", "No.");
                IF NOT ProdOrderRoutingLine.FINDFIRST THEN
                    CurrReport.SKIP;
                if not RecGStickers.Get("Production Order"."BBX Sticker Code") then RecGStickers.Init();
            end;

            trigger OnPreDataItem()
            begin
                ProdOrderFilter := GETFILTERS;
            end;
        }
    }

    var
        RecGStickers: Record "BBX Stickers";
        ProdOrderFilter: Text;
        CapacityUoM: Code[10];
        CurrReportPageNoCaptionLbl: Label 'Page';
        ProdOrderJobCardCaptionLbl: Label 'Prod. Order - Job Card';
        ProdOrderRtngLnStrtDtCaptLbl: Label 'Starting Date';
        ProdOrdRtngLnEndDatCaptLbl: Label 'Ending Date';
        ProdOrdRtngLnExpcCapNdCptLbl: Label 'Time Needed';
        PrecalcTimesCaptionLbl: Label 'Precalc. Times';
        ProdOrderSourceNoCaptLbl: Label 'Item No.';
        OutputCaptionLbl: Label 'Output';
        ScrapCaptionLbl: Label 'Scrap';
        DateCaptionLbl: Label 'Date';
        ByCaptionLbl: Label 'By';
        EmptyStringCaptionLbl: Label '___________';
        MaterialRequirementsCaptLbl: Label 'Material Requirements';
        ItemDescriptionCaptionLbl: Label 'Description';
        ProdOrderNoCaptionLbl: Label 'Prod. Order No.';
        CustomerIDCaptionLbl: Label 'Customer ID';
        CustomerCaptionLbl: Label 'Customer';
        BootfileCaptionLbl: Label 'Bootfile';
        VendorNameCaptionLbl: Label 'Vendor Name';
        TxtGDescription: Text;
        TxtCustomerName: Text;
        RecGCustomer: Record Customer;
        TextGConvertValue: Text;
        CduGTempBlob: Codeunit "Temp Blob";
        CduGConvert: Codeunit "Base64 Convert";
        TxtGBarCodeText: Text;
        Instream: InStream;
        RecGCompanyInfoTemp: Record "Company Information" temporary;
        RecGItem: Record Item;
        RecGVendor: Record Vendor;

    procedure getBarCode(txtBarCodeValue: Text; txtBarCodeType: text; intWidth: integer; intHeight: integer; intMargin: integer; booNoText: Boolean)
    var
        cduBarCode: Codeunit "IBODigital sBarcode";
        cduTempBlob: Codeunit "Temp Blob";
        recRef: recordref;
        fldRef: fieldref;
    begin
        cduBarCode.GenerateBarcode(txtBarCodeValue, txtBarCodeType, format(intWidth), format(intHeight), format(intMargin), format(booNoText, 0, 9), cduTempBlob);
        RecGCompanyInfoTemp.Init();
        recref.GetTable(RecGCompanyInfoTemp);
        fldref := recref.Field(RecGCompanyInfoTemp.fieldno(Picture));
        cdutempblob.ToFieldRef(fldref);
        recref.setTable(RecGCompanyInfoTemp);
    end;

    local procedure GetBarCode(var RecPProdOrder: Record "Production Order")
    var
        RecLProdOrderComponent: Record "Prod. Order Component";
    begin
        RecLProdOrderComponent.SetRange(Status, RecPProdOrder.Status);
        RecLProdOrderComponent.SetRange("Prod. Order No.", RecPProdOrder."No.");
        if RecLProdOrderComponent.FindFirst() then;
        TextGConvertValue := RecPProdOrder."No." + '|' + RecLProdOrderComponent."Item No.";
        getBarCode(TextGConvertValue, 'CODE_128', 100, 400, 0, true);
        //TxtGBarCodeText := CduGConvert.ToBase64(Instream)
    end;

    local procedure VisitUrlAndSaveFileResult(TextPConvertValue: Text; Var CduPTempBlob: Codeunit "Temp Blob")
    var
        clienthttp: HttpClient;
        HttpReqMessage: HttpRequestMessage;
        HttpResponseMEss: HttpResponseMessage;
        Method: Text;
        Outstream: Outstream;
    begin
        Method := (StrSubstNo('http://www.barcodes4.me/barcode/c128b/%1.jpg', TextPConvertValue));

        HttpReqMessage.SetRequestUri(Method);
        //clienthttp.Post('http://www.barcodes4.me/barcode/c128b/1000.jpg', HTTPContenttt, HttpResponseMEss);

        If not clienthttp.send(HttpReqMessage, HttpResponseMEss) then
            Error('call failed');

        HttpResponseMEss.Content.ReadAs(Instream);
        clear(CduPTempBlob);
        CduPTempBlob.CreateOutStream(Outstream);
        CopyStream(Outstream, Instream);
    end;
}

