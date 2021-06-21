codeunit 50204 "BBX ImportData"
{
    Permissions = tabledata "Sales Shipment Header" = rm,
                    tabledata "Sales Invoice Header" = rm,
                    tabledata "Sales Cr.Memo Header" = rm,
                    tabledata "Production Order" = rm,
                    tabledata "Prod. Order Line" = rm;
    trigger OnRun()
    begin

    end;

    procedure ImportSalesShipmentHader()
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        if UploadResult then begin
            If Name <> '' then
                Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
            else
                exit;

            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
            Rec_ExcelBuffer.ReadSheet();

            //finding total number of Rows to Import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            If Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows := Rows + 1;
                until Rec_ExcelBuffer.Next() = 0;
            //Message('No. of rows %1', Rows);


            //Finding total number of columns to import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Columns := Columns + 1;
                until Rec_ExcelBuffer.Next() = 0;

            //Function to Get the last line number in Job Journal
            LineNo := FindLineNo();

            for RowNo := 4 to Rows do begin
                CodGSalesShipmentHeader := GetValueAtIndex(RowNo, 1);
                if RecGSalesShipmentHeader.Get(CodGSalesShipmentHeader) then begin
                    RecGSalesShipmentHeader."BBX EORI Number" := GetValueAtIndex(RowNo, 2);
                    RecGSalesShipmentHeader."BBX Customer ID" := GetValueAtIndex(RowNo, 3);

                    if GetValueAtIndex(RowNo, 4) = 'false' then
                        RecGSalesShipmentHeader."BBX Partner " := false
                    else
                        RecGSalesShipmentHeader."BBX Partner " := true;

                    RecGSalesShipmentHeader."BBX Courier Account" := GetValueAtIndex(RowNo, 5);


                    if GetValueAtIndex(RowNo, 6) = 'false' then
                        RecGSalesShipmentHeader."BBX Proof of export" := false
                    else
                        RecGSalesShipmentHeader."BBX Proof of export" := true;

                    if GetValueAtIndex(RowNo, 7) = 'false' then
                        RecGSalesShipmentHeader."BBX EUR1" := false
                    else
                        RecGSalesShipmentHeader."BBX EUR1" := true;


                    if GetValueAtIndex(RowNo, 8) = 'false' then
                        RecGSalesShipmentHeader."BBX Shipment received" := false
                    else
                        RecGSalesShipmentHeader."BBX Shipment received" := true;

                    RecGSalesShipmentHeader."BBX Project Manager" := GetValueAtIndex(RowNo, 9);


                    if GetValueAtIndex(RowNo, 10) = 'false' then
                        RecGSalesShipmentHeader.BBXSentByMail := false
                    else
                        RecGSalesShipmentHeader.BBXSentByMail := true;


                    RecGSalesShipmentHeader."BBX Parcel 1 Size" := GetValueAtIndex(RowNo, 11);
                    Evaluate(RecGSalesShipmentHeader."BBX Parcel 1 Weight", GetValueAtIndex(RowNo, 12));
                    RecGSalesShipmentHeader."BBX Parcel 2 Size" := GetValueAtIndex(RowNo, 13);
                    Evaluate(RecGSalesShipmentHeader."BBX Parcel 2 Weight", GetValueAtIndex(RowNo, 14));
                    RecGSalesShipmentHeader."BBX Parcel 3 Size" := GetValueAtIndex(RowNo, 15);
                    Evaluate(RecGSalesShipmentHeader."BBX Parcel 3 Weight", GetValueAtIndex(RowNo, 16));
                    RecGSalesShipmentHeader."BBX Parcel 4 Size" := GetValueAtIndex(RowNo, 17);
                    Evaluate(RecGSalesShipmentHeader."BBX Parcel 4 Weight", GetValueAtIndex(RowNo, 18));
                    RecGSalesShipmentHeader.Modify(false)
                end;
            end;
            Message('Sales Shipment Header Import Completed');
        end;
    end;

    procedure ImportSalesInvoiceHader()
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        if UploadResult then begin
            If Name <> '' then
                Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
            else
                exit;

            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
            Rec_ExcelBuffer.ReadSheet();

            //finding total number of Rows to Import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            If Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows := Rows + 1;
                until Rec_ExcelBuffer.Next() = 0;
            //Message('No. of rows %1', Rows);


            //Finding total number of columns to import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Columns := Columns + 1;
                until Rec_ExcelBuffer.Next() = 0;

            //Function to Get the last line number in Job Journal
            LineNo := FindLineNo();

            for RowNo := 4 to Rows do begin
                CodeGSalesInvoiceHeaderCode := GetValueAtIndex(RowNo, 1);
                if RecGSalesInvoiceHeader.Get(CodeGSalesInvoiceHeaderCode) then begin
                    RecGSalesInvoiceHeader."BBX EORI Number" := GetValueAtIndex(RowNo, 2);
                    RecGSalesInvoiceHeader."BBX Customer ID" := GetValueAtIndex(RowNo, 3);

                    if GetValueAtIndex(RowNo, 4) = 'false' then
                        RecGSalesInvoiceHeader."BBX Partner " := false
                    else
                        RecGSalesInvoiceHeader."BBX Partner " := true;

                    RecGSalesInvoiceHeader."BBX Courier Account" := GetValueAtIndex(RowNo, 5);


                    if GetValueAtIndex(RowNo, 6) = 'false' then
                        RecGSalesInvoiceHeader."BBX Proof of export" := false
                    else
                        RecGSalesInvoiceHeader."BBX Proof of export" := true;

                    if GetValueAtIndex(RowNo, 7) = 'false' then
                        RecGSalesInvoiceHeader."BBX EUR1" := false
                    else
                        RecGSalesInvoiceHeader."BBX EUR1" := true;


                    if GetValueAtIndex(RowNo, 8) = 'false' then
                        RecGSalesInvoiceHeader."BBX Shipment received" := false
                    else
                        RecGSalesInvoiceHeader."BBX Shipment received" := true;

                    RecGSalesInvoiceHeader."BBX Project Manager" := GetValueAtIndex(RowNo, 9);


                    if GetValueAtIndex(RowNo, 10) = 'false' then
                        RecGSalesInvoiceHeader.BBXSentByMail := false
                    else
                        RecGSalesInvoiceHeader.BBXSentByMail := true;


                    RecGSalesInvoiceHeader."BBX Parcel 1 Size" := GetValueAtIndex(RowNo, 11);
                    Evaluate(RecGSalesInvoiceHeader."BBX Parcel 1 Weight", GetValueAtIndex(RowNo, 12));
                    RecGSalesInvoiceHeader."BBX Parcel 2 Size" := GetValueAtIndex(RowNo, 13);
                    Evaluate(RecGSalesInvoiceHeader."BBX Parcel 2 Weight", GetValueAtIndex(RowNo, 14));
                    RecGSalesInvoiceHeader."BBX Parcel 3 Size" := GetValueAtIndex(RowNo, 15);
                    Evaluate(RecGSalesInvoiceHeader."BBX Parcel 3 Weight", GetValueAtIndex(RowNo, 16));
                    RecGSalesInvoiceHeader."BBX Parcel 4 Size" := GetValueAtIndex(RowNo, 17);
                    Evaluate(RecGSalesInvoiceHeader."BBX Parcel 4 Weight", GetValueAtIndex(RowNo, 18));
                    RecGSalesInvoiceHeader.Modify(false)
                end;
            end;
            Message('Sales Invoice Header Import Completed');
        end;
    end;

    procedure ImportSalesCrMemoHader()
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        if UploadResult then begin
            If Name <> '' then
                Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
            else
                exit;

            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
            Rec_ExcelBuffer.ReadSheet();

            //finding total number of Rows to Import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            If Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows := Rows + 1;
                until Rec_ExcelBuffer.Next() = 0;
            //Message('No. of rows %1', Rows);


            //Finding total number of columns to import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Columns := Columns + 1;
                until Rec_ExcelBuffer.Next() = 0;

            //Function to Get the last line number in Job Journal
            LineNo := FindLineNo();

            for RowNo := 4 to Rows do begin
                CodeGSalesInvoiceHeaderCode := GetValueAtIndex(RowNo, 1);
                if RecGSalesCrMemoHeader.Get(CodeGSalesInvoiceHeaderCode) then begin
                    RecGSalesCrMemoHeader."BBX EORI Number" := GetValueAtIndex(RowNo, 2);
                    RecGSalesCrMemoHeader."BBX Customer ID" := GetValueAtIndex(RowNo, 3);

                    if GetValueAtIndex(RowNo, 4) = 'false' then
                        RecGSalesCrMemoHeader."BBX Partner " := false
                    else
                        RecGSalesCrMemoHeader."BBX Partner " := true;

                    RecGSalesCrMemoHeader."BBX Courier Account" := GetValueAtIndex(RowNo, 5);


                    if GetValueAtIndex(RowNo, 6) = 'false' then
                        RecGSalesCrMemoHeader."BBX Proof of export" := false
                    else
                        RecGSalesCrMemoHeader."BBX Proof of export" := true;

                    if GetValueAtIndex(RowNo, 7) = 'false' then
                        RecGSalesCrMemoHeader."BBX EUR1" := false
                    else
                        RecGSalesCrMemoHeader."BBX EUR1" := true;


                    if GetValueAtIndex(RowNo, 8) = 'false' then
                        RecGSalesCrMemoHeader."BBX Shipment received" := false
                    else
                        RecGSalesCrMemoHeader."BBX Shipment received" := true;

                    RecGSalesCrMemoHeader."BBX Project Manager" := GetValueAtIndex(RowNo, 9);


                    if GetValueAtIndex(RowNo, 10) = 'false' then
                        RecGSalesCrMemoHeader.BBXSentByMail := false
                    else
                        RecGSalesCrMemoHeader.BBXSentByMail := true;


                    RecGSalesCrMemoHeader."BBX Parcel 1 Size" := GetValueAtIndex(RowNo, 11);
                    Evaluate(RecGSalesCrMemoHeader."BBX Parcel 1 Weight", GetValueAtIndex(RowNo, 12));
                    RecGSalesCrMemoHeader."BBX Parcel 2 Size" := GetValueAtIndex(RowNo, 13);
                    Evaluate(RecGSalesCrMemoHeader."BBX Parcel 2 Weight", GetValueAtIndex(RowNo, 14));
                    RecGSalesCrMemoHeader."BBX Parcel 3 Size" := GetValueAtIndex(RowNo, 15);
                    Evaluate(RecGSalesCrMemoHeader."BBX Parcel 3 Weight", GetValueAtIndex(RowNo, 16));
                    RecGSalesCrMemoHeader."BBX Parcel 4 Size" := GetValueAtIndex(RowNo, 17);
                    Evaluate(RecGSalesCrMemoHeader."BBX Parcel 4 Weight", GetValueAtIndex(RowNo, 18));
                    RecGSalesCrMemoHeader.Modify(false)
                end;
            end;
            Message('Sales Cr. Memo Header Import Completed');
        end;
    end;

    procedure ImportProductionOrders()
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        if UploadResult then begin
            If Name <> '' then
                Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
            else
                exit;

            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
            Rec_ExcelBuffer.ReadSheet();

            //finding total number of Rows to Import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            If Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows := Rows + 1;
                until Rec_ExcelBuffer.Next() = 0;
            //Message('No. of rows %1', Rows);


            //Finding total number of columns to import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Columns := Columns + 1;
                until Rec_ExcelBuffer.Next() = 0;

            //Function to Get the last line number in Job Journal
            LineNo := FindLineNo();

            for RowNo := 4 to Rows do begin
                TxtGProdOrdStatus := GetValueAtIndex(RowNo, 1);
                CodeGSalesInvoiceHeaderCode := GetValueAtIndex(RowNo, 2);

                case TxtGProdOrdStatus of
                    'Firm Planned':
                        OptGProdOrdStatus := OptGProdOrdStatus::"Firm Planned";
                    'Released':
                        OptGProdOrdStatus := OptGProdOrdStatus::Released;
                    'Finished':
                        OptGProdOrdStatus := OptGProdOrdStatus::Finished;
                end;
                if RecGProductionOrder.Get(OptGProdOrdStatus, CodeGSalesInvoiceHeaderCode) then begin
                    RecGProductionOrder."BBX BootFile" := GetValueAtIndex(RowNo, 3);
                    RecGProductionOrder."BBX Customer ID" := GetValueAtIndex(RowNo, 4);
                    RecGProductionOrder."BBXLink Main Prod. Order No." := GetValueAtIndex(RowNo, 5);
                    RecGProductionOrder."BBX Sales Order No." := GetValueAtIndex(RowNo, 6);
                    RecGProductionOrder."BBX Customer No." := GetValueAtIndex(RowNo, 7);
                    RecGProductionOrder."BBX Customer Name" := GetValueAtIndex(RowNo, 8);
                    RecGProductionOrder.Modify(false)
                end;
            end;
            Message('Production Order Import Completed');
        end;
    end;

    procedure ImportProductionOrderLines()
    var
        IntLLineNo: Integer;
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        if UploadResult then begin
            If Name <> '' then
                Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
            else
                exit;

            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
            Rec_ExcelBuffer.ReadSheet();

            //finding total number of Rows to Import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            If Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows := Rows + 1;
                until Rec_ExcelBuffer.Next() = 0;
            //Message('No. of rows %1', Rows);


            //Finding total number of columns to import
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Columns := Columns + 1;
                until Rec_ExcelBuffer.Next() = 0;

            //Function to Get the last line number in Job Journal
            LineNo := FindLineNo();

            for RowNo := 4 to Rows do begin
                TxtGProdOrdStatus := GetValueAtIndex(RowNo, 1);
                CodeGSalesInvoiceHeaderCode := GetValueAtIndex(RowNo, 2);
                Evaluate(IntLLineNo, GetValueAtIndex(RowNo, 3));

                case TxtGProdOrdStatus of
                    'Firm Planned':
                        OptGProdOrdStatus := OptGProdOrdStatus::"Firm Planned";
                    'Released':
                        OptGProdOrdStatus := OptGProdOrdStatus::Released;
                    'Finished':
                        OptGProdOrdStatus := OptGProdOrdStatus::Finished;
                end;
                if RecGProductionOrderLine.Get(OptGProdOrdStatus, CodeGSalesInvoiceHeaderCode, IntLLineNo) then begin
                    RecGProductionOrderLine."BBX BootFile" := GetValueAtIndex(RowNo, 4);
                    RecGProductionOrderLine."BBX Customer ID" := GetValueAtIndex(RowNo, 5);
                    RecGProductionOrderLine.Modify(false)
                end;
            end;
            Message('Production Order Line Import Completed');
        end;
    end;

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
    begin
        Rec_ExcelBuffer.Reset();
        If Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");

    end;

    local procedure FindLineNo(): Integer
    var
        JobJnl: Record "Job Journal Line";
        LineNo: Integer;
    begin
        JobJnl.Reset();
        JobJnl.SetFilter("Journal Template Name", 'JOB');
        JobJnl.SetCurrentKey(JobJnl."Line No.");
        If JobJnl.FindLast() then
            LineNo := JobJnl."Line No." + 10000
        else
            LineNo := 10000;
        ////Message('Line number %1', LineNo);
        exit(LineNo);
    end;

    var
        Rec_ExcelBuffer: Record "Excel Buffer" temporary;
        Rows: Integer;
        Columns: Integer;
        Fileuploaded: Boolean;
        UploadIntoStream: InStream;
        FileName: Text;
        Sheetname: Text;
        UploadResult: Boolean;
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        RecGSalesShipmentHeader: Record "Sales Shipment Header";
        RecGSalesInvoiceHeader: Record "Sales Invoice Header";
        RecGSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RecGProductionOrder: Record "Production Order";
        RecGProductionOrderLine: Record "Prod. Order Line";
        TxtGProdOrdStatus: Text;
        OptGProdOrdStatus: Enum "Production Order Status";
        CodGSalesShipmentHeader: Code[20];
        CodeGSalesInvoiceHeaderCode: Code[20];
        CodGSalesCrMemoHeaderCode: Code[20];
        RowNo: Integer;
        TxtDate: Text;
        DocumentDate: Date;
        LineNo: Integer;
}
