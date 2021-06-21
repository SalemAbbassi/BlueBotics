codeunit 50200 "BBX Mgt"
{
    Permissions = tabledata "Sales Shipment Header" = rm,
                  tabledata "Sales Invoice Header" = rm;
    //---Table 8---
    [EventSubscriber(ObjectType::Table, Database::"Standard Text", 'OnBeforeValidateEvent', 'BBX CH PREF ORIGIN', false, false)]
    local procedure OnBeforeValidateChPrefOrigin(VAR Rec: Record "Standard Text"; VAR xRec: Record "Standard Text"; CurrFieldNo: Integer)
    var
        RecLStandardText: Record "Standard Text";
        CstLChPrefOriginUnicityError: Label 'You can not choose more than one "CH PREF ORIGIN"';
    begin
        if Rec."BBX CH PREF ORIGIN" then begin
            RecLStandardText.SetRange("BBX CH PREF ORIGIN", true);
            if not RecLStandardText.IsEmpty then
                Error(CstLChPrefOriginUnicityError);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Text", 'OnBeforeValidateEvent', 'BBX Partner cust', false, false)]
    local procedure OnBeforeValidatePartnerCust(VAR Rec: Record "Standard Text"; VAR xRec: Record "Standard Text"; CurrFieldNo: Integer)
    var
        RecLStandardText: Record "Standard Text";
        CstLDBEPartnercustUnicityError: Label 'You can not choose more than one "Partner cust"';
    begin
        if Rec."BBX Partner cust" then begin
            RecLStandardText.SetRange("BBX Partner cust", true);
            if not RecLStandardText.IsEmpty then
                Error(CstLDBEPartnercustUnicityError);
        end;
    end;

    //---Table 36---
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitFromSalesHeader', '', false, false)]
    local procedure OnAfterInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    begin
        //>>VTE-Gap01
        SalesHeader."BBX Effective date" := SourceSalesHeader."BBX Effective date";
        SalesHeader."Due Date" := SourceSalesHeader."Due Date";
        //<<VTE-Gap01
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer)
    begin
        //>>VTE-Gap04
        SalesHeader."BBX Partner" := SellToCustomer."BBX Partner";
        SalesHeader.validate("BBX Project Manager", SellToCustomer."BBXProject Manager");
        SalesHeader."Your Reference" := SalesHeader."Sell-to Contact";
        //<<VTE-Gap04
        //SaLesHeader."BBX Invoicing Contact" := SellToCustomer."BBX Invoicing Contact";
        //SalesHeader."BBX Logistics Contact" := SellToCustomer."BBX Logistics Contact";
        SalesHeader."BBX Courier Account" := SellToCustomer."BBX Courier Account";
        SalesHeader.Validate("BBX Invoicing Contact No.", SellToCustomer."BBX Invoicing Contact No.");
        SalesHeader.Validate("BBX Logistics Contact No.", SellToCustomer."BBX Logistics Contact No.");
        SalesHeader.Validate("BBX Contact Order Conf No.", SellToCustomer."BBX Contact Order Conf. No.");
        SalesHeader."BBX Transport OrganizedBy Cust." := SellToCustomer."BBX Transport OrganizedBy Cust.";
        SalesHeader."BBX Sticker Code" := SellToCustomer."BBX Sticker Code";
    end;
    //---Table 37---
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateNoSalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        CstLBlanketOrderExist: Label 'There is a blanket sales order for the customer %1 with the item %2';
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            if Rec.FctBlanketSalesOrderExist() then
                Message(StrSubstNo(CstLBlanketOrderExist, Rec."Sell-to Customer No.", Rec."No."));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateQuantitySalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        RecLVentilationLines: Record "BBX Ventilation Lines";
    begin
        if Rec.IsTemporary then
            exit;

        if not (Rec."Quantity" <> xRec.Quantity) or
            (Rec."Line No." = 0) or
            (Rec."Document Type" <> Rec."Document Type"::Order) then
            exit;

        RecLVentilationLines.SetRange("Sales Order No.", Rec."Document No.");
        RecLVentilationLines.SetRange("Sales Order Line No.", Rec."Line No.");
        RecLVentilationLines.SetRange("Item No.", Rec."No.");
        if RecLVentilationLines.FindSet() then
            repeat
                RecLVentilationLines.Validate(Amount, Rec.Amount);
                RecLVentilationLines.Modify();
            until RecLVentilationLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateUnitPriceSalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        RecLVentilationLines: Record "BBX Ventilation Lines";
    begin
        if Rec.IsTemporary then
            exit;

        if not (Rec."Unit Price" <> xRec."Unit Price") or
            (Rec."Line No." = 0) or
            (Rec."Document Type" <> Rec."Document Type"::Order) then
            exit;

        RecLVentilationLines.SetRange("Sales Order No.", Rec."Document No.");
        RecLVentilationLines.SetRange("Sales Order Line No.", Rec."Line No.");
        RecLVentilationLines.SetRange("Item No.", Rec."No.");
        if RecLVentilationLines.FindSet() then
            repeat
                RecLVentilationLines.Validate(Amount, Rec.Amount);
                RecLVentilationLines.Modify();
            until RecLVentilationLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Amount', false, false)]
    local procedure OnAfterValidateAmountSalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        RecLVentilationLines: Record "BBX Ventilation Lines";
    begin
        if Rec.IsTemporary then
            exit;

        if not (Rec."Unit Price" <> xRec."Unit Price") or
            (Rec."Line No." = 0) or
            (Rec."Document Type" <> Rec."Document Type"::Order) then
            exit;

        RecLVentilationLines.SetRange("Sales Order No.", Rec."Document No.");
        RecLVentilationLines.SetRange("Sales Order Line No.", Rec."Line No.");
        RecLVentilationLines.SetRange("Item No.", Rec."No.");
        if RecLVentilationLines.FindSet() then
            repeat
                RecLVentilationLines.Validate(Amount, Rec.Amount);
                RecLVentilationLines.Modify();
            until RecLVentilationLines.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesLine(VAR Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        RecLVentilationLines: Record "BBX Ventilation Lines";
    begin
        if not RunTrigger then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            RecLVentilationLines.SetRange("Sales Order No.", Rec."Document No.");
            RecLVentilationLines.SetRange("Sales Order Line No.", Rec."Line No.");
            RecLVentilationLines.SetRange("Item No.", Rec."No.");
            if RecLVentilationLines.FindSet() then
                RecLVentilationLines.DeleteAll();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventSalesLine(VAR Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        RecLVentilationSetup: Record "BBX Ventilation Setup";
        RecLVentilationLines: Record "BBX Ventilation Lines";
    begin
        if (not RunTrigger) or (Rec.IsTemporary) then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            RecLVentilationSetup.SetRange("Item No.", Rec."No.");
            if RecLVentilationSetup.FindSet() then
                repeat
                    RecLVentilationLines.InsertFromSalesLines(Rec, RecLVentilationSetup."Ventilation %");
                until RecLVentilationSetup.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer)
    begin
        SalesLine.Validate("BBX Task Type", Item."BBX Task Type");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignResourceValues', '', false, false)]
    local procedure OnAfterAssignResourceValuesSalesLine(var SalesLine: Record "Sales Line"; Resource: Record Resource)
    begin
        SalesLine.Validate("BBX Task Type", Resource."BBX Task type");
    end;
    //---Table 38---
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" In [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::"Blanket Order"] then begin
            PurchaseHeader."Your Reference" := Vendor.Contact;
            PurchaseHeader."Vendor Order No." := PurchaseHeader."Quote No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Posting Date', false, false)]
    local procedure OnBeforeValidatePostingDatePurchaseHeader(VAR Rec: Record "Purchase Header"; VAR xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."BBX xDocument Date" := Rec."Document Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidatePostingDatePurchaseHeader(VAR Rec: Record "Purchase Header"; VAR xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."Document Date" := Rec."BBX xDocument Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Document Date', false, false)]
    local procedure OnBeforeValidateDocumentDatePurchaseHeader(VAR Rec: Record "Purchase Header"; VAR xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."BBX xPosting Date" := Rec."Posting Date"
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Document Date', false, false)]
    local procedure OnAfterValidateDocumentDatePurchaseHeader(VAR Rec: Record "Purchase Header"; VAR xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."Posting Date" := Rec."BBX xPosting Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    begin
        PurchHeader."Document Date" := 0D;
    end;

    //---Table 60---
    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeSendCustomerRecords', '', false, false)]
    local procedure OnBeforeSendCustomerRecords(ReportUsage: Integer; RecordVariant: Variant; DocName: Text[150]; CustomerNo: Code[20]; DocumentNo: Code[20]; CustomerFieldNo: Integer; DocumentFieldNo: Integer; var Handled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        RecRefSource: RecordRef;
        RecRefToSend: RecordRef;
        ProfileSelectionMethod: Option ConfirmDefault,ConfirmPerEach,UseDefault;
        SingleCustomerSelected: Boolean;
        ShowDialog: Boolean;
        CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
        RecRef: RecordRef;
        RecId: RecordId;
    begin
        RecRef.GetTable(RecordVariant);
        RecId := RecRef.RecordId;
        if RecId.TableNo = 112 then begin

            SingleCustomerSelected := CduLBlueBoticsFctMgt.IsSingleRecordSelected(RecordVariant, CustomerNo, CustomerFieldNo);

            if not CduLBlueBoticsFctMgt.CheckShowProfileSelectionMethodDialog(SingleCustomerSelected, ProfileSelectionMethod, CustomerNo, true) then
                exit;

            if SingleCustomerSelected or (ProfileSelectionMethod = ProfileSelectionMethod::ConfirmDefault) then begin
                if DocumentSendingProfile.LookupProfile(CustomerNo, true, true) then
                    DocumentSendingProfile.Send(ReportUsage, RecordVariant, DocumentNo, CustomerNo, DocName, CustomerFieldNo, DocumentFieldNo);
            end else begin
                ShowDialog := ProfileSelectionMethod = ProfileSelectionMethod::ConfirmPerEach;
                RecRefSource.GetTable(RecordVariant);
                if RecRefSource.FindSet then
                    repeat
                        RecRefToSend := RecRefSource.Duplicate;
                        RecRefToSend.SetRecFilter;
                        CustomerNo := RecRefToSend.Field(CustomerFieldNo).Value;
                        DocumentNo := RecRefToSend.Field(DocumentFieldNo).Value;
                        if DocumentSendingProfile.LookupProfile(CustomerNo, true, ShowDialog) then
                            DocumentSendingProfile.Send(ReportUsage, RecRefToSend, DocumentNo, CustomerNo, DocName, CustomerFieldNo, DocumentFieldNo);
                    until RecRefSource.Next = 0;
            end;
            if DocumentSendingProfile."E-Mail" <> DocumentSendingProfile."E-Mail"::No then
                if RecLSalesInvoiceHeader.Get(DocumentNo) then begin
                    RecLSalesInvoiceHeader.BBXSentByMail := true;
                    RecLSalesInvoiceHeader.Modify();
                end;
            Handled := true;
        end;
    end;

    //---Table 83---
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    begin
        //>>VTE-Gap01
        ItemJnlLine."BBX Effective date" := SalesHeader."BBX Effective date";
        ItemJnlLine."BBX Due Date" := SalesHeader."Due Date";
        //<<VTE-Gap01
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyFromProdOrderLine', '', false, false)]
    local procedure OnAfterCopyFromProdOrderLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderLine: Record "Prod. Order Line")
    begin
        //>>PRO-GC22
        ItemJournalLine."BBX BootFile" := ProdOrderLine."BBX BootFile";
        //<<PRO-GC22
    end;

    //---Table 91---
    [EventSubscriber(ObjectType::Table, Database::"User Setup", 'OnBeforeValidateEvent', 'BBX Signatory PROFORMA', false, false)]
    local procedure OnBeforeValidateDBESignatoryPROFORMA(VAR Rec: Record "User Setup"; VAR xRec: Record "User Setup"; CurrFieldNo: Integer)
    var
        RecLUserSetup: Record "User Setup";
        CstLSignatoryUnicityError: Label 'There must be one user checked for PROFORMA signatures';
    begin
        if Rec."BBX Signatory PROFORMA" then begin
            RecLUserSetup.SetRange("BBX Signatory PROFORMA", true);
            if not RecLUserSetup.IsEmpty then
                Error(CstLSignatoryUnicityError);
        end;
    end;
    //---Table 1003---
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItemJobPlanningLine(var JobPlanningLine: Record "Job Planning Line"; Job: Record Job; Item: Record Item)
    begin
        JobPlanningLine.Validate("BBX Task Type", Item."BBX Task Type");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEventJobPlanningLine(VAR Rec: Record "Job Planning Line"; VAR xRec: Record "Job Planning Line"; CurrFieldNo: Integer)
    var
        RecLResource: Record Resource;
    begin
        if Rec.Type <> Rec.Type::Resource then
            exit;
        if (Rec."No." <> '') OR (Rec."No." <> xRec."No.") then begin
            if RecLResource.Get(Rec."No.") then
                Rec.Validate("BBX Task Type", RecLResource."BBX Task type");
        end;
    end;
    //---Table 1173---
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        case RecRef.Number of
            DATABASE::"Sales Shipment Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"Purchase Header Archive", DATABASE::"Sales Header Archive":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    FieldRef := RecRef.Field(5047);
                    LineNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            DATABASE::"Transfer Shipment Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;
    //---Record 60---
    /*[EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnAfterSendVendor', '', false, false)]
    local procedure OnAfterSendVendor(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; ToVendor: Code[20]; DocName: Text[150]; VendorNoFieldNo: Integer; DocumentNoFieldNo: Integer)
    var
        RecRef: RecordRef;
        RecLPurchaseHeader: Record "Purchase Header";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        DocumentNo: Code[20];
    begin
        RecRef.GetTable(RecordVariant);
        if RecRef.FindSet then begin
            DocType := RecRef.Field(1).Value;
            DocumentNo := RecRef.Field(3).Value;
            if DocType = DocType::Order then
                if RecLPurchaseHeader.GET(DocType::Order, DocNo) then begin
                    RecLPurchaseHeader.DBESentByMail := true;
                    RecLPurchaseHeader.Modify();
                end;
        end;

    end;*/

    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeSendVendorRecords', '', false, false)]
    local procedure OnBeforeSendVendorRecords(ReportUsage: Integer; RecordVariant: Variant; DocName: Text[150]; VendorNo: Code[20]; DocumentNo: Code[20]; VendorFieldNo: Integer; DocumentFieldNo: Integer; var Handled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        RecRef: RecordRef;
        RecRef2: RecordRef;
        ProfileSelectionMethod: Option ConfirmDefault,ConfirmPerEach,UseDefault;
        SingleVendorSelected: Boolean;
        ShowDialog: Boolean;
        CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
        RecLPurchaseHeader: Record "Purchase Header";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
    begin
        RecRef.GetTable(RecordVariant);
        if RecRef.FindSet then begin
            DocType := RecRef.Field(1).Value;
            DocumentNo := RecRef.Field(3).Value;
        end;
        if DocType = DocType::Order then begin

            SingleVendorSelected := CduLBlueBoticsFctMgt.IsSingleRecordSelected(RecordVariant, VendorNo, VendorFieldNo);

            if not SingleVendorSelected then
                if not DocumentSendingProfile.ProfileSelectionMethodDialog(ProfileSelectionMethod, false) then
                    exit;

            if SingleVendorSelected or (ProfileSelectionMethod = ProfileSelectionMethod::ConfirmDefault) then begin
                if DocumentSendingProfile.LookUpProfileVendor(VendorNo, true, true) then
                    DocumentSendingProfile.SendVendor(ReportUsage, RecordVariant, DocumentNo, VendorNo, DocName, VendorFieldNo, DocumentFieldNo);
            end else begin
                ShowDialog := ProfileSelectionMethod = ProfileSelectionMethod::ConfirmPerEach;
                RecRef.GetTable(RecordVariant);
                if RecRef.FindSet then
                    repeat
                        RecRef2 := RecRef.Duplicate;
                        RecRef2.SetRecFilter;
                        VendorNo := RecRef2.Field(VendorFieldNo).Value;
                        DocumentNo := RecRef2.Field(DocumentFieldNo).Value;
                        if DocumentSendingProfile.LookUpProfileVendor(VendorNo, true, ShowDialog) then
                            DocumentSendingProfile.SendVendor(ReportUsage, RecRef2, DocumentNo, VendorNo, DocName, VendorFieldNo, DocumentFieldNo);
                    until RecRef.Next = 0;
            end;
            if DocumentSendingProfile."E-Mail" <> DocumentSendingProfile."E-Mail"::No then
                if RecLPurchaseHeader.Get(RecLPurchaseHeader."Document Type"::Order, DocumentNo) then begin
                    RecLPurchaseHeader.BBXSentByMail := true;
                    RecLPurchaseHeader.Modify();
                end;
            Handled := true;
        end;
    end;
    //---Codeunit 80---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    begin
        if SalesHeader.Ship then
            If SalesHeader."Posting Date" = 0D then
                SalesHeader."Posting Date" := WorkDate();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptHeaderInsert', '', false, false)]
    local procedure OnAfterSalesShptHeaderInsert(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; var TempWhseShptHeader: Record "Warehouse Shipment Header"; WhseReceive: Boolean; WhseShip: Boolean)
    var
        RecLWhseShptHeader: Record "Warehouse Shipment Header";
        RecLCustomer: Record Customer;
    begin
        if WhseShip then begin
            RecLWhseShptHeader.Get(TempWhseShptHeader."No.");
            SalesShipmentHeader.Validate("BBX Parcel 1 Size", RecLWhseShptHeader."BBX Parcel 1 Size");
            SalesShipmentHeader.Validate("BBX Parcel 1 Weight", RecLWhseShptHeader."BBX Parcel 1 Weight");
            SalesShipmentHeader.Validate("BBX Parcel 2 Size", RecLWhseShptHeader."BBX Parcel 2 Size");
            SalesShipmentHeader.Validate("BBX Parcel 2 Weight", RecLWhseShptHeader."BBX Parcel 2 Weight");
            SalesShipmentHeader.Validate("BBX Parcel 3 Size", RecLWhseShptHeader."BBX Parcel 3 Size");
            SalesShipmentHeader.Validate("BBX Parcel 3 Weight", RecLWhseShptHeader."BBX Parcel 3 Weight");
            SalesShipmentHeader.Validate("BBX Parcel 4 Size", RecLWhseShptHeader."BBX Parcel 4 Size");
            SalesShipmentHeader.Validate("BBX Parcel 4 Weight", RecLWhseShptHeader."BBX Parcel 4 Weight");

            RecLCustomer.Get(SalesHeader."Sell-to Customer No.");
            If RecLCustomer."BBX EUR.1 Enum" = RecLCustomer."BBX EUR.1 Enum"::" " then
                SalesShipmentHeader."BBX EUR1 Enum" := SalesShipmentHeader."BBX EUR1 Enum"::" "
            else
                If RecLCustomer."BBX EUR.1 Enum" = RecLCustomer."BBX EUR.1 Enum"::NO then
                    SalesShipmentHeader."BBX EUR1 Enum" := SalesShipmentHeader."BBX EUR1 Enum"::"N/A"
                else
                    If RecLCustomer."BBX EUR.1 Enum" = RecLCustomer."BBX EUR.1 Enum"::YES then
                        SalesShipmentHeader."BBX EUR1 Enum" := SalesShipmentHeader."BBX EUR1 Enum"::"To be Printed";
            SalesShipmentHeader.Validate("BBX Notification Sent", false);
            SalesShipmentHeader.Modify(false);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    begin
        SalesInvHeader.Validate("BBX Notification Sent", false);
        SalesInvHeader.Modify(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostInvoicePostBuffer', '', false, false)]
    local procedure OnBeforePostInvoicePostBuffer(SalesHeader: Record "Sales Header"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line")
    var
        CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
    begin
        // if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
        //     exit;
        // if CduLBlueBoticsFctMgt.CheckVentilationLineOnSalesOrder(SalesHeader."No.") then
        //     CduLBlueBoticsFctMgt.FctOnBeforePostInvoicePostBufferFctOnBeforePostInvoicePostBuffer(SalesHeader, TempInvoicePostBuffer, TotalSalesLine, TotalSalesLineLCY);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesLines', '', false, false)]
    local procedure OnBeforePostSalesLines(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var TempVATAmountLine: Record "VAT Amount Line" temporary)
    var
        CudLBBXFctMgt: Codeunit "BBX Function Mgt";
        RecLItem: Record Item;
        TmpLSalesLine: Record "Sales Line" temporary;
    begin
        /*if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        repeat
            if TempSalesLineGlobal.Type = TempSalesLineGlobal.Type::Item then begin
                if RecLItem.Get(TempSalesLineGlobal."No.") then
                    if RecLItem.Type <> RecLItem.Type::Inventory then begin
                        if RecLItem."BBX Automatic Delivery" then
                            CudLBBXFctMgt.CreatSalesLine(TmpLSalesLine, TempSalesLineGlobal);
                    end else
                        CudLBBXFctMgt.CreatSalesLine(TmpLSalesLine, TempSalesLineGlobal);
            end else
                CudLBBXFctMgt.CreatSalesLine(TmpLSalesLine, TempSalesLineGlobal);
        until TempSalesLineGlobal.Next() = 0;
        TempSalesLineGlobal.DeleteAll();
        repeat
            TempSalesLineGlobal.Init();
            TempSalesLineGlobal := TmpLSalesLine;
            TempSalesLineGlobal.Insert(false);
        until TmpLSalesLine.Next() = 0;
        TmpLSalesLine.DeleteAll();*/
    end;

    //---Codeunit 81---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var
        CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
    begin
        IsHandled := true;

        if not HideDialog then
            if not CduLBlueBoticsFctMgt.FctConfirmPost(SalesHeader, DefaultOption) then
                exit;

        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);

        //If (DefaultOption = 1) AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
        If SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            SalesHeader."Posting Date" := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        CstLVerifyInsurance: Label 'Is shipment value covered by insurance value?';
    begin
        //>>VTE-Gap08
        If SalesHeader.Ship = true then begin
            If NOT Confirm(CstLVerifyInsurance) then
                exit;
        end;
        //<<VTE-Gap08
    end;

    //---Codeunit 87---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        //>>VTE-Gap01
        SalesOrderHeader."BBX Effective date" := BlanketOrderSalesHeader."BBX Effective date";
        SalesOrderHeader."Due Date" := BlanketOrderSalesHeader."Due Date";
        //<<VTE-Gap01
        SalesOrderHeader."BBX Project Manager" := BlanketOrderSalesHeader."BBX Project Manager";
    end;

    //---Codeunit 91---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPostViaJobQueue: Codeunit "Purchase Post via Job Queue";
    begin
        IsHandled := true;

        if not HideDialog then
            if not CduLBlueBoticsFctMgt.FctConfirmPostPurch(PurchaseHeader, DefaultOption) then
                exit;

        PurchSetup.Get();
        if PurchSetup."Post with Job Queue" then
            PurchPostViaJobQueue.EnqueuePurchDoc(PurchaseHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Purch.-Post", PurchaseHeader);

    end;

    //---Codeunit 96---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderHeader', '', false, false)]
    local procedure OnBeforeInsertPurchOrderHeader(var PurchOrderHeader: Record "Purchase Header"; PurchQuoteHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."BBX Quotation Date" := PurchQuoteHeader."Order Date";
        PurchOrderHeader."Vendor Order No." := PurchOrderHeader."Quote No.";
    end;

    //---Codeunit 391---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", 'OnBeforeSalesShptHeaderModify', '', false, false)]
    local procedure OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."BBX Parcel 1 Size" := FromSalesShptHeader."BBX Parcel 1 Size";
        SalesShptHeader."BBX Parcel 2 Size" := FromSalesShptHeader."BBX Parcel 2 Size";
        SalesShptHeader."BBX Parcel 3 Size" := FromSalesShptHeader."BBX Parcel 3 Size";
        SalesShptHeader."BBX Parcel 4 Size" := FromSalesShptHeader."BBX Parcel 4 Size";
        SalesShptHeader."BBX Parcel 1 Weight" := FromSalesShptHeader."BBX Parcel 1 Weight";
        SalesShptHeader."BBX Parcel 2 Weight" := FromSalesShptHeader."BBX Parcel 2 Weight";
        SalesShptHeader."BBX Parcel 3 Weight" := FromSalesShptHeader."BBX Parcel 3 Weight";
        SalesShptHeader."BBX Parcel 4 Weight" := FromSalesShptHeader."BBX Parcel 4 Weight";
    end;

    //---Codeunit 229---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintSalesOrder', '', false, false)]
    local procedure OnBeforePrintSalesOrder(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    begin
        if ReportUsage = 1 then begin
            SalesHeader.TestField(Status, SalesHeader.Status::Released);
        end;
    end;

    //---Codeunit 442---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsertExt(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesInvHeader."Order No." := SalesHeader."No.";
        SalesInvHeader."Quote No." := SalesHeader."Quote No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsertExt(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean)
    var
        LblDescriptionText: Label 'Prepayment based on quote n° %1 and order n° %2';
    begin
        SalesInvLine.Validate(Description, StrSubstNo(LblDescriptionText, SalesInvHeader."Order No.", SalesInvHeader."Quote No."));
    end;

    //---Codeunit 1535---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', false, false)]
    local procedure OnAfterCheckSalesApprovalPossible(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.TestField("Sell-to Contact");
        SalesHeader.TestField("Your Reference");
        SalesHeader.TestField("Assigned User ID");
        SalesHeader.TestField("Promised Delivery Date");
        SalesHeader.TestField("Payment Terms Code");
        SalesHeader.TestField("Shipment Method Code", 'EXW');
        SalesHeader.TestField("Quote No.");
    end;
    //---Codeunit 5063---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStorePurchDocument', '', false, false)]
    local procedure OnAfterStorePurchDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive")
    var
        RecLDocumentAttachment: Record "Document Attachment";
        RecLNewDocAttachment: Record "Document Attachment";
    begin
        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::"Blanket Order", PurchaseHeader."Document Type"::Order]) then
            exit;
        RecLDocumentAttachment.SetRange("Table ID", 38);
        RecLDocumentAttachment.SetRange("No.", PurchaseHeader."No.");
        RecLDocumentAttachment.SetRange("Document Type", PurchaseHeader."Document Type");
        if RecLDocumentAttachment.FindSet() then
            repeat
                RecLNewDocAttachment.Init();
                RecLNewDocAttachment := RecLDocumentAttachment;
                RecLNewDocAttachment."Table ID" := 5109;
                RecLNewDocAttachment."Line No." := PurchaseHeaderArchive."Version No.";
                RecLNewDocAttachment.Insert();
            until RecLDocumentAttachment.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]
    local procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    var
        RecLDocumentAttachment: Record "Document Attachment";
        RecLNewDocAttachment: Record "Document Attachment";
    begin
        if not (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
            exit;
        RecLDocumentAttachment.SetRange("Table ID", 36);
        RecLDocumentAttachment.SetRange("No.", SalesHeader."No.");
        RecLDocumentAttachment.SetRange("Document Type", SalesHeader."Document Type");
        if RecLDocumentAttachment.FindSet() then
            repeat
                RecLNewDocAttachment.Init();
                RecLNewDocAttachment := RecLDocumentAttachment;
                RecLNewDocAttachment."Table ID" := 5107;
                RecLNewDocAttachment."Line No." := SalesHeaderArchive."Version No.";
                RecLNewDocAttachment.Insert();
            until RecLDocumentAttachment.Next() = 0;
    end;
    //---Codeunit 5407---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnBeforeChangeStatusOnProdOrder', '', false, false)]
    local procedure OnBeforeChangeStatusOnProdOrder(var ProductionOrder: Record "Production Order"; NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished)
    var
        CstLErrorMsg: Label 'The BootFile is mandatory';
        CstLCustomerIDErrorMsg: Label 'The Customer ID must not be empty';
        RecLSalesHeader: Record "Sales Header";
    begin
        //>>PRO-GC22
        If ProductionOrder.Status = ProductionOrder.Status::"Firm Planned" then
            IF NewStatus = NewStatus::Released then begin
                IF ProductionOrder."BBX BootFile" = '' then
                    Error(CstLErrorMsg);
                IF ProductionOrder."BBX Customer ID" = '' then
                    ERROR(CstLCustomerIDErrorMsg);
            end;
        //<<PRO-GC22
        if NewStatus = NewStatus::Released then begin
            if ProductionOrder."BBX Sales Order No." <> '' then begin
                RecLSalesHeader.Get(RecLSalesHeader."Document Type"::Order, ProductionOrder."BBX Sales Order No.");
                RecLSalesHeader.TestField(Status, RecLSalesHeader.Status::Released);
            end;
        end;
    end;
    //---Codeunit 5704---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    begin
        TransShptHeader."BBX Package Tracking No." := TransHeader."BBX Package Tracking No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', false, false)]
    local procedure OnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    begin
        TransShptLine."BBX Value" := TransLine."BBX Value";
        TransShptLine."BBX Currency Code" := TransLine."BBX Currency Code";
    end;

    //---Codeunit 5705---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransRcptHeaderInsert', '', false, false)]
    local procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."BBX Validated" := TransferHeader."BBX Validated";
        TransferReceiptHeader."BBX Validated By" := TransferHeader."BBX Validated By";
        TransferReceiptHeader."BBX Sales Order No." := TransferHeader."BBX Sales Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    begin
        TransRcptLine."BBX Currency Code" := TransLine."BBX Currency Code";
        TransRcptLine."BBX Value" := TransLine."BBX Value";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterTransRcptLineModify', '', false, false)]
    local procedure OnAfterTransRcptLineModify(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line"; CommitIsSuppressed: Boolean)
    begin
        TransferReceiptLine."BBX Sales Line No." := TransferLine."BBX Sales Line No.";
        TransferReceiptLine.Modify;
    end;
    //---Codeuint 5763---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforePostedWhseShptHeaderInsert', '', false, false)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader.Validate("BBX Parcel 1 Size", WarehouseShipmentHeader."BBX Parcel 1 Size");
        PostedWhseShipmentHeader.Validate("BBX Parcel 1 Weight", WarehouseShipmentHeader."BBX Parcel 1 Weight");
        PostedWhseShipmentHeader.Validate("BBX Parcel 2 Size", WarehouseShipmentHeader."BBX Parcel 2 Size");
        PostedWhseShipmentHeader.Validate("BBX Parcel 2 Weight", WarehouseShipmentHeader."BBX Parcel 2 Weight");
        PostedWhseShipmentHeader.Validate("BBX Parcel 3 Size", WarehouseShipmentHeader."BBX Parcel 3 Size");
        PostedWhseShipmentHeader.Validate("BBX Parcel 3 Weight", WarehouseShipmentHeader."BBX Parcel 3 Weight");
        PostedWhseShipmentHeader.Validate("BBX Parcel 4 Size", WarehouseShipmentHeader."BBX Parcel 4 Size");
        PostedWhseShipmentHeader.Validate("BBX Parcel 4 Weight", WarehouseShipmentHeader."BBX Parcel 4 Weight");
        PostedWhseShipmentHeader.Validate("BBX Project Manager", WarehouseShipmentHeader."BBX Project Manager");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnAfterPostWhseShipment', '', false, false)]
    local procedure OnAfterPostWhseShipment(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        RecLSalesHeader: Record "Sales Header";
    begin
        RecLSalesHeader.SetRange("No.", WarehouseShipmentHeader."BBX Source No.");
        if RecLSalesHeader.FindFirst() then begin
            if RecLSalesHeader."Document Type" <> RecLSalesHeader."Document Type"::Order then
                exit;
            RecLSalesHeader.Ship := true;
            Codeunit.Run(Codeunit::"Sales-Post", RecLSalesHeader);
        end;
    end;

    //---Codeunit 5764---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment (Yes/No)", 'OnBeforeConfirmWhseShipmentPost', '', false, false)]
    local procedure OnBeforeConfirmWhseShipmentPost(var WhseShptLine: Record "Warehouse Shipment Line"; var HideDialog: Boolean; var Invoice: Boolean; var IsPosted: Boolean)
    var
        CduLWhsePostShipment: Codeunit "Whse.-Post Shipment";
        IntLSelection: Integer;
        LblLShipInvoiceQst: Label '&Ship';
        CstLVerifyInsurance: Label 'Is shipment value covered by insurance value?';
    begin
        with WhseShptLine do begin
            if Find then
                if not HideDialog then begin
                    IntLSelection := StrMenu(LblLShipInvoiceQst, 1);
                    if IntLSelection = 0 then begin
                        IsPosted := true;
                        exit;
                    end;
                    Invoice := (IntLSelection = 2);
                end;

            If NOT Confirm(CstLVerifyInsurance) then begin
                IsPosted := true;
                exit;
            end;

            CduLWhsePostShipment.SetPostingSettings(Invoice);
            CduLWhsePostShipment.SetPrint(false);
            CduLWhsePostShipment.Run(WhseShptLine);
            CduLWhsePostShipment.GetResultMessage;
            Clear(CduLWhsePostShipment);
        end;
        IsPosted := true;
    end;

    //---Codeunit 5765---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment + Print", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var WhseShptLine: Record "Warehouse Shipment Line"; var HideDialog: Boolean; var Invoice: Boolean; var IsPosted: Boolean; var Selection: Integer)
    var
        CudLWhsePostShipment: Codeunit "Whse.-Post Shipment";
        ShipInvoiceQst: Label '&Ship';
        CstLVerifyInsurance: Label 'Is shipment value covered by insurance value?';
    begin
        with WhseShptLine do begin
            if Find then
                if not HideDialog then begin
                    Selection := StrMenu(ShipInvoiceQst, 1);
                    if Selection = 0 then begin
                        IsPosted := true;
                        exit;
                    end;
                    Invoice := (Selection = 2);
                end;
            If NOT Confirm(CstLVerifyInsurance) then begin
                IsPosted := true;
                exit;
            end;

            CudLWhsePostShipment.SetPostingSettings(Invoice);
            CudLWhsePostShipment.SetPrint(true);
            CudLWhsePostShipment.Run(WhseShptLine);
            CudLWhsePostShipment.GetResultMessage;
            Clear(CudLWhsePostShipment);
        end;
        IsPosted := true;
    end;

    //---Codeunit 5920---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShptOnAfterAddServItemComponents', '', false, false)]
    local procedure OnCreateServItemOnSalesLineShptOnAfterAddServItemComponents(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesShipmentLine: Record "Sales Shipment Line"; var ServiceItem: Record "Service Item"; var TempServiceItem: Record "Service Item" temporary; var TempServiceItemComp: Record "Service Item Component" temporary)
    var
        CduLBBXFunctionMgt: Codeunit "BBX Function Mgt";
    begin
        CduLBBXFunctionMgt.FctCreateServItemOnSalesLineShpt(SalesHeader, SalesLine, SalesShipmentLine);
    end;

    //---Codeuint 50010---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DBE Times Calculation", 'OnAutomaticCreateJob', '', false, false)]
    local procedure OnAutomaticCreateJob(var salesheader: record "Sales Header"; var job: record Job)
    begin
        job.Validate("Project Manager", salesheader."BBX Project Manager");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DBE Times Calculation", 'OnCreateJobTaskWithSalesLine', '', false, false)]
    local procedure OnCreateJobTaskWithSalesLine(var salesline: record "Sales Line"; var jobTask: record "Job Task")
    var
        RecLPlanIt: record "DBE Plan It Setup";
    begin
        RecLPlanIt.Get();
        if (JobTask."Job Task Type" = jobTask."Job Task Type"::Posting) AND
            (jobTask."Job Task No." = RecLPlanIt."DBE Define Presales Job Task")
        then begin
            jobTask.Validate("BBX Task Type", salesline."BBX Task Type");
            jobTask.Validate(Description, RecLPlanIt."DBE Define Presales Job Task");
        end;
    end;
    //---Codeunit 50014---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DBE Job Create-Invoice", 'OnBeforeModifySalesHeader', '', false, false)]
    local procedure OnBeforeModifySalesHeader(VAR SalesHeader: Record "Sales Header"; Job: Record Job)
    var
        RecLSalesHeader: Record "Sales Header";
        RecLJobPlanningLine: Record "Job Planning Line";
    begin
        RecLJobPlanningLine.SetRange("Job No.", Job."No.");
        if not RecLJobPlanningLine.FindFirst() then
            exit;

        if RecLSalesHeader.Get(RecLSalesHeader."Document Type"::Order, RecLJobPlanningLine."Document No.") then
            SalesHeader."External Document No." := RecLSalesHeader."External Document No.";
        RecLSalesHeader."Posting Date" := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DBE Job Create-Invoice", 'OnAfterGetCreateSalesHeader', '', false, false)]
    local procedure OnAfterGetCreateSalesHeader(VAR SalesHeader: Record "Sales Header"; Job: Record Job)
    begin
        SalesHeader."Posting Date" := 0D;
    end;

    //---codeunit 99000787---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order Lines", 'OnBeforeProdOrderLineInsert', '', false, false)]
    local procedure OnBeforeProdOrderLineInsert(var ProdOrderLine: Record "Prod. Order Line"; var ProductionOrder: Record "Production Order"; SalesLineIsSet: Boolean; var SalesLine: Record "Sales Line")
    begin
        //>>PRO-GC22
        ProdOrderLine.Validate("BBX BootFile", ProductionOrder."BBX BootFile");
        ProdOrderLine.Validate("BBX Customer ID", ProductionOrder."BBX Customer ID");
        //<<PRO-GC22
    end;

    //---Codeunit 99000792---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnAfterCreateProdOrderFromSalesLine', '', false, false)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    var
        RecLCustomer: Record Customer;
        RecLSalesHeader: Record "Sales Header";
    begin
        //>>PRO-GC22
        IF RecLCustomer.GET(SalesLine."Sell-to Customer No.") THEN
            ProdOrder.Validate("BBX Customer ID", RecLCustomer."BBX Customer ID");
        //<<PRO-GC22
        ProdOrder."BBX Sales Order No." := SalesLine."Document No.";
        ProdOrder.Validate("BBX Customer No.", SalesLine."Sell-to Customer No.");
        if RecLSalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            ProdOrder.Validate("BBX Sticker Code", RecLSalesHeader."BBX Sticker Code");
    end;

    //---Page 1173---
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        //>>VTE-Gap05
        case RecRef.Number of
            DATABASE::"Sales Shipment Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Purchase Header Archive", Database::"Sales Header Archive":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    FieldRef := RecRef.Field(5047);
                    LineNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Line No.", LineNo);
                end;
            DATABASE::"Transfer Shipment Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
        //<<VTE-Gap05

    end;
    //---Page 1174---
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
        RecLPurchaseHeaderArchive: Record "Purchase Header Archive";
        RecLSalesHeaderArchive: Record "Sales Header Archive";
        RecLTransferShipmentHeader: Record "Transfer Shipment Header";
    begin
        If DocumentAttachment."Table ID" = Database::"Sales Shipment Header" then begin
            RecRef.Open(DATABASE::"Sales Shipment Header");
            if RecLSalesShipmentHeader.Get(DocumentAttachment."No.") then
                RecRef.GetTable(RecLSalesShipmentHeader);
        end;

        If DocumentAttachment."Table ID" = Database::"Purchase Header Archive" then begin
            RecRef.Open(DATABASE::"Purchase Header Archive");
            RecLPurchaseHeaderArchive.SetRange("Document Type", RecLPurchaseHeaderArchive."Document Type"::Order, RecLPurchaseHeaderArchive."Document Type"::"Blanket Order");
            RecLPurchaseHeaderArchive.SetRange("No.", DocumentAttachment."No.");
            RecLPurchaseHeaderArchive.SetRange("Version No.", DocumentAttachment."Line No.");
            if RecLPurchaseHeaderArchive.FindFirst() then
                RecRef.GetTable(RecLPurchaseHeaderArchive);
        end;
        if DocumentAttachment."Table ID" = Database::"Sales Header Archive" then begin
            RecRef.Open(DATABASE::"Sales Header Archive");
            RecLSalesHeaderArchive.SetRange("Document Type", RecLSalesHeaderArchive."Document Type"::Order);
            RecLSalesHeaderArchive.SetRange("No.", DocumentAttachment."No.");
            RecLSalesHeaderArchive.SetRange("Version No.", DocumentAttachment."Line No.");
            if RecLSalesHeaderArchive.FindFirst() then
                RecRef.GetTable(RecLSalesHeaderArchive);
        end;
        If DocumentAttachment."Table ID" = Database::"Transfer Shipment Header" then begin
            RecRef.Open(DATABASE::"Transfer Shipment Header");
            if RecLTransferShipmentHeader.Get(DocumentAttachment."No.") then
                RecRef.GetTable(RecLTransferShipmentHeader);
        end;
    end;

    //---Table 1301---
    [EventSubscriber(ObjectType::table, Database::"Item Template", 'OnBeforeInitItemNo', '', false, false)]
    local procedure ItemTemplate_OnBeforeInitItemNo(var Item: Record Item; ConfigTemplateHeader: Record "Config. Template Header"; var IsHandled: Boolean)
    var
        ReclInvtSetup: Record "Inventory Setup";
        ReclConfigTemplateLine: Record "Config. Template Line";
        CdulNoSeriesMgt: Codeunit NoSeriesManagement;
        TxtL0001: label 'Item category code must have a value on Template %1';
    begin

        if ConfigTemplateHeader."Instance No. Series" <> '' then
            cduLNoSeriesMgt.InitSeries(ConfigTemplateHeader."Instance No. Series", '', 0D, Item."No.", Item."No. Series")
        else begin
            ReclInvtSetup.get;
            RecLInvtSetup.TestField("Item Nos.");
            CduLNoSeriesMgt.InitSeries(RecLInvtSetup."Item Nos.", '', 0D, Item."No.", Item."No. Series");
        end;
        ReclConfigTemplateLine.SetRange("Data Template Code", ConfigTemplateHeader.Code);
        ReclConfigTemplateLine.setrange("Field ID", 5702);
        IF ReclConfigTemplateLine.FindSet() THEN Begin
            IF ReclConfigTemplateLine."Default Value" = '' then
                ERROR(STRSUBSTNO(TxtL0001, ConfigTemplateHeader.code));
            Item."No." += '-' + ReclConfigTemplateLine."Default Value";

        end ELSE
            IsHandled := true;
    end;

    //--- Page 1350 ---
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure OnAfterRecordChanged(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean)
    begin
        if (SalesShipmentHeader."BBX Parcel 1 Size" <> xSalesShipmentHeader."BBX Parcel 1 Size") or
        (SalesShipmentHeader."BBX Parcel 2 Size" <> xSalesShipmentHeader."BBX Parcel 2 Size") or
        (SalesShipmentHeader."BBX Parcel 3 Size" <> xSalesShipmentHeader."BBX Parcel 3 Size") or
        (SalesShipmentHeader."BBX Parcel 4 Size" <> xSalesShipmentHeader."BBX Parcel 4 Size") or
        (SalesShipmentHeader."BBX Parcel 1 Weight" <> xSalesShipmentHeader."BBX Parcel 1 Weight") or
        (SalesShipmentHeader."BBX Parcel 2 Weight" <> xSalesShipmentHeader."BBX Parcel 2 Weight") or
        (SalesShipmentHeader."BBX Parcel 3 Weight" <> xSalesShipmentHeader."BBX Parcel 3 Weight") or
        (SalesShipmentHeader."BBX Parcel 4 Weight" <> xSalesShipmentHeader."BBX Parcel 4 Weight") then
            IsChanged := true;
    end;

    //--- Page 99000883 ---
    [EventSubscriber(ObjectType::Page, page::"Sales Order Planning", 'OnAfterCreateProdOrder', '', true, false)]
    local procedure OnAfterCreateProdOrderExt(var SalesPlanningLine: Record "Sales Planning Line")
    var
        recReserveEntry: Record "Reservation Entry";
        recReserveEntry2: Record "Reservation Entry";
        recPlanProdOrder: record "Production Order";
        repReplanProdOrder: report "Replan Production Order";
    begin
        ///if Confirm('A') then;
        recReserveEntry.SetFilter("Source Type", '%1', Database::"Sales Line");
        recReserveEntry.SetFilter("Source Subtype", '%1', 1);
        recReserveEntry.SetFilter("Source ID", '%1', SalesPlanningLine."Sales Order No.");
        recReserveEntry.SetFilter("Source Ref. No.", '%1', SalesPlanningLine."Sales Order Line No.");
        if recReserveEntry.FindFirst() then begin
            //if Confirm('B') then;
            recReserveEntry2.SetFilter("Entry No.", '%1', recReserveEntry."Entry No.");
            recReserveEntry2.SetFilter("Source Type", '%1', Database::"Prod. Order Line");
            recReserveEntry2.SetFilter("Source Subtype", '%1', 2);
            if recReserveEntry2.FindFirst() then begin
                //if Confirm('C') then;
                repReplanProdOrder.UseRequestPage(false);
                repReplanProdOrder.InitializeRequest(1, 2);//1 for Backward, 2 for All Levels
                recPlanProdOrder.SetFilter(Status, '%1', recReserveEntry2."Source Subtype");
                recPlanProdOrder.SetFilter("No.", '%1', recReserveEntry2."Source ID");
                //if Confirm((recPlanProdOrder.GetFilters)) then;

                recPlanProdOrder.FindFirst();
                repReplanProdOrder.SetTableView(recPlanProdOrder);
                repReplanProdOrder.RunModal();

            end;
        end;
    end;
    //--- Report 5753 ---
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterSalesLineOnPreDataItem', '', false, false)]
    local procedure OnAfterSalesLineOnPreDataItem(var SalesLine: Record "Sales Line"; OneHeaderCreated: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        //if SalesLine."Document Type" = SalesLine."Document Type"::Order then
        //    SalesLine.SetRange(Type);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterCreateShptHeader', '', false, false)]
    local procedure OnAfterCreateShptHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line")
    var
        RecLSalesHeader: Record "Sales Header";
    begin
        WarehouseShipmentHeader.Validate("Posting Date", 0D);
        if RecLSalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
            WarehouseShipmentHeader.Validate("BBX Project Manager", RecLSalesHeader."BBX Project Manager");
        WarehouseShipmentHeader.Validate("Shipping Agent Code", SalesLine."Shipping Agent Code");
        WarehouseShipmentHeader.Modify(false);
    end;
    //--- Report 99001026 ---
    [EventSubscriber(ObjectType::Report, report::"Replan Production Order", 'OnProdOrderCompOnAfterGetRecordOnBeforeProdOrderModify', '', true, false)]
    local procedure OnProdOrderCompOnAfterGetRecordOnBeforeProdOrderModifyExt(var ProdOrder: Record "Production Order"; MainProdOrder: Record "Production Order")
    begin
        ProdOrder."BBXLink Main Prod. Order No." := MainProdOrder."No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"BBX Setup Table", 'OnAfterInsertEvent', '', true, false)]
    local procedure OnAfterInsertEvent(var Rec: Record "BBX Setup Table")
    begin
        //rec.BBSUpdateProdOrderSerialNo();
        rec.BBSUpdateProdOrderMonoSerialNo();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateEntryOnBeforeOnBeforeSplitReservEntry', '', true, false)]
    local procedure OnCreateEntryOnBeforeOnBeforeSplitReservEntryExt(var ReservEntry2: Record "Reservation Entry"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry2."Serial No." := ReservEntry."Serial No.";
    end;




}