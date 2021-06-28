codeunit 50201 "BBX Function Mgt"
{
    trigger OnRun()
    begin

    end;

    var
        GetSourceDocuments: Report "Get Source Documents";

    procedure InsertRepairTemplateActivitiesFromServiceItemLine(RecPServiceItemLine: Record "Service Item Line"; CodPRepairTemplateCode: Code[20])
    var
        RecLServiceLine: Record "Service Line";
        RecLRepairTemplateActivities: Record "BBX Repair Template Activities";
        CodLServiceItemLineNo: Code[20];
    begin
        RecLRepairTemplateActivities.SETRANGE("Repair Template Code", CodPRepairTemplateCode);
        IF RecLRepairTemplateActivities.FINDSET() THEN
            REPEAT
                RecLServiceLine.VALIDATE("Document Type", RecPServiceItemLine."Document Type");
                RecLServiceLine.VALIDATE("Document No.", RecPServiceItemLine."Document No.");
                RecLServiceLine.Type := RecLRepairTemplateActivities.Type;
                RecLServiceLine."No." := RecLRepairTemplateActivities."No.";
                RecLServiceLine.VALIDATE("Line No.", GetLineNo(RecPServiceItemLine."Document No.", RecPServiceItemLine."Document Type"));
                RecLServiceLine.VALIDATE("Fault Code", RecPServiceItemLine."Fault Code");
                RecLServiceLine.VALIDATE("Fault Area Code", RecPServiceItemLine."Fault Area Code");
                RecLServiceLine.VALIDATE("Symptom Code", RecPServiceItemLine."Symptom Code");
                RecLServiceLine.VALIDATE("Resolution Code", RecPServiceItemLine."Resolution Code");
                EVALUATE(CodLServiceItemLineNo, RecPServiceItemLine."Service Item No.");
                RecLServiceLine.VALIDATE("Service Item No.", CodLServiceItemLineNo);
                RecLServiceLine.VALIDATE("Customer No.", RecPServiceItemLine."Customer No.");
                RecLServiceLine.VALIDATE(Description, RecLRepairTemplateActivities.Description);
                RecLServiceLine.VALIDATE("Location Code", RecLRepairTemplateActivities."Location Code");
                RecLServiceLine.VALIDATE("Unit of Measure", RecLRepairTemplateActivities.UOM);
                RecLServiceLine.VALIDATE("Unit Price", RecLRepairTemplateActivities."Unit Price Excl VAT");
                RecLServiceLine.INSERT(true);
            UNTIL RecLRepairTemplateActivities.NEXT() = 0;
    end;

    procedure InsertRepairTemplateActivitiesFromServiceLine(RecPServiceLine: Record "Service Line"; CodPRepairTemplateCode: Code[20])
    var
        RecLServiceLine: Record "Service Line";
        RecLRepairTemplateActivities: Record "BBX Repair Template Activities";
        CodLServiceItemLineNo: Code[20];
    begin
        RecLRepairTemplateActivities.SETRANGE("Repair Template Code", CodPRepairTemplateCode);
        IF RecLRepairTemplateActivities.FINDSET() THEN
            REPEAT
                RecLServiceLine.VALIDATE("Document Type", RecPServiceLine."Document Type");
                RecLServiceLine.VALIDATE("Document No.", RecPServiceLine."Document No.");
                RecLServiceLine.Type := RecLRepairTemplateActivities.Type;
                RecLServiceLine."No." := RecLRepairTemplateActivities."No.";
                RecLServiceLine.VALIDATE("Line No.", GetLineNo(RecPServiceLine."Document No.", RecPServiceLine."Document Type".AsInteger()));
                RecLServiceLine.VALIDATE("Fault Code", RecPServiceLine."Fault Code");
                RecLServiceLine.VALIDATE("Fault Area Code", RecPServiceLine."Fault Area Code");
                RecLServiceLine.VALIDATE("Symptom Code", RecPServiceLine."Symptom Code");
                RecLServiceLine.VALIDATE("Resolution Code", RecPServiceLine."Resolution Code");
                RecLServiceLine.VALIDATE("Service Item No.", RecPServiceLine."Service Item No.");
                RecLServiceLine.VALIDATE("Customer No.", RecPServiceLine."Customer No.");
                RecLServiceLine.VALIDATE(Description, RecLRepairTemplateActivities.Description);
                RecLServiceLine.VALIDATE("Location Code", RecLRepairTemplateActivities."Location Code");
                RecLServiceLine.VALIDATE("Unit of Measure", RecLRepairTemplateActivities.UOM);
                RecLServiceLine.VALIDATE("Unit Price", RecLRepairTemplateActivities."Unit Price Excl VAT");
                RecLServiceLine.INSERT(true);
            UNTIL RecLRepairTemplateActivities.NEXT() = 0;
    end;

    local procedure GetLineNo(CodPDocumentNo: Code[20]; OptPdocumentType: Option Quote,Order,Invoice,"Credit Memo"): Integer
    var
        RecLServiceLine: Record "Service Line";
    begin
        RecLServiceLine.SetRange("Document No.", CodPDocumentNo);
        RecLServiceLine.SetRange("Document Type", OptPdocumentType);
        IF RecLServiceLine.FindLast() THEN
            EXIT(RecLServiceLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    procedure CalcClaim2Percent(var recExpenseHEader: record "CEM Expense Header")
    var
        recExpenseLine: Record "CEM Expense";
        recGenLedgerSetup: Record "General Ledger Setup";
        decClaimAmount: Decimal;
        intLineNo: Integer;
    begin
        recGenLedgerSetup.Get();
        recGenLedgerSetup.TestField("BBX Auto. Expense type");
        recGenLedgerSetup.TestField("BBX Claim %");
        recExpenseLine.SetFilter("Settlement No.", '%1', recExpenseHEader."No.");
        recExpenseLine.SetFilter("Currency Code", '<>%1&<>%2', '', recGenLedgerSetup."Local Currency Symbol");
        recExpenseLine.CalcSums(recExpenseLine."Amount (LCY)");
        decClaimAmount := recExpenseLine."Amount (LCY)";

        if decClaimAmount <> 0 then begin
            recExpenseLine.SetRange("Currency Code");

            if recExpenseLine.FindLast() then
                intLineNo := recExpenseLine."Settlement Line No." + 10000
            else
                intLineNo := 10000;

            with recExpenseLine do begin
                recExpenseHEader.Status := recExpenseHEader.Status::Open;
                recExpenseHEader.Modify();

                Init();

                "Entry No." := FctGetEntryNo;
                "Continia User ID" := recExpenseHEader."Continia User ID";
                VALIDATE("Settlement No.", recExpenseHEader."No.");
                "Expense Header GUID" := recExpenseHEader."Exp. Header GUID";
                "Country/Region Code" := recExpenseHEader."Country/Region Code";
                "Currency Code" := recExpenseHEader."Currency Code";
                "Global Dimension 1 Code" := recExpenseHEader."Global Dimension 1 Code";
                "Global Dimension 2 Code" := recExpenseHEader."Global Dimension 2 Code";
                "Job No." := recExpenseHEader."Job No.";
                "Job Task No." := recExpenseHEader."Job Task No.";
                "Job Line Type" := recExpenseHEader."Job Line Type";
                Billable := recExpenseHEader.Billable;
                recExpenseLine."Settlement Line No." := intLineNo;
                "Document Date" := WorkDate();
                insert(true);

                Validate("Expense Type", recGenLedgerSetup."BBX Auto. Expense type");
                Validate(Amount, decClaimAmount * recGenLedgerSetup."BBX Claim %" / 100);
                Validate(BBXClaimPercentSystem, true);
                "Cash/Private Card" := TRUE;
                Modify(true);


                recExpenseHEader.Status := recExpenseHEader.Status::Released;
                recExpenseHEader.Modify();
            end;
        end;
    end;
    //---Table 60---
    procedure IsSingleRecordSelected(RecordVariant: Variant; CVNo: Code[20]; CVFieldNo: Integer): Boolean
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.GetTable(RecordVariant);
        if not RecRef.FindSet then
            exit(false);

        if RecRef.Next = 0 then
            exit(true);

        FieldRef := RecRef.Field(CVFieldNo);
        FieldRef.SetFilter('<>%1', CVNo);
        exit(RecRef.IsEmpty);
    end;

    procedure CheckShowProfileSelectionMethodDialog(SingleRecordSelected: Boolean; var ProfileSelectionMethod: Option ConfirmDefault,ConfirmPerEach,UseDefault; AccountNo: Code[20]; IsCustomer: Boolean) Result: Boolean
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

        if not SingleRecordSelected then
            if not DocumentSendingProfile.ProfileSelectionMethodDialog(ProfileSelectionMethod, IsCustomer) then
                exit(false);
        exit(true);
    end;

    //---Codeunit 81---
    procedure FctConfirmPost(var SalesHeader: Record "Sales Header"; DefaultOption: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        ShipInvoiceQst: Label '&Ship,&Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
    begin
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;
        if DefaultOption > 2 then
            DefaultOption := 2;

        with SalesHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        Ship := Selection in [1];
                        Invoice := Selection in [2];
                        if Selection = 0 then
                            exit(false);
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(PostConfirmQst, Format("Document Type")), true)
                    then
                        exit(false);
            end;
            "Print Posted Documents" := false;
        end;
        exit(true);
    end;

    //---Codeunit 91---
    procedure FctConfirmPostPurch(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive,&Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
    begin
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;
        if DefaultOption > 2 then
            DefaultOption := 2;

        with PurchaseHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1];
                        Invoice := Selection in [2];
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit(false);
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(PostConfirmQst, Format("Document Type")), true)
                    then
                        exit(false);
            end;
            "Print Posted Documents" := false;
        end;
        exit(true);
    end;

    procedure PrintSalesShipmentHeaderToDocumentAttachment(var RecPSalesShipmentHeader: Record "Sales Shipment Header");
    var
        BooLShowNotificationAction: Boolean;
        RecLReportSelections: Record "Report Selections";
        CduLDocPrint: Codeunit "Document-Print";
    begin
        BooLShowNotificationAction := RecPSalesShipmentHeader.Count() = 1;
        if RecPSalesShipmentHeader.FindSet() then
            repeat
                RecPSalesShipmentHeader.SetRecFilter();
                RecLReportSelections.SaveAsDocumentAttachment(RecLReportSelections.Usage::"S.Shipment".AsInteger(), RecPSalesShipmentHeader, RecPSalesShipmentHeader."No.", '', BooLShowNotificationAction);
                RecLReportSelections.SaveAsDocumentAttachment(RecLReportSelections.Usage::"Pro Forma S. Invoice".AsInteger(), RecPSalesShipmentHeader, RecPSalesShipmentHeader."No.", '', BooLShowNotificationAction);
            until RecPSalesShipmentHeader.Next() = 0;
    end;

    procedure FctOnBeforePostInvoicePostBufferFctOnBeforePostInvoicePostBuffer(SalesHeader: Record "Sales Header"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line")
    var
        TempInvoicePostBuffer1: Record "Invoice Post. Buffer" temporary;
        TempInvoicePostBuffer2: Record "Invoice Post. Buffer" temporary;
        TempInvoicePostBuffer3: Record "Invoice Post. Buffer" temporary;
        SalesLine: Record "Sales Line";
        RecLGenPostingSetup: Record "General Posting Setup";
        RecLVentilationLines: Record "BBX Ventilation Lines";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        AmountRoundingPrec: Decimal;
        VATRoundingPrec: Decimal;
        AmountL: Decimal;
        VATBaseAmount: Decimal;
        VATAmount: Decimal;
        AmountACY: Decimal;
        VATBaseAmountACY: Decimal;
        VATAmountACY: Decimal;
        VATDifference: Decimal;
        VATBaseBeforePmtDisc: Decimal;
        IntLCountLine: Integer;
    begin
        TempInvoicePostBuffer2 := TempInvoicePostBuffer;
        /*if TempInvoicePostBuffer.findset then
            repeat

            until TempInvoicePostBuffer.Next() = 0;*/
        TempInvoicePostBuffer.DeleteAll();
        repeat
            //Initial Amounts
            AmountL := TempInvoicePostBuffer2.Amount;
            //VATBaseAmount := TempInvoicePostBuffer2."VAT Base Amount";
            //VATAmount := TempInvoicePostBuffer2."VAT Amount";
            //AmountACY := TempInvoicePostBuffer2."Amount (ACY)";
            //VATBaseAmountACY := TempInvoicePostBuffer2."VAT Base Amount (ACY)";
            //VATAmountACY := TempInvoicePostBuffer2."VAT Amount (ACY)";
            //VATDifference := TempInvoicePostBuffer2."VAT Difference";
            //VATBaseBeforePmtDisc := TempInvoicePostBuffer2."VAT Base Before Pmt. Disc.";

            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange("Gen. Bus. Posting Group", TempInvoicePostBuffer2."Gen. Bus. Posting Group");
            SalesLine.SetRange("Gen. Prod. Posting Group", TempInvoicePostBuffer2."Gen. Prod. Posting Group");
            SalesLine.SetRange("VAT Bus. Posting Group", TempInvoicePostBuffer2."VAT Bus. Posting Group");
            SalesLine.SetRange("VAT Prod. Posting Group", TempInvoicePostBuffer2."VAT Prod. Posting Group");
            SalesLine.SetRange("Tax Area Code", TempInvoicePostBuffer2."Tax Area Code");
            SalesLine.SetRange("Tax Group Code", TempInvoicePostBuffer2."Tax Group Code");
            SalesLine.SetRange("Tax Liable", TempInvoicePostBuffer2."Tax Liable");
            SalesLine.SetRange("Dimension Set ID", TempInvoicePostBuffer2."Dimension Set ID");
            SalesLine.SetRange("Job No.", TempInvoicePostBuffer2."Job No.");
            SalesLine.SetRange("Deferral Code", TempInvoicePostBuffer2."Deferral Code");
            //SalesLine.SetFilter("Qty. to Ship", '<>%1', 0);
            if SalesLine.Findset() then
                repeat
                    RecLVentilationLines.SetRange("Sales Order No.", SalesLine."Document No.");
                    RecLVentilationLines.SetRange("Sales Order Line No.", SalesLine."Line No.");
                    if RecLVentilationLines.FindSet() then begin
                        //IntLCountLine := RecLVentilationLines.COUNT;
                        repeat
                            RecLGenPostingSetup.Get(SalesLine."Gen. Bus. Posting Group", RecLVentilationLines."Gen. Prod. Posting Group");
                            if TempInvoicePostBuffer1.Get(TempInvoicePostBuffer2.Type,
                                                            RecLGenPostingSetup.GetSalesInvDiscAccount,
                                                            TempInvoicePostBuffer2."Gen. Bus. Posting Group",
                                                            RecLVentilationLines."Gen. Prod. Posting Group",
                                                            TempInvoicePostBuffer2."VAT Bus. Posting Group",
                                                            TempInvoicePostBuffer2."VAT Prod. Posting Group",
                                                            TempInvoicePostBuffer2."Tax Area Code",
                                                            TempInvoicePostBuffer2."Tax Group Code",
                                                            TempInvoicePostBuffer2."Tax Liable",
                                                            TempInvoicePostBuffer2."Use Tax",
                                                            TempInvoicePostBuffer2."Dimension Set ID",
                                                            TempInvoicePostBuffer2."Job No.",
                                                            TempInvoicePostBuffer2."Fixed Asset Line No.",
                                                            TempInvoicePostBuffer2."Deferral Code",
                                                            TempInvoicePostBuffer2."Additional Grouping Identifier") then begin
                                TempInvoicePostBuffer1.Amount += -RecLVentilationLines."Ventilated Amount";
                                TempInvoicePostBuffer1.Modify();
                            end else begin
                                TempInvoicePostBuffer1.Init();
                                TempInvoicePostBuffer1.Amount := -RecLVentilationLines."Ventilated Amount";

                                TempInvoicePostBuffer1.Type := TempInvoicePostBuffer2.Type;
                                TempInvoicePostBuffer1."G/L Account" := RecLGenPostingSetup.GetSalesInvDiscAccount;
                                TempInvoicePostBuffer1."Gen. Bus. Posting Group" := TempInvoicePostBuffer2."Gen. Bus. Posting Group";
                                TempInvoicePostBuffer1."Gen. Prod. Posting Group" := RecLVentilationLines."Gen. Prod. Posting Group";
                                TempInvoicePostBuffer1."VAT Bus. Posting Group" := TempInvoicePostBuffer2."VAT Bus. Posting Group";
                                TempInvoicePostBuffer1."VAT Prod. Posting Group" := TempInvoicePostBuffer2."VAT Prod. Posting Group";
                                TempInvoicePostBuffer1."Tax Area Code" := TempInvoicePostBuffer2."Tax Area Code";
                                TempInvoicePostBuffer1."Tax Group Code" := TempInvoicePostBuffer2."Tax Group Code";
                                TempInvoicePostBuffer1."Tax Liable" := TempInvoicePostBuffer2."Tax Liable";
                                TempInvoicePostBuffer1."Use Tax" := TempInvoicePostBuffer2."Use Tax";
                                TempInvoicePostBuffer1."Dimension Set ID" := TempInvoicePostBuffer2."Dimension Set ID";
                                TempInvoicePostBuffer1."Job No." := TempInvoicePostBuffer2."Job No.";
                                TempInvoicePostBuffer1."Fixed Asset Line No." := TempInvoicePostBuffer2."Fixed Asset Line No.";
                                TempInvoicePostBuffer1."Deferral Code" := TempInvoicePostBuffer2."Deferral Code";
                                TempInvoicePostBuffer1."Additional Grouping Identifier" := TempInvoicePostBuffer2."Additional Grouping Identifier";
                                TempInvoicePostBuffer1.Insert();
                            end;
                        until RecLVentilationLines.Next() = 0;
                    end else begin
                        RecLGenPostingSetup.Get(SalesLine."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group");
                        if TempInvoicePostBuffer1.Get(TempInvoicePostBuffer2.Type,
                                                            RecLGenPostingSetup.GetSalesInvDiscAccount,
                                                            TempInvoicePostBuffer2."Gen. Bus. Posting Group",
                                                            TempInvoicePostBuffer2."Gen. Prod. Posting Group",
                                                            TempInvoicePostBuffer2."VAT Bus. Posting Group",
                                                            TempInvoicePostBuffer2."VAT Prod. Posting Group",
                                                            TempInvoicePostBuffer2."Tax Area Code",
                                                            TempInvoicePostBuffer2."Tax Group Code",
                                                            TempInvoicePostBuffer2."Tax Liable",
                                                            TempInvoicePostBuffer2."Use Tax",
                                                            TempInvoicePostBuffer2."Dimension Set ID",
                                                            TempInvoicePostBuffer2."Job No.",
                                                            TempInvoicePostBuffer2."Fixed Asset Line No.",
                                                            TempInvoicePostBuffer2."Deferral Code",
                                                            TempInvoicePostBuffer2."Additional Grouping Identifier") then begin
                            TempInvoicePostBuffer1.Amount += -SalesLine.Amount;
                            TempInvoicePostBuffer1.Modify();
                        end else begin
                            TempInvoicePostBuffer1.Init();
                            TempInvoicePostBuffer1.Amount := -SalesLine.Amount;

                            TempInvoicePostBuffer1.Type := TempInvoicePostBuffer2.Type;
                            TempInvoicePostBuffer1."G/L Account" := RecLGenPostingSetup.GetSalesInvDiscAccount;
                            TempInvoicePostBuffer1."Gen. Bus. Posting Group" := TempInvoicePostBuffer2."Gen. Bus. Posting Group";
                            TempInvoicePostBuffer1."Gen. Prod. Posting Group" := TempInvoicePostBuffer2."Gen. Prod. Posting Group";
                            TempInvoicePostBuffer1."VAT Bus. Posting Group" := TempInvoicePostBuffer2."VAT Bus. Posting Group";
                            TempInvoicePostBuffer1."VAT Prod. Posting Group" := TempInvoicePostBuffer2."VAT Prod. Posting Group";
                            TempInvoicePostBuffer1."Tax Area Code" := TempInvoicePostBuffer2."Tax Area Code";
                            TempInvoicePostBuffer1."Tax Group Code" := TempInvoicePostBuffer2."Tax Group Code";
                            TempInvoicePostBuffer1."Tax Liable" := TempInvoicePostBuffer2."Tax Liable";
                            TempInvoicePostBuffer1."Use Tax" := TempInvoicePostBuffer2."Use Tax";
                            TempInvoicePostBuffer1."Dimension Set ID" := TempInvoicePostBuffer2."Dimension Set ID";
                            TempInvoicePostBuffer1."Job No." := TempInvoicePostBuffer2."Job No.";
                            TempInvoicePostBuffer1."Fixed Asset Line No." := TempInvoicePostBuffer2."Fixed Asset Line No.";
                            TempInvoicePostBuffer1."Deferral Code" := TempInvoicePostBuffer2."Deferral Code";
                            TempInvoicePostBuffer1."Additional Grouping Identifier" := TempInvoicePostBuffer2."Additional Grouping Identifier";
                            TempInvoicePostBuffer1.Insert();
                        end;
                    end;
                until SalesLine.Next() = 0;
        until TempInvoicePostBuffer2.Next() = 0;
        if TempInvoicePostBuffer1.FindSet() then
            repeat
                TempInvoicePostBuffer.Init();
                TempInvoicePostBuffer := TempInvoicePostBuffer1;
                TempInvoicePostBuffer.Insert()
            until TempInvoicePostBuffer1.Next() = 0;
    end;

    procedure ShowResult(WhseShipmentCreated: Boolean)
    var
        WarehouseRequest: Record "Warehouse Request";
        IsHandled: Boolean;
        CstLMsg: Label 'No %1 was found. The warehouse shipment could not be created.';
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if WhseShipmentCreated then begin
            GetSourceDocuments.ShowShipmentDialog;
            OpenWarehouseShipmentPage;
        end else
            Message(CstLMsg, WarehouseRequest.TableCaption);
    end;

    procedure FctCreateFromSalesOrder(RecPSalesHeader: Record "Sales Header"): Boolean
    var
        WhseRqst: Record "Warehouse Request";
    begin
        ShowResult(FctCreateFromSalesOrderHideDialog(RecPSalesHeader));
    end;

    procedure FctCreateFromSalesOrderHideDialog(RecPSalesHeader: Record "Sales Header"): Boolean
    var
        WhseRqst: Record "Warehouse Request";
    begin
        if not RecPSalesHeader.IsApprovedForPosting then
            exit(false);

        FindWarehouseRequestForSalesOrder(WhseRqst, RecPSalesHeader);

        if WhseRqst.IsEmpty then
            exit(false);

        CreateWhseShipmentHeaderFromWhseRequest(WhseRqst);
        exit(true);
    end;

    procedure FindWarehouseRequestForSalesOrder(var WhseRqst: Record "Warehouse Request"; SalesHeader: Record "Sales Header")
    var
        CduLGetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        LblText003: Label 'The warehouse shipment was not created because an open warehouse shipment exists for the Sales Header and Shipping Advice is %1.\\You must add the item(s) as new line(s) to the existing warehouse shipment or change Shipping Advice to Partial.';
    begin
        with SalesHeader do begin
            //TestField(Status, Status::Released);
            if WhseShipmentConflict("Document Type", "No.", "Shipping Advice") then
                Error(LblText003, Format("Shipping Advice"));
            CduLGetSourceDocOutbound.CheckSalesHeader(SalesHeader, true);
            WhseRqst.SetRange(Type, WhseRqst.Type::Outbound);
            WhseRqst.SetSourceFilter(DATABASE::"Sales Line", "Document Type".AsInteger(), "No.");
            WhseRqst.SetRange("Document Status", WhseRqst."Document Status"::Released);
            GetRequireShipRqst(WhseRqst);
        end;
    end;

    procedure GetRequireShipRqst(var WhseRqst: Record "Warehouse Request")
    var
        Location: Record Location;
        LocationCode: Text;
    begin
        if WhseRqst.FindSet then begin
            repeat
                if Location.RequireShipment(WhseRqst."Location Code") then
                    LocationCode += WhseRqst."Location Code" + '|';
            until WhseRqst.Next = 0;
            if LocationCode <> '' then begin
                LocationCode := CopyStr(LocationCode, 1, StrLen(LocationCode) - 1);
                if LocationCode[1] = '|' then
                    LocationCode := '''''' + LocationCode;
            end;
            WhseRqst.SetFilter("Location Code", LocationCode);
        end;
    end;

    procedure CreateWhseShipmentHeaderFromWhseRequest(var WarehouseRequest: Record "Warehouse Request") Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

        if WarehouseRequest.IsEmpty then
            exit(false);

        Clear(GetSourceDocuments);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.SetHideDialog(true);
        GetSourceDocuments.RunModal;

        exit(true);
    end;

    procedure UpdateAmountVentilation(var SalesLine: Record "Sales Line")
    var
        VentilationLines: Record "BBX Ventilation Lines";
    begin
        if (SalesLine."Unit Price" = 0) or (SalesLine."Line No." = 0) or (SalesLine."Document Type" <> SalesLine."Document Type"::Order) then
            exit;

        VentilationLines.SetRange("Sales Order No.", SalesLine."Document No.");
        VentilationLines.SetRange("Sales Order Line No.", SalesLine."Line No.");
        VentilationLines.SetRange("Item No.", SalesLine."No.");
        if VentilationLines.FindSet() then
            repeat
                VentilationLines.Validate(Amount, SalesLine.Amount);
                VentilationLines.Modify();
            until VentilationLines.Next() = 0;
    end;

    procedure HasVentilationLineLinkToSalesOrderLine(SalesLine: Record "Sales Line"): Boolean
    var
        VentilationLines: Record "BBX Ventilation Lines";
    begin
        VentilationLines.SetRange("Sales Order No.", SalesLine."Document No.");
        VentilationLines.SetRange("Sales Order Line No.", SalesLine."Line No.");
        exit(not VentilationLines.IsEmpty);
    end;

    procedure FctCreateWhseRequests(SalesHeader: Record "Sales Header")
    var
        WhseType: Option Inbound,Outbound;
        OldWhseType: Option Inbound,Outbound;
        IsHandled: Boolean;
        WhseRqst: Record "Warehouse Request";
        SalesLine: Record "Sales Line";
        First: Boolean;
        OldLocationCode: Code[10];
    begin
        WhseRqst."Source Document" := WhseRqst."Source Document"::"Sales Order";

        SalesLine.SetCurrentKey("Document Type", "Document No.", "Location Code");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("Drop Shipment", false);
        SalesLine.SetRange("Job No.", '');
        if SalesLine.FindSet then begin
            First := true;
            repeat
                if ((SalesHeader."Document Type" = "Sales Document Type"::Order) and (SalesLine.Quantity >= 0)) or
                    ((SalesHeader."Document Type" = "Sales Document Type"::"Return Order") and (SalesLine.Quantity < 0))
                then
                    WhseType := WhseType::Outbound
                else
                    WhseType := WhseType::Inbound;

                if First or (SalesLine."Location Code" <> OldLocationCode) or (WhseType <> OldWhseType) then
                    CreateWhseRqst(SalesHeader, SalesLine, WhseType);

                First := false;
                OldLocationCode := SalesLine."Location Code";
                OldWhseType := WhseType;
            until SalesLine.Next = 0;
        end;

        WhseRqst.Reset();
        WhseRqst.SetCurrentKey("Source Type", "Source Subtype", "Source No.");
        WhseRqst.SetRange(Type, WhseRqst.Type);
        WhseRqst.SetSourceFilter(DATABASE::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.");
        WhseRqst.SetRange("Document Status", SalesHeader.Status::Open);
        if not WhseRqst.IsEmpty then
            WhseRqst.DeleteAll(true);
    end;

    local procedure CreateWhseRqst(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; WhseType: Option Inbound,Outbound)
    var
        SalesLine2: Record "Sales Line";
        Location: Record Location;
        WhseRqst: Record "Warehouse Request";
    begin
        if ((WhseType = WhseType::Outbound) and
            (Location.RequireShipment(SalesLine."Location Code") or
             Location.RequirePicking(SalesLine."Location Code"))) or
           ((WhseType = WhseType::Inbound) and
            (Location.RequireReceive(SalesLine."Location Code") or
             Location.RequirePutaway(SalesLine."Location Code")))
        then begin
            SalesLine2.Copy(SalesLine);
            SalesLine2.SetRange("Location Code", SalesLine."Location Code");
            SalesLine2.SetRange("Unit of Measure Code", '');
            if SalesLine2.FindFirst then
                SalesLine2.TestField("Unit of Measure Code");

            WhseRqst.Type := WhseType;
            WhseRqst."Source Document" := WhseRqst."Source Document"::"Sales Order";
            WhseRqst."Source Type" := DATABASE::"Sales Line";
            WhseRqst."Source Subtype" := SalesHeader."Document Type".AsInteger();
            WhseRqst."Source No." := SalesHeader."No.";
            WhseRqst."Shipment Method Code" := SalesHeader."Shipment Method Code";
            WhseRqst."Shipping Agent Code" := SalesHeader."Shipping Agent Code";
            WhseRqst."Shipping Advice" := SalesHeader."Shipping Advice";
            WhseRqst."Document Status" := SalesHeader.Status::Released.AsInteger();
            WhseRqst."Location Code" := SalesLine."Location Code";
            WhseRqst."Destination Type" := WhseRqst."Destination Type"::Customer;
            WhseRqst."Destination No." := SalesHeader."Sell-to Customer No.";
            WhseRqst."External Document No." := SalesHeader."External Document No.";
            if WhseType = WhseType::Inbound then
                WhseRqst."Expected Receipt Date" := SalesHeader."Shipment Date"
            else
                WhseRqst."Shipment Date" := SalesHeader."Shipment Date";
            SalesHeader.SetRange("Location Filter", SalesLine."Location Code");
            SalesHeader.CalcFields("Completely Shipped");
            WhseRqst."Completely Handled" := SalesHeader."Completely Shipped";
            if not WhseRqst.Insert() then
                WhseRqst.Modify();
        end;
    end;


    local procedure OpenWarehouseShipmentPage()
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        GetSourceDocuments.GetLastShptHeader(WarehouseShipmentHeader);
        PAGE.Run(PAGE::"Warehouse Shipment", WarehouseShipmentHeader);
    end;

    procedure FctGetEntryNo(): Integer
    var
        Expense: Record "CEM Expense";
    begin
        IF Expense.FINDLAST THEN
            EXIT(Expense."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    procedure CreatSalesLine(var TmpPSalesLine: Record "Sales Line" temporary; RecPSalesLine: Record "Sales Line")
    var
        IntLLineNo: Integer;
    begin
        if TmpPSalesLine.FindLast() then
            IntLLineNo += 10000
        else
            IntLLineNo := 10000;
        TmpPSalesLine.Reset();
        TmpPSalesLine.Init();
        TmpPSalesLine := RecPSalesLine;
        TmpPSalesLine."Line No." := IntLLineNo;
        TmpPSalesLine.Insert(false);
    end;

    //--- Codeunit 5920 ---
    procedure FctCreateServItemOnSalesLineShpt(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; SalesShipmentLine: Record "Sales Shipment Line")
    var
        ServItemComponent: Record "Service Item Component";
        ItemTrackingCode: Record "Item Tracking Code";
        BOMComp: Record "BOM Component";
        BOMComp2: Record "BOM Component";
        PurchaseHeader: Record "Purchase Header";
        TrackingLinesExist: Boolean;
        x: Integer;
        NextLineNo: Integer;
        Index: Integer;
        ServItemWithSerialNoExist: Boolean;
        WarrantyStartDate: Date;
        Item: Record Item;
        RecLItem2: Record Item;
        ServItemGr: Record "Service Item Group";
        TempReservEntry: Record "Reservation Entry" temporary;
        TempServiceItem: Record "Service Item" temporary;
        TempServiceItemComp: Record "Service Item Component" temporary;
        GLSetup: Record "General Ledger Setup";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItem: Record "Service Item";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        RecLProductionBOMLine: Record "Production BOM Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CduLSerItemMgt: Codeunit ServItemManagement;
        ResSkillMgt: Codeunit "Resource Skill Mgt.";
        ServLogMgt: Codeunit ServLogManagement;
    begin

        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine."Qty. to Ship (Base)" > 0) then begin
            Item.Get(SalesLine."No.");
            if not ItemTrackingCode.Get(Item."Item Tracking Code") then
                ItemTrackingCode.Init();

            RecLProductionBOMLine.SetRange("Production BOM No.", Item."Production BOM No.");
            RecLProductionBOMLine.SetRange("BBX Service Item Creation", true);
            if RecLProductionBOMLine.FindSet() then
                repeat
                    RecLItem2.GetItemNo(RecLProductionBOMLine."No.");
                    TempReservEntry.SetRange("Item No.", SalesLine."No.");
                    TempReservEntry.SetRange("Location Code", SalesLine."Location Code");
                    TempReservEntry.SetRange("Variant Code", SalesLine."Variant Code");
                    TempReservEntry.SetRange("Source Subtype", SalesLine."Document Type");
                    TempReservEntry.SetRange("Source ID", SalesLine."Document No.");
                    TempReservEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                    TrackingLinesExist := TempReservEntry.FindSet;

                    TempServiceItem.DeleteAll();
                    TempServiceItemComp.DeleteAll();

                    GLSetup.Get();
                    ServMgtSetup.Get();
                    ServMgtSetup.TestField("Service Item Nos.");
                    for x := 1 to SalesLine."Qty. to Ship (Base)" do begin
                        Clear(ServItem);
                        ServItemWithSerialNoExist := false;
                        if TempReservEntry."Serial No." <> '' then begin
                            ServItem.SetRange("Item No.", RecLProductionBOMLine."No.");
                            ServItem.SetRange("Serial No.", TempReservEntry."Serial No.");
                            if ServItem.FindFirst then
                                ServItemWithSerialNoExist := true;
                        end;
                        if (TempReservEntry."Serial No." = '') or (not ServItemWithSerialNoExist) then begin
                            ServItem.Init();
                            NoSeriesMgt.InitSeries(
                              ServMgtSetup."Service Item Nos.", ServItem."No. Series", 0D, ServItem."No.", ServItem."No. Series");
                            ServItem.Insert();
                        end;
                        ServItem."Sales/Serv. Shpt. Document No." := SalesShipmentLine."Document No.";
                        ServItem."Sales/Serv. Shpt. Line No." := SalesShipmentLine."Line No.";
                        ServItem."Shipment Type" := ServItem."Shipment Type"::Sales;
                        ServItem.Validate(Description,
                          CopyStr(SalesLine.Description, 1, MaxStrLen(ServItem.Description)));
                        ServItem."Description 2" := CopyStr(
                            StrSubstNo('%1 %2', SalesHeader."Document Type", SalesHeader."No."),
                            1, MaxStrLen(ServItem."Description 2"));
                        ServItem.Validate("Customer No.", SalesHeader."Sell-to Customer No.");
                        ServItem.Validate("Ship-to Code", SalesHeader."Ship-to Code");
                        ServItem.OmitAssignResSkills(true);
                        ServItem.Validate("Item No.", RecLProductionBOMLine."No.");
                        ServItem.OmitAssignResSkills(false);
                        if TrackingLinesExist then
                            ServItem."Serial No." := TempReservEntry."Serial No.";
                        ServItem."Variant Code" := RecLProductionBOMLine."Variant Code";

                        ItemUnitOfMeasure.Get(Item."No.", SalesLine."Unit of Measure Code");

                        ServItem.Validate("Sales Unit Cost", Round(SalesLine."Unit Cost (LCY)" /
                            ItemUnitOfMeasure."Qty. per Unit of Measure", GLSetup."Unit-Amount Rounding Precision"));
                        if SalesHeader."Currency Code" <> '' then
                            ServItem.Validate(
                              "Sales Unit Price",
                              CduLSerItemMgt.CalcAmountLCY(
                                Round(SalesLine."Unit Price" /
                                  ItemUnitOfMeasure."Qty. per Unit of Measure", GLSetup."Unit-Amount Rounding Precision"),
                                SalesHeader."Currency Factor",
                                SalesHeader."Currency Code",
                                SalesHeader."Posting Date"))
                        else
                            ServItem.Validate("Sales Unit Price", Round(SalesLine."Unit Price" /
                                ItemUnitOfMeasure."Qty. per Unit of Measure", GLSetup."Unit-Amount Rounding Precision"));
                        ServItem."Vendor No." := RecLItem2."Vendor No.";
                        ServItem."Vendor Item No." := RecLItem2."Vendor Item No.";
                        ServItem."Unit of Measure Code" := RecLItem2."Base Unit of Measure";
                        ServItem."Sales Date" := SalesHeader."Posting Date";
                        ServItem."Installation Date" := SalesHeader."Posting Date";
                        ServItem."Warranty % (Parts)" := ServMgtSetup."Warranty Disc. % (Parts)";
                        ServItem."Warranty % (Labor)" := ServMgtSetup."Warranty Disc. % (Labor)";

                        if TrackingLinesExist and (TempReservEntry."Warranty Date" <> 0D) then
                            WarrantyStartDate := TempReservEntry."Warranty Date"
                        else begin
                            WarrantyStartDate := SalesHeader."Posting Date";
                            if (WarrantyStartDate = 0D) and SalesLine."Drop Shipment" then
                                if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, SalesLine."Purchase Order No.") then
                                    WarrantyStartDate := PurchaseHeader."Posting Date";
                        end;
                        CduLSerItemMgt.CalcServiceWarrantyDates(
                          ServItem, WarrantyStartDate, ItemTrackingCode."Warranty Date Formula", ServMgtSetup."Default Warranty Duration");

                        ServItem.Modify();
                        Clear(TempServiceItem);
                        TempServiceItem := ServItem;
                        if TempServiceItem.Insert() then;
                        ResSkillMgt.AssignServItemResSkills(ServItem);

                        if SalesLine."BOM Item No." <> '' then begin
                            Clear(BOMComp);
                            BOMComp.SetRange("Parent Item No.", SalesLine."BOM Item No.");
                            BOMComp.SetRange(Type, BOMComp.Type::Item);
                            BOMComp.SetRange("No.", SalesLine."No.");
                            BOMComp.SetRange("Installed in Line No.", 0);
                            if BOMComp.FindSet then
                                repeat
                                    Clear(BOMComp2);
                                    BOMComp2.SetRange("Parent Item No.", SalesLine."BOM Item No.");
                                    BOMComp2.SetRange("Installed in Line No.", BOMComp."Line No.");
                                    NextLineNo := 0;
                                    if BOMComp2.FindSet then
                                        repeat
                                            for Index := 1 to Round(BOMComp2."Quantity per", 1) do begin
                                                NextLineNo := NextLineNo + 10000;
                                                CduLSerItemMgt.InsertServiceItemComponent(ServItemComponent, BOMComp, BOMComp2, SalesHeader, SalesShipmentLine);
                                                Clear(TempServiceItemComp);
                                                TempServiceItemComp := ServItemComponent;
                                                TempServiceItemComp.Insert();
                                            end;
                                        until BOMComp2.Next = 0;
                                until BOMComp.Next = 0;
                        end;

                        Clear(ServLogMgt);
                        ServLogMgt.ServItemAutoCreated(ServItem);
                        TrackingLinesExist := TempReservEntry.Next = 1;
                    end;
                until RecLProductionBOMLine.Next() = 0;
        end;
    end;
}