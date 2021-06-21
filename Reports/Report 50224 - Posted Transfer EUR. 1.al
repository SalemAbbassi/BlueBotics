report 50224 "BBX Posted Transfer EUR. 1"
{
    WordLayout = './BlueBotics Posted Transfer - EUR. 1.docx';
    Caption = 'BlueBotics Posted Transfer - EUR. 1';
    DefaultLayout = Word;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(No_; RecGTransferShipmentHeader."No.")
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
                RecGTransferShipmentHeader.SetFilter("No.", TxtGTransferShipHeaderNo);
                SetRange(Number, 1, RecGTransferShipmentHeader.Count);
            end;

            trigger OnAfterGetRecord()
            var
                RecLTransferShipmentLine: Record "Transfer Shipment Line";
            begin
                if Number = 1 then
                    RecGTransferShipmentHeader.Find('-')
                else
                    RecGTransferShipmentHeader.Next();

                FormatAddressFields(RecGTransferShipmentHeader);

                RecLTransferShipmentLine.SetRange("Document No.", RecGTransferShipmentHeader."No.");
                if RecLTransferShipmentLine.FindFirst() then
                    if RecGItem.Get(RecLTransferShipmentLine."Item No.") then
                        CodGTariffNumber := RecGItem."Tariff No.";
            end;
        }
        dataitem(TransferShipHeader; "Transfer Shipment Header")
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
            dataitem(Lines; "Transfer Shipment Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = TransferShipHeader;
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
                    SetFilter(Quantity, '<>%1', 0);
                end;

                trigger OnAfterGetRecord()
                begin
                    if RecGItem.Get("Item No.") then;
                    IntGLineNumber += 1;
                end;
            }
            trigger OnPreDataItem()
            begin
                SetFilter("No.", TxtGTransferShipHeaderNo);
            end;
        }

        dataitem(ExporterText; "Transfer Shipment Line")
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
                SetFilter("Document No.", TxtGTransferShipHeaderNo);
                SetFilter(Quantity, '<>%1', 0);
            end;

            trigger OnAfterGetRecord()
            begin
                if RecGItem2.Get("Item No.") then;
            end;
        }
        dataitem(TransferFromAddress; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(TransferFromAddr1; TransferFromAddr[1])
            {
            }
            column(TransferFromAddr2; TransferFromAddr[2])
            {
            }
            column(TransferFromAddr3; TransferFromAddr[3])
            {
            }
            column(TransferFromAddr4; TransferFromAddr[4])
            {
            }
            column(TransferFromAddr5; TransferFromAddr[5])
            {
            }
            column(TransferFromAddr6; TransferFromAddr[6])
            {
            }
            column(TransferFromAddr7; TransferFromAddr[7])
            {
            }
            column(TransferFromAddr8; TransferFromAddr[8])
            {
            }
        }
        dataitem(TransferToAddress; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(TransfertoAddr1; TransferToAddr[1])
            {
            }
            column(TransfertoAddr2; TransferToAddr[2])
            {
            }
            column(TransfertoAddr3; TransferToAddr[3])
            {
            }
            column(TransfertoAddr4; TransferToAddr[4])
            {
            }
            column(TransfertoAddr5; TransferToAddr[5])
            {
            }
            column(TransfertoAddr6; TransferToAddr[6])
            {
            }
            column(TransfertoAddr7; TransferToAddr[7])
            {
            }
            column(TransfertoAddr8; TransferToAddr[8])
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
                group("Posted Transfer Shipment")
                {
                    Caption = 'Posted Transfer Shipment';
                    field(TransferShipHeaderNo; TransferShipHeaderNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            TransferShipmentList: Page "Posted Transfer Shipments";
                            RecLTransferShipmentHeader: Record "Transfer Shipment Header";
                            SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        begin
                            Text := '';
                            TransferShipmentList.LookupMode(true);
                            TransferShipmentList.SetTableView(RecLTransferShipmentHeader);
                            if TransferShipmentList.RunModal = Action::LookupOK then begin
                                TransferShipmentList.SetSelectionFilter(RecLTransferShipmentHeader);
                                if RecLTransferShipmentHeader.FindSet() then
                                    repeat
                                        if Text = '' then begin
                                            Text := RecLTransferShipmentHeader."No.";
                                        end
                                        else
                                            Text += '|' + RecLTransferShipmentHeader."No.";
                                    until RecLTransferShipmentHeader.Next() = 0;

                                exit(true);
                            end;
                        end;

                        trigger OnValidate()
                        var
                            RecLTransferShipmentHeader: Record "Sales Shipment Header";
                            DecLTotalWeight: Decimal;
                        begin
                            DecLTotalWeight := 0;
                            RecLTransferShipmentHeader.SetFilter("No.", TransferShipHeaderNo);
                            if RecLTransferShipmentHeader.FindSet() then
                                repeat
                                    DecLTotalWeight += RecLTransferShipmentHeader."BBX Parcel 1 Weight";
                                    DecLTotalWeight += RecLTransferShipmentHeader."BBX Parcel 2 Weight";
                                    DecLTotalWeight += RecLTransferShipmentHeader."BBX Parcel 3 Weight";
                                    DecLTotalWeight += RecLTransferShipmentHeader."BBX Parcel 4 Weight";
                                until RecLTransferShipmentHeader.Next() = 0;
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
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction in [Action::Ok, Action::LookupOK] then begin
                if TxtGTransferShipHeaderNo = '' then
                    Error('"No" must not be empty');
            end;
        end;

        trigger OnClosePage()
        begin
            FctSetValues(TransferShipHeaderNo);
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
        TxtGTransferShipHeaderNo: Text;
        TransferShipHeaderNo: Text;
        CodGTariffNumber: Code[20];
        CodGSalesShpNo: Code[20];
        BooGShowExporterDeclaration: Boolean;
        CompanyAddr: array[8] of Text[100];
        TransferFromAddr: array[8] of Text[100];
        TransferToAddr: array[8] of Text[100];
        FormatAddr: Codeunit "Format Address";
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        RecGCountryRegion: Record "Country/Region";
        RecGItem: Record Item;
        RecGItem2: Record Item;
        DeclarationValue: Text;
        RecGTransferShipmentHeader: Record "Transfer Shipment Header";
        RecGTransferShipmentLine: Record "Transfer Shipment Line";

    local procedure FormatAddressFields(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        FormatAddr.Company(CompanyAddr, CompanyInfo);
        FormatAddr.TransferShptTransferFrom(TransferFromAddr, TransferShipmentHeader);
        FormatAddr.TransferShptTransferTo(TransferToAddr, TransferShipmentHeader);
    end;

    local procedure FctSetValues(TxtPFilter: Text)
    var
        RecLTransferShipmentHeader: Record "Sales Shipment Header";
    begin
        TxtGTransferShipHeaderNo := TxtPFilter;
        RecLTransferShipmentHeader.SetFilter("No.", TxtPFilter);
        if RecLTransferShipmentHeader.FindFirst() then
            CodGSalesShpNo := RecLTransferShipmentHeader."No.";
    end;

    local procedure ReplaceString(String: Text[250]) NewString: Text[250]
    var
    begin
        WHILE STRPOS(String, 'BL') > 0 DO
            String := DELSTR(String, STRPOS(String, 'BL')) + 'PF' + COPYSTR(String, STRPOS(String, 'BL') + STRLEN('BL'));
        NewString := String;
    end;
}