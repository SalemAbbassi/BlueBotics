report 50218 "BBX Quantity Explosion of BOM"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BlueBotics - QuantityExplosionofBOM.rdl';
    AccessByPermission = TableData "Production Order" = R;
    ApplicationArea = Manufacturing;
    Caption = 'BlueBotics Quantity Explosion of BOM';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";
            column(BBXVendorName_Item; BBXVendorName)
            {
            }
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {
            }
            column(BBXVendorNameCaption; FieldCaption(BBXVendorName))
            {
            }
            /*column(VendorItemNo_Item; "Vendor Item No.")
            {
            }*/
            column(VendorItemNoCaption; FieldCaption("Vendor Item No."))
            {
            }
            column(AsOfCalcDate; Text000 + Format(CalculateDate))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(TodayFormatted; Format(Today))
            {
            }
            column(DateCaptLbl; DateCaptLbl)
            {

            }
            column(ItemTableCaptionFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Desc_Item; Description)
            {
            }
            column(QtyExplosionofBOMCapt; QtyExplosionofBOMCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(BOMQtyCaption; BOMQtyCaptionLbl)
            {
            }
            column(BomCompLevelQtyCapt; BomCompLevelQtyCaptLbl)
            {
            }
            column(BomCompLevelDescCapt; BomCompLevelDescCaptLbl)
            {
            }
            column(BomCompLevelNoCapt; BomCompLevelNoCaptLbl)
            {
            }
            column(LevelCapt; LevelCaptLbl)
            {
            }
            column(BomCompLevelUOMCodeCapt; BomCompLevelUOMCodeCaptLbl)
            {
            }
            column(RecGCompanyInformationPicture; RecGCompanyInformation.Picture)
            {

            }
            column(ItemNoCaptLbl; ItemNoCaptLbl)
            {

            }
            column(ItemNameCaptLbl; ItemNameCaptLbl)
            {

            }
            dataitem("Production BOM Line"; "Production BOM Line")
            {
                DataItemLinkReference = Item;
                DataItemLink = "Production BOM No." = field("Production BOM No.");
                DataItemTableView = where(Type = const(Item));

                column(No_ProductionBOMLine; "No.")
                {
                }
                column(Description_ProductionBOMLine; Description)
                {
                }
                column(Quantity_ProductionBOMLine; Quantity)
                {
                }
                column(UnitofMeasureCode_ProductionBOMLine; "Unit of Measure Code")
                {
                }
                column(ItemVendorName; RecGItem.BBXVendorName)
                {
                }
                column(VendorItemNo; RecGItem."Vendor Item No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not RecGItem.Get("Production BOM Line"."No.") then RecGItem.Init();
                    RecGItem.CalcFields(BBXVendorName);
                end;
            }

            dataitem(BOMLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(BomCompLevelNo; BomComponent[Level]."No.")
                    {
                    }
                    column(BomCompLevelDesc; BomComponent[Level].Description)
                    {
                    }
                    column(BOMQty; BOMQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(FormatLevel; PadStr('', Level, ' ') + Format(Level))
                    {
                    }
                    column(BomCompLevelQty; BomComponent[Level].Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(BomCompLevelUOMCode; BomComponent[Level]."Unit of Measure Code")
                    {
                    }
                    column(BomItemVendorName; CompItem.BBXVendorName)
                    {
                    }
                    column(BOM_VendorItemNo; CompItem."Vendor Item No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BOMQty := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                    end;

                    trigger OnPostDataItem()
                    begin
                        Level := NextLevel;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    BomItem: Record Item;
                begin
                    while BomComponent[Level].Next = 0 do begin
                        Level := Level - 1;
                        if Level < 1 then
                            CurrReport.Break();
                        if Level > IntGLevel then
                            CurrReport.Break();
                    end;


                    NextLevel := Level;

                    Clear(CompItem);
                    QtyPerUnitOfMeasure := 1;
                    case BomComponent[Level].Type of
                        BomComponent[Level].Type::Item:
                            begin
                                CompItem.Get(BomComponent[Level]."No.");
                                if CompItem."Production BOM No." <> '' then begin
                                    ProdBOM.Get(CompItem."Production BOM No.");
                                    if ProdBOM.Status = ProdBOM.Status::Closed then
                                        CurrReport.Skip();
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                    NoList[NextLevel] := CompItem."No.";
                                    VersionCode[NextLevel] :=
                                      VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, true);
                                    BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                                    BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                end;
                                if Level > 1 then
                                    if BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item then
                                        if BomItem.Get(BomComponent[Level - 1]."No.") then
                                            QtyPerUnitOfMeasure :=
                                              UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") /
                                              UOMMgt.GetQtyPerUnitOfMeasure(
                                                BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                            end;
                        BomComponent[Level].Type::"Production BOM", BomComponent[Level].Type::" ":
                            CurrReport.Skip();
                    /*begin
                        ProdBOM.Get(BomComponent[Level]."No.");
                        if ProdBOM.Status = ProdBOM.Status::Closed then
                            CurrReport.Skip();
                        NextLevel := Level + 1;

                        if Level > 1 then
                            if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                        Clear(BomComponent[NextLevel]);
                        NoListType[NextLevel] := NoListType[NextLevel] ::"Production BOM";
                        NoList[NextLevel] := ProdBOM."No.";
                        VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, true);
                        BomComponent[NextLevel].SetRange("Production BOM No.", NoList[NextLevel]);
                        BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                        BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                        BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                    end;*/
                    end;

                    CompItem.CalcFields(BBXVendorName);
                    if NextLevel <> Level then
                        Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                end;

                trigger OnPreDataItem()
                begin
                    Level := 1;

                    ProdBOM.Get(Item."Production BOM No.");

                    VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, true);
                    Clear(BomComponent);
                    BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                    BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
                    BomComponent[Level].SetRange("Version Code", VersionCode[Level]);
                    BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                    BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                    NoListType[Level] := NoListType[Level] ::Item;
                    NoList[Level] := Item."No.";
                    Quantity[Level] :=
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        Item,
                        VersionMgt.GetBOMUnitOfMeasure(
                          Item."Production BOM No.", VersionCode[Level]));
                end;
            }

            trigger OnPreDataItem()
            begin
                //Level := IntGLevel;

                ItemFilter := GetFilters;
                SetFilter("Production BOM No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields(BBXVendorName);
                RecGCompanyInformation.Get;
                RecGCompanyInformation.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CalculateDate; CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the date you want the program to calculate the quantity of the BOM lines.';
                    }
                    field(Level; IntGLevel)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Level';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalculateDate := WorkDate;
            Level := 1;
        end;
    }

    labels
    {
    }

    var
        Text000: Label 'As of ';
        ProdBOM: Record "Production BOM Header";
        BomComponent: array[99] of Record "Production BOM Line";
        CompItem: Record Item;
        RecGItem: Record Item;
        RecGCompanyInformation: Record "Company Information";
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text;
        ItemFilterDescription: Text;
        CalculateDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        IntGLevel: Integer;
        BOMQty: Decimal;
        DateCaptLbl: Label 'Date: ';
        ItemNoCaptLbl: Label 'Item No';
        ItemNameCaptLbl: Label 'Item Name';
        QtyExplosionofBOMCaptLbl: Label 'Bill Of Material';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        TxtGLevel: Text;
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';

}

