report 50215 "BBX EUR. 1"
{
    WordLayout = './BlueBotics EUR. 1.docx';
    Caption = 'BlueBotics EUR. 1';
    DefaultLayout = Word;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; Integer)
        {
            DataItemTableView = where(Number = const(1));
            //RequestFilterFields = "No.", "Sell-to Customer No.";
            //RequestFilterHeading = 'Posted Sales Shipment';
            column(No_; RecGSalesShipmentHeader."No.")
            {
            }
            column(DestinationCountry; RecGCountryRegion.Name)
            {
            }
            column(ItemDimensions; TxtGItemDimensions)
            {
            }
            column(Weight; StrSubstNo('%1 %2', DecGWeight, 'kg'))
            {
            }
            column(DeclarationValue; DeclarationValue)
            {
            }
            column(TariffNumber; CodGTariffNumber)
            {
            }
            trigger OnPreDataItem()
            begin
                RecGSalesShipmentHeader.SetFilter("No.", TxtGSalesShipHeaderNo);
                SetRange(Number, 1, RecGSalesShipmentHeader.Count);
            end;

            trigger OnAfterGetRecord()
            var
                RecLSalesShipmentLine: Record "Sales Shipment Line";
            begin
                if Number = 1 then
                    RecGSalesShipmentHeader.Find('-')
                else
                    RecGSalesShipmentHeader.Next();

                FormatAddressFields(RecGSalesShipmentHeader);
                if RecGCountryRegion.Get(RecGSalesShipmentHeader."Bill-to Country/Region Code") then;

                RecLSalesShipmentLine.SetRange("Document No.", RecGSalesShipmentHeader."No.");
                if RecLSalesShipmentLine.FindFirst() then
                    if RecGItem.Get(RecLSalesShipmentLine."No.") then
                        CodGTariffNumber := RecGItem."Tariff No.";
            end;
        }
        dataitem(SalesShipHeader; "Sales Shipment Header")
        {
            column(TransportationBoxCaption; TransportationBoxCaptionLbl)
            {
            }
            column(ProformaNo; ReplaceString("No."))
            {
            }
            column(BLWeight; StrSubstNo('%1 %2', "BBX Parcel 1 Weight" + "BBX Parcel 2 Weight" + "BBX Parcel 3 Weight" + "BBX Parcel 4 Weight", 'kg'))
            {
            }
            dataitem(Lines; "Sales Shipment Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = SalesShipHeader;
                DataItemLink = "Document No." = field("No.");
                column(Quantity; Quantity)
                {
                }
                column(ItemDesc; RecGItem.Description)
                {
                }
                column(TariffNo; RecGItem."Tariff No.")
                {
                }
                column(LineNumber; StrSubstNo('%1 %2', IntGLineNumber, ')'))
                {
                }
                column(PSRCaption; PSRCaptionLbl)
                {
                }
                trigger OnPreDataItem()
                begin
                    SetFilter(Type, '<>%1', Type::" ");
                    SetFilter(Quantity, '<>%1', 0);
                    //SetFilter("Document No.", TxtGSalesShipHeaderNo);
                    //IntGLineNumber := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    if RecGItem.Get("No.") then;
                    IntGLineNumber += 1;
                end;
            }
            trigger OnPreDataItem()
            begin
                SetFilter("No.", TxtGSalesShipHeaderNo);
            end;
        }

        dataitem(ExporterText; "Sales Shipment Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            column(ItemDesignation; RecGItem2.Description)
            {
            }
            column(MarchandiseText; MarchandiseText)
            {
            }
            column(PositionDouaniereText; PositionDouaniereText)
            {
            }
            column(ExporateurText; ExporateurText)
            {
            }
            trigger OnPreDataItem()
            begin
                /*if not BooGShowExporterDeclaration then
                    CurrReport.Break();*/
                SetFilter("Document No.", TxtGSalesShipHeaderNo);
                SetFilter(Type, '<>%1', Type::" ");
                SetFilter(Quantity, '<>%1', 0);
            end;

            trigger OnAfterGetRecord()
            begin
                if RecGItem2.Get("No.") then;
            end;
        }
        dataitem(ShippAddr; Integer)
        {
            DataItemTableView = where(Number = const(1));
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
        }
        dataitem(BillingAddr; Integer)
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
            column(CompanyAddress4; RecGCountryRegion.Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if RecGCountryRegion.Get(CompanyInfo."Country/Region Code") then;
            end;
        }
        dataitem(Captions; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = CONST(1));
            column(SwitzerlandCaption; SwitzerlandCaptionLbl)
            {
            }
            column(Asterics; AstericsText)
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Posted Sales Shipment")
                {
                    Caption = 'Posted Sales Shipment';
                    field(SellToCustomerNo; CodGSellToCustomerNo)
                    {
                        ApplicationArea = Basic, Suite;
                        TableRelation = Customer;
                        Caption = 'Sell-to Customer No.';
                        ShowMandatory = true;
                    }
                    field(SalesShipHeaderNo; TxtGSalesShipHeaderNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesShipmentList: Page "Posted Sales Shipments";
                            RecLSalesShipmentHeader: Record "Sales Shipment Header";
                            SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        begin
                            if CodGSellToCustomerNo = '' then
                                Error(CstGError);
                            Text := '';
                            SalesShipmentList.LookupMode(true);
                            RecLSalesShipmentHeader.SetRange("Sell-to Customer No.", CodGSellToCustomerNo);
                            SalesShipmentList.SetTableView(RecLSalesShipmentHeader);
                            if not (SalesShipmentList.RunModal = Action::LookupOK) then
                                exit(False);

                            SalesShipmentList.SetSelectionFilter(RecLSalesShipmentHeader);
                            if RecLSalesShipmentHeader.FindSet() then
                                repeat
                                    if Text = '' then begin
                                        Text := RecLSalesShipmentHeader."No.";
                                    end
                                    else
                                        Text += '|' + RecLSalesShipmentHeader."No.";
                                until RecLSalesShipmentHeader.Next() = 0;

                            exit(true);
                        end;

                        trigger OnValidate()
                        var
                            RecLSalesShipmentHeader: Record "Sales Shipment Header";
                            DecLTotalWeight: Decimal;
                        begin
                            DecLTotalWeight := 0;
                            RecLSalesShipmentHeader.SetFilter("No.", TxtGSalesShipHeaderNo);
                            if RecLSalesShipmentHeader.FindSet() then
                                repeat
                                    DecLTotalWeight += RecLSalesShipmentHeader."BBX Parcel 1 Weight";
                                    DecLTotalWeight += RecLSalesShipmentHeader."BBX Parcel 2 Weight";
                                    DecLTotalWeight += RecLSalesShipmentHeader."BBX Parcel 3 Weight";
                                    DecLTotalWeight += RecLSalesShipmentHeader."BBX Parcel 4 Weight";
                                until RecLSalesShipmentHeader.Next() = 0;
                            DecGWeight := DecLTotalWeight;
                        end;
                    }
                }
                group(Options)
                {
                    Caption = 'Options';
                    field(Weight; DecGWeight)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Weight';
                    }
                    field(ItemDimension; TxtGItemDimensions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions';
                    }
                    /* field(BooGShowExporterDeclaration; BooGShowExporterDeclaration)
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'Show Exporter Declaration Text';
                     }*/
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if not (CloseAction in [Action::Cancel, Action::LookupCancel]) then begin
                if CodGSellToCustomerNo = '' then
                    Error('Field "Sell-to Customer No" must not be empty.');
                if TxtGSalesShipHeaderNo = '' then
                    Error('"No" must not be empty');
            end;
        end;

        trigger OnClosePage()
        begin
            FctSetValues(TxtGSalesShipHeaderNo);
        end;
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
    end;

    var
        SwitzerlandCaptionLbl: Label 'Switzerland';
        TransportationBoxCaptionLbl: Label 'Transportation Box containing';
        PSRCaptionLbl: Label 'PSR';
        AstericsText: Label '*******************************************************************************************************';
        MarchandiseText: Label 'Marchandise suffisamment ouvrée selon liste';
        PositionDouaniereText: Label 'Position douanière';
        ExporateurText: Label 'A disposition chez l''exportateur';
        CstGError: TextConst ENU = 'Sell-to Customer No. must not be empty';
        DecGWeight: Decimal;
        TxtGItemDimensions: Text;
        IntGLineNumber: Integer;
        TxtGSalesShipHeaderNo: Text;
        CodGTariffNumber: Code[20];
        CodGSellToCustomerNo: Code[20];
        CodGSalesShpNo: Code[20];
        BooGShowExporterDeclaration: Boolean;
        ShipToAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        FormatAddr: Codeunit "Format Address";
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RecGCountryRegion: Record "Country/Region";
        RecGItem: Record Item;
        RecGItem2: Record Item;
        DeclarationValue: Text;
        RecGSalesShipmentHeader: Record "Sales Shipment Header";
        RecGSalesShipmentLine: Record "Sales Shipment Line";

    local procedure FormatAddressFields(var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        FormatAddr.SalesShptBillTo(BillToAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FctSetValues(TxtPFilter: Text)
    var
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
    begin
        TxtGSalesShipHeaderNo := TxtPFilter;
        RecLSalesShipmentHeader.SetFilter("No.", TxtPFilter);
        if RecLSalesShipmentHeader.FindFirst() then
            CodGSalesShpNo := RecLSalesShipmentHeader."No.";
    end;

    local procedure ReplaceString(String: Text[250]) NewString: Text[250]
    var
    begin
        WHILE STRPOS(String, 'BL') > 0 DO
            String := DELSTR(String, STRPOS(String, 'BL')) + 'PF' + COPYSTR(String, STRPOS(String, 'BL') + STRLEN('BL'));
        NewString := String;
    end;
}