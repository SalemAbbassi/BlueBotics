report 50219 "Copy Data"
{
    Caption = 'Copy Data';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Sales Shipment Header" = rm,
                    tabledata "Sales Invoice Header" = rm,
                    tabledata "Sales Cr.Memo Header" = rm,
                    tabledata "Production Order" = rm,
                    tabledata "Prod. Order Line" = rm;
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(BooGImportShipmentHeader; BooGImportShipmentHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Sales Shipment Header';
                    }
                    field(BooGImportInvoiceHeader; BooGImportInvoiceHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Sales Invoice Header';
                    }
                    field(BooGImportCrMemoHeader; BooGImportCrMemoHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Sales Cr. Memo Header';
                    }
                    field(BooGImportProdOrders; BooGImportProdOrders)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Prod. Orders Header';
                    }
                    field(BooGImportProdOrdersLine; BooGImportProdOrdersLine)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Prod. Order Lines';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if BooGImportShipmentHeader then
                CduGImportData.ImportSalesShipmentHader();

            if BooGImportInvoiceHeader then
                CduGImportData.ImportSalesInvoiceHader();

            if BooGImportCrMemoHeader then
                CduGImportData.ImportSalesCrMemoHader();

            if BooGImportProdOrders then
                CduGImportData.ImportProductionOrders();

            if BooGImportProdOrdersLine then
                CduGImportData.ImportProductionOrderLines();
        end;
    }

    var
        BooGImportShipmentHeader: Boolean;
        BooGImportInvoiceHeader: Boolean;
        BooGImportCrMemoHeader: Boolean;
        BooGImportProdOrders: Boolean;
        BooGImportProdOrdersLine: Boolean;
        CduGImportData: Codeunit "BBX ImportData";
}