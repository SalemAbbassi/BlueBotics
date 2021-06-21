report 50217 "BBX Copy Data"
{/*
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Copy Data';
    Permissions = tabledata "Sales Shipment Header" = rm,
                    tabledata "Sales Shipment Line" = rm,
                    tabledata "Sales Invoice Header" = rm,
                    tabledata "Sales Cr.Memo Header" = rm,
                    tabledata "Sales Header Archive" = rm,
                    tabledata "Purch. Inv. Header" = rm,
                    tabledata "Purch. Rcpt. Header" = rm,
                    tabledata "Purch. Cr. Memo Hdr." = rm,
                    tabledata "General Ledger Setup" = rm,
                    tabledata "Posted Whse. Shipment Header" = rm;
    dataset
    {

        //----Specific Tables-----
        dataitem(RepairTemplate; "Repair Template")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXRepairTemplate: Record "BBX Repair Template";
            begin
                RecLBBXRepairTemplate.TransferFields(RepairTemplate);
                RecLBBXRepairTemplate.Insert();
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Repair Template Code");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(RepairTemplateActivities; "Repair Template Activities")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXRepairTemplateActivities: Record "BBX Repair Template Activities";
            begin
                RecLBBXRepairTemplateActivities.Init();
                RecLBBXRepairTemplateActivities.TransferFields(RepairTemplateActivities);
                RecLBBXRepairTemplateActivities.Insert();
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(Symptom; Symptom)
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXSymptom: Record "BBX Symptom";
            begin
                RecLBBXSymptom.Init();
                RecLBBXSymptom.TransferFields(Symptom);
                RecLBBXSymptom.Insert();
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Code);
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(Packaging; Packaging)
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXPackaging: Record "BBX Packaging";
            begin
                RecLBBXPackaging.Init();
                RecLBBXPackaging.TransferFields(Packaging);
                RecLBBXPackaging.Insert();
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + CodePackaging);
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(PackingLine; PackingLine)
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXPackingLine: Record "BBX PackingLine";
            begin
                RecLBBXPackingLine.TransferFields(PackingLine);
                RecLBBXPackingLine.Insert();
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + PackingNo);
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(BBSSetupTable; "BBSSetup Table")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            var
                RecLBBXSetupTable: Record "BBX Setup Table";
            begin
                RecLBBXSetupTable.TransferFields(BBSSetupTable);
                RecLBBXSetupTable.Insert(false);
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Format("Entry No."));
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }

        //-----STD Tables-----
        dataitem(Customer; Customer)
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "DBE EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner" := Partner;
                "BBX Courier Account" := "Courier Account";
                "BBX Pilot" := Pilot;
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                "BBX Invoicing Contact Name" := "DBE Invoicing Contact Name";
                "BBX Logistics Contact Name" := "DBE Logistics Contact Name";
                "BBXProject Manager" := "BBSProject Manager";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesHeader; "Sales Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner" := Partner;
                "BBX Courier Account" := "Courier Account";
                "BBX Effective date" := "Effective date";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                "BBX Firm Planned PO" := "DBE Firm Planned PO";
                "BBX Released PO" := "DBE Released PO";
                "BBX Finished PO" := "DBE Finished PO";
                BBXSentByMail := DBESentByMail;
                "BBX PO Count" := "DBE PO Count";
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner " := "Partner ";
                "BBX Courier Account" := "Courier Account";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                BBXSentByMail := DBESentByMail;
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner " := "Partner ";
                "BBX Courier Account" := "Courier Account";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                "BBXSentByMail" := DBESentByMail;
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesCrMemoHeader; "Sales Cr.Memo Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner " := "Partner ";
                "BBX Courier Account" := "Courier Account";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                "BBXSentByMail" := DBESentByMail;
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesHeaderArchive; "Sales Header Archive")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner " := "Partner ";
                "BBX Courier Account" := "Courier Account";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                "BBXSentByMail" := DBESentByMail;
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Invoicing Contact" := "DBE Invoicing Contact";
                "BBX Logistics Contact" := "DBE Logistics Contact";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(ReturnReceiptHeader; "Return Receipt Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                //"BBX EORI Number" := "EORI Number";
                "BBX Customer ID" := "Customer ID";
                "BBX Partner " := "Partner ";
                "BBX Courier Account" := "Courier Account";
                "BBX Proof of export" := "Proof of export";
                "BBX EUR1" := EUR1;
                "BBX Shipment received" := "Shipment received";
                "BBX Project Manager" := "Project Manager";
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(SalesLine; "Sales Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Effective date" := "Effective date";
                "BBX Due Date" := "Due Date";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(ItemJournalLine; "Item Journal Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Effective date" := "Effective date";
                "BBX Due Date" := "Due Date";
                "BBX BootFile" := BootFile;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Journal Template Name");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(ProductionOrder; "Production Order")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX BootFile" := BootFile;
                "BBX Customer ID" := "Customer ID";
                "BBXLink Main Prod. Order No." := "BBSLink Main Prod. Order No.";
                "BBX Sales Order No." := "DBE Sales Order No.";
                "BBX Customer No." := "DBE Customer No.";
                "BBX Customer Name" := "DBE Customer Name";
                "BBX Finished Quantity" := "DBE Finished Quantity";
                BBXKey := BBSKey;
                "BBXTest Date" := "BBSTest Date";
                "BBXIO Board Firmware" := "BBSIO Board Firmware";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(ProdOrderLine; "Prod. Order Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX BootFile" := BootFile;
                "BBX Customer ID" := "Customer ID";
                BBXKey := BBSKey;
                "BBSTest Date" := "BBXTest Date";
                "BBXIO Board Firmware" := "BBSIO Board Firmware";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Prod. Order No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Tracking Specification"; "Tracking Specification")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX BootFile" := BootFile;
                "BBX Customer ID" := "Customer ID";
                BBXKey := BBSKey;
                "BBSTest Date" := "BBXTest Date";
                "BBXIO Board Firmware" := "BBSIO Board Firmware";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Format("Entry No."));
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Serial No. Information"; "Serial No. Information")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX BootFile" := BootFile;
                "BBX Customer ID" := "Customer ID";
                "BBX License No." := "BBS License No.";
                "BBX Installation Name" := "BBS Installation Name";
                "BBX Installation Address" := "BBS Installation Address";
                "BBX Quantity Of Vehicles" := "BBS Quantity Of Vehicles";
                "BBX Requested By" := "BBS Requested By";
                BBXKey := BBSKey;
                "BBXTest Date" := "BBSTest Date";
                "BBXIO Board Firmware" := "BBSIO Board Firmware";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Item No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(ServiceItem; "Service Item")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX BootFile" := BootFile;
                "BBX Customer ID" := "Customer ID";
                BBXKey := BBSKey;
                "BBXTest Date" := "BBSTest Date";
                "BBXIO Board Firmware" := "BBSIO Board Firmware";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Service Header"; "Service Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Freshdesk Description" := "Freshdesk Description";
                "BBX Work performed" := "Work performed";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                "BBX Approved By" := "Approved By";
                BBXSentByMail := DBESentByMail;
                "BBX xDocument Date" := "DBE xDocument Date";
                "BBX xPosting Date" := "DBE xPosting Date";
                BBXConfirmationReceived := DBEConfirmationReceived;
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                "BBX Approved By" := "Approved By";
                BBXConfirmationReceived := DBEConfirmationReceived;
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                "BBX Approved By" := "Approved By";
                BBXSentByMail := DBESentByMail;
                BBXConfirmationReceived := DBEConfirmationReceived;
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                BBXSentByMail := BBXSentByMail;
                "BBX Approved By" := "Approved By";
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                "BBX Approved By" := "Approved By";
                BBXSentByMail := BBXSentByMail;
                BBXConfirmationReceived := DBEConfirmationReceived;
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Quotation Date" := "Quotation Date";
                "BBX Approved By" := "Approved By";
                BBXSentByMail := DBESentByMail;
                BBXDescription := DBEDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("User Setup"; "User Setup")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Signature" := Signature;
                "BBX Full Name" := "DBE Full Name";
                "BBX Signatory PROFORMA" := "DBE Signatory PROFORMA";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "User ID");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Country/Region"; "Country/Region")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX CH PREF ORIGIN" := "CH PREF ORIGIN";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Code);
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Standard Text"; "Standard Text")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX CH PREF ORIGIN" := "CH PREF ORIGIN";
                "BBX Partner cust" := "DBE Partner cust";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Code);
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Bank Account"; "Bank Account")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                BBXBankShowInvoiceFooter := DBEBankShowInvoiceFooter;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem(Item; Item)
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                BBXVendorName := DEBVendorName;
                BBXPilot := DBEPilot;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Service Item Line"; "Service Item Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Value" := "DBE Value";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Document No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Transfer Header"; "Transfer Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Validated By" := "DBE Validated By";
                "BBX Validated" := "DBE Validated";
                "BBX Sales Order No." := "DBE Sales Order No.";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Validated By" := "DBE Validated By";
                "BBX Validated" := "DBE Validated";
                "BBX Sales Order No." := "DBE Sales Order No.";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Transfer Line"; "Transfer Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Sales Line No." := "DBE Sales Line No.";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Document No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Sales Line No." := "DBE Sales Line No.";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Document No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("General Ledger Setup"; "General Ledger Setup")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Claim %" := "BBC Claim %";
                "BBX Auto. Expense type" := "BBC Auto. Expense type";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Format("Primary Key"));
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("CEM Expense"; "CEM Expense")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                BBXClaimPercentSystem := BBCClaimPercentSystem;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Format("Entry No."));
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Item Vendor"; "Item Vendor")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                BBXVendorName := BBSVendorName;
                BBXItemDescription := BBSItemDescription;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Item No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Source No." := "DBE Source No.";
                "BBX Sell-to Customer No." := "DBE Sell-to Customer No.";
                "BBX Sell-to Customer Name" := "DBE Sell-to Customer Name";
                "BBX Account Number" := "DBE Account Number";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Sales & Receivables Setup"; "Sales & Receivables Setup")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX PackingNos" := PackingNos;
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Primary Key");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Job Task"; "Job Task")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Standby From" := "DBE Standby From";
                "BBX New Status" := "DBE New Status";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "Job No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Approvals Activities Cue"; "Approvals Activities Cue")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Requests to Approve" := "DBE Requests to Approve";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + Format("Primary Key"));
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            trigger OnPreDataItem()
            begin
                CLEAR(IntGCounter);
                IntGTotalRecords := COUNT;
                DiagGWindows.OPEN(CstGPorgressText);
            end;

            trigger OnAfterGetRecord()
            begin
                "BBX Parcel 1 Size" := "DBE Parcel 1 Size";
                "BBX Parcel 1 Weight" := "DBE Parcel 1 Weight";
                "BBX Parcel 2 Size" := "DBE Parcel 2 Size";
                "BBX Parcel 2 Weight" := "DBE Parcel 2 Weight";
                "BBX Parcel 3 Size" := "DBE Parcel 3 Size";
                "BBX Parcel 3 Weight" := "DBE Parcel 3 Weight";
                "BBX Parcel 4 Size" := "DBE Parcel 4 Size";
                "BBX Parcel 4 Weight" := "DBE Parcel 4 Weight";
                "BBX Source No." := "DBE Source No.";
                "BBX Sell-to Customer No." := "DBE Sell-to Customer No.";
                "BBX Sell-to Customer Name" := "DBE Sell-to Customer Name";
                Modify;
                IF IntGTotalRecords > 0 THEN BEGIN
                    IntGCounter += 1;
                    DiagGWindows.UPDATE(1, TableCaption + ': ' + "No.");
                    DiagGWindows.UPDATE(2, ROUND(IntGCounter / IntGTotalRecords * 10000, 1));
                END;
            end;
        }
    }

    var
        IntGTotalRecords: Integer;
        IntGCounter: Integer;
        DiagGWindows: Dialog;
        CstGPorgressText: Label '#1############################\@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';

    local procedure GetLastLineNo(CodPPackingNo: Code[20]): Integer;
    var
        RecLPackingLine: Record PackingLine;
    begin
        RecLPackingLine.SetRange(PackingNo, CodPPackingNo);
        if RecLPackingLine.FindLast() then
            exit(RecLPackingLine.LineNo + 1000)
        else
            exit(10000)
    end;*/
}