tableextension 50234 "BBX Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        modify("Lot No.")
        {
            Caption = 'PPC Serial Number';
        }
    }
    procedure GetCustomerNo(): Code[20]
    var
        RecLSalesHeader: Record "Sales Header";
        RecLPurchaseHeader: Record "Purchase Header";
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
        RecLReturnReceiptHeader: Record "Return Receipt Header";
        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TxtLCustomerNo: Code[20];
    begin
        TxtLCustomerNo := '';
        case "Document Type" of
            "Document Type"::"Sales Shipment":
                begin
                    if RecLSalesShipmentHeader.Get("Document No.") then
                        TxtLCustomerNo := RecLSalesShipmentHeader."Sell-to Customer No.";
                end;
            "Document Type"::"Sales Invoice":
                begin
                    if RecLSalesInvoiceHeader.Get("Document No.") then
                        TxtLCustomerNo := RecLSalesInvoiceHeader."Sell-to Customer No.";
                end;
            "Document Type"::"Sales Return Receipt":
                begin
                    if RecLReturnReceiptHeader.Get("Document Type") then
                        TxtLCustomerNo := RecLReturnReceiptHeader."Sell-to Customer No.";
                end;
            "Document Type"::"Sales Credit Memo":
                begin
                    if RecLSalesCrMemoHeader.Get("Document Type") then
                        TxtLCustomerNo := RecLSalesCrMemoHeader."Sell-to Customer No.";
                end;
        end;
        exit(TxtLCustomerNo);
    end;

    procedure GetCustomerName(): Text[100]
    var
        RecLSalesHeader: Record "Sales Header";
        RecLPurchaseHeader: Record "Purchase Header";
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
        RecLReturnReceiptHeader: Record "Return Receipt Header";
        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TxtLCustomerName: Text[100];
    begin
        TxtLCustomerName := '';
        case "Document Type" of
            "Document Type"::"Sales Shipment":
                begin
                    if RecLSalesShipmentHeader.Get("Document No.") then
                        TxtLCustomerName := RecLSalesShipmentHeader."Sell-to Customer Name";
                end;
            "Document Type"::"Sales Invoice":
                begin
                    if RecLSalesInvoiceHeader.Get("Document No.") then
                        TxtLCustomerName := RecLSalesInvoiceHeader."Sell-to Customer Name";
                end;
            "Document Type"::"Sales Return Receipt":
                begin
                    if RecLReturnReceiptHeader.Get("Document Type") then
                        TxtLCustomerName := RecLReturnReceiptHeader."Sell-to Customer Name";
                end;
            "Document Type"::"Sales Credit Memo":
                begin
                    if RecLSalesCrMemoHeader.Get("Document Type") then
                        TxtLCustomerName := RecLSalesCrMemoHeader."Sell-to Customer Name";
                end;
        end;
        exit(TxtLCustomerName);
    end;
}