table 50210 "BBX Setup Table"
{
    Caption = 'Setup Table';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;

        }
        field(10; "Production Order No."; code[20])
        {
            Caption = 'Production Order No.';
        }
        field(11; "Item Code"; code[20])
        {
            Caption = 'Item Code';
        }
        field(12; "Production Order Item Code"; Code[70])
        {
            Caption = 'Production Order Item Code';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                validate("Production Order No.", CopyStr("Production Order Item Code", 1, strpos("Production Order Item Code", '|') - 1));
                validate("Item Code", CopyStr("Production Order Item Code", strpos("Production Order Item Code", '|') + 1));
            end;
        }
        field(20; "ANT Box Serial No."; Code[20])
        {
            Caption = 'ANT Box Serial No.';
        }
        field(21; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
        }
        field(22; "Key"; Text[100])
        {
            Caption = 'Key';
        }
        field(23; "Bootfile Number"; Integer)
        {
            Caption = 'Bootfile Number';
        }
        field(24; "Test Date"; Date)
        {
            Caption = 'Test Date';
        }
        field(25; "IO Board Firmware"; text[50])
        {
            Caption = 'IO Board Firmware';
        }


    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure BBSUpdateProdOrderMonoSerialNo()
    var
        recProdOrder: Record "Production Order";
        //recMainProdOrder : Record production
        recProdOrderLine: Record "Prod. Order Line";
        recProdOrderComp: Record "Prod. Order Component";
        res337: Record "Reservation Entry";
    begin
        //res337."Reservation Status"::
        recProdOrderLine.SetFilter("Prod. Order No.", '%1', "Production Order No.");
        recProdOrderLine.SetFilter(Status, '%1', recProdOrderLine.Status::Released);
        if recProdOrderLine.FindSet() then begin
            if recProdOrder.Get(recProdOrderLine.Status, recProdOrderLine."Prod. Order No.") then
                if recProdOrder."BBX Sales Order No." <> '' then
                    BBSCreateReservEntry(DATABASE::"Prod. Order Line",
                                        3,
                                        "Production Order No.",
                                        '',
                                        recProdOrderLine."Line No.",
                                        0,
                                        recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                        abs(1),
                                        abs(1),
                                        recProdOrderLine."Item No.",
                                        '',
                                        recProdOrderLine."Ending Date",
                                        recProdOrderLine."Ending Date",
                                        "ANT Box Serial No.",//SerieNo,
                                        '',
                                        recProdOrderLine."Location Code",
                                        0,
                                        true,
                                        recProdOrderLine.Description)
                else
                    BBSCreateEntryProdOrderWithoutSalesOrder(DATABASE::"Prod. Order Line",
                                            3,
                                            "Production Order No.",
                                            '',
                                            recProdOrderLine."Line No.",
                                            0,
                                            recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                            abs(1),
                                            abs(1),
                                            recProdOrderLine."Item No.",
                                            '',
                                            recProdOrderLine."Ending Date",
                                            recProdOrderLine."Ending Date",
                                            "ANT Box Serial No.",//SerieNo,
                                            '',
                                            recProdOrderLine."Location Code",
                                            2,
                                            false,
                                            recProdOrderLine.Description);

            recProdOrderComp.SetFilter(Status, '%1', recProdOrderLine.Status);
            recProdOrderComp.SetFilter("Prod. Order No.", '%1', recProdOrderLine."Prod. Order No.");
            recProdOrderComp.SetFilter("Prod. Order Line No.", '%1', recProdOrderLine."Line No.");
            recProdOrderComp.SetFilter("Item No.", '%1', "Item Code");
            if recProdOrderComp.FindSet() then begin
                BBSCreateReservEntry(DATABASE::"Prod. Order Component",
                        3,
                        recProdOrderComp."Prod. Order No.",
                        '',
                        recProdOrderLine."Line No.",
                        recProdOrderComp."Line No.",
                        recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                        1,
                        1,
                        recProdOrderComp."Item No.",
                        '',
                        recProdOrderComp."Due Date",
                        recProdOrderComp."Due Date",
                        "ANT Box Serial No.",//SerieNo,
                        '',
                        recProdOrderComp."Location Code",
                        2,
                        false,
                        recProdOrderComp.Description);
            end;
        end;
    end;

    procedure BBSUpdateProdOrderSerialNo()
    var
        recProdOrder: Record "Production Order";
        //recMainProdOrder : Record production
        recProdOrderLine: Record "Prod. Order Line";
        recProdOrderComp: Record "Prod. Order Component";
        res337: Record "Reservation Entry";
    begin
        //res337."Reservation Status"::
        recProdOrderLine.SetFilter("Prod. Order No.", '%1', "Production Order No.");
        recProdOrderLine.SetFilter(Status, '%1', recProdOrderLine.Status::Released);
        if recProdOrderLine.FindSet() then begin
            BBSCreateReservEntry(DATABASE::"Prod. Order Line",
                                3,
                                "Production Order No.",
                                '',
                                recProdOrderLine."Line No.",
                                0,
                                recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                abs(1),
                                abs(1),
                                recProdOrderLine."Item No.",
                                '',
                                recProdOrderLine."Ending Date",
                                recProdOrderLine."Ending Date",
                                "ANT Box Serial No.",//SerieNo,
                                '',
                                recProdOrderLine."Location Code",
                                2,
                                false,
                                recProdOrderLine.Description);
            recProdOrder.Get(recProdOrderLine.Status, recProdOrderLine."Prod. Order No.");
            if recProdOrder."BBXLink Main Prod. Order No." <> '' then begin
                recProdOrderLine.SetFilter("Prod. Order No.", '%1', recProdOrder."BBXLink Main Prod. Order No.");
                if recProdOrderLine.FindSet() then begin
                    BBSCreateReservEntry(DATABASE::"Prod. Order Line",
                                3,
                                recProdOrderLine."Prod. Order No.",
                                '',
                                recProdOrderLine."Line No.",
                                0,
                                recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                abs(1),
                                abs(1),
                                recProdOrderLine."Item No.",
                                '',
                                recProdOrderLine."Ending Date",
                                recProdOrderLine."Ending Date",
                                "ANT Box Serial No.",//SerieNo,
                                '',
                                recProdOrderLine."Location Code",
                                0,
                                true,
                                recProdOrderLine.Description);
                    /*
                    cduCreateReservEntry.CreateReservEntryFor(
                                DATABASE::"Prod. Order Line",
                                3,
                                "Production Order No.",
                                '',
                                recProdOrderLine."Line No.",
                                0,
                                recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                abs(1),
                                abs(1),
                                "ANT Box Serial No.",//SerieNo,
                                '');

                        cduCreateReservEntry.CreateEntry(
                            recProdOrderLine."Item No.",//"Item No.",
                            '',
                            recProdOrderLine."Location Code",//"Location Code",
                            '',//''Description,
                            recProdOrderLine."Ending Date",
                            recProdOrderLine."Ending Date",//"Shipment Date",
                            0,
                            1);
                        */
                    recProdOrderComp.SetFilter(Status, '%1', recProdOrderLine.Status);
                    recProdOrderComp.SetFilter("Prod. Order No.", '%1', recProdOrderLine."Prod. Order No.");
                    recProdOrderComp.SetFilter("Prod. Order Line No.", '%1', recProdOrderLine."Line No.");
                    recProdOrderComp.SetFilter("Item No.", '%1', "Item Code");
                    if recProdOrderComp.FindSet() then begin
                        BBSCreateReservEntry(DATABASE::"Prod. Order Component",
                                3,
                                recProdOrderComp."Prod. Order No.",
                                '',
                                recProdOrderLine."Line No.",
                                recProdOrderComp."Line No.",
                                recProdOrderLine."Qty. per Unit of Measure",//"Qty. per Unit of Measure",
                                1,
                                1,
                                recProdOrderComp."Item No.",
                                '',
                                recProdOrderComp."Due Date",
                                recProdOrderComp."Due Date",
                                "ANT Box Serial No.",//SerieNo,
                                '',
                                recProdOrderComp."Location Code",
                                2,
                                false,
                                recProdOrderComp.Description);
                    end;
                end;
            end;
        end;
    end;


    procedure BBSCreateEntryProdOrderWithoutSalesOrder(ForType: Option; ForSubtype: Integer; ForID: Code[20]; ForBatchName: Code[10]; ForProdOrderLine: Integer; ForRefNo: Integer; ForQtyPerUOM: Decimal; Quantity: Decimal; QuantityBase: Decimal; ItemNo: Code[20]; VariantCode: code[20]; RcptDate: Date; ShpDate: Date; SerialNo: code[20]; LotNo: code[20]; LocationCode: code[10]; ResStatus: Integer; booOrderToOrder: Boolean; txtDescription: Text)
    var
        CduLCreateReservEntry: Codeunit "Create Reserv. Entry";
        ForReservEntry: Record "Reservation Entry";
        RecLSerialNoInfo: Record "Serial No. Information";
        RecLotNoInfo: Record "Lot No. Information";
        RecLItem: Record Item;
    begin
        ForReservEntry."Serial No." := SerialNo;
        ForReservEntry."Lot No." := LotNo;
        CduLCreateReservEntry.CreateReservEntryFor(
                            ForType,
                            ForSubtype,
                            ForID,
                            ForBatchName,
                            ForProdOrderLine,
                            ForRefNo,
                            ForQtyPerUOM,
                            Quantity,
                            QuantityBase,
                            ForReservEntry);
        CduLCreateReservEntry.CreateEntry(
            ItemNo,//"Item No.",
            VariantCode,
            LocationCode,//"Location Code",
            txtDescription,//''Description,
            RcptDate,
            ShpDate,//"Shipment Date",
            0,
            2);
        if SerialNo <> '' then begin
            RecLSerialNoInfo.Init();
            RecLSerialNoInfo."Item No." := ItemNo;
            RecLSerialNoInfo."Serial No." := SerialNo;
            RecLSerialNoInfo.BBXKey := "Key";
            RecLSerialNoInfo."BBXTest Date" := "Test Date";
            RecLSerialNoInfo."BBXIO Board Firmware" := "IO Board Firmware";
            RecLSerialNoInfo."BBX BootFile" := Format("Bootfile Number");
            RecLSerialNoInfo."BBX Customer ID" := "Customer ID";
            if RecLSerialNoInfo.Get(ItemNo) then
                RecLSerialNoInfo.Description := RecLItem.Description;
            if RecLSerialNoInfo.Insert(true) then;
        end;
        if LotNo <> '' then begin
            RecLotNoInfo.Init();
            RecLotNoInfo."Item No." := ItemNo;
            RecLotNoInfo."Lot No." := LotNo;
            if RecLotNoInfo.Insert(true) then;
        end;
    end;


    local procedure BBSCreateReservEntry(ForType: Option; ForSubtype: Integer; ForID: Code[20]; ForBatchName: Code[10]; ForProdOrderLine: Integer; ForRefNo: Integer; ForQtyPerUOM: Decimal; Quantity: Decimal; QuantityBase: Decimal; ItemNo: Code[20]; VariantCode: code[20]; RcptDate: Date; ShpDate: Date; SerialNo: code[20]; LotNo: code[20]; LocationCode: code[10]; ResStatus: Integer; booOrderToOrder: Boolean; txtDescription: Text)
    var
        cduCreateReservEntry: Codeunit "Create Reserv. Entry";
        ForReservEntry: Record "Reservation Entry";
        FromReservEntry: Record "Reservation Entry";
        TempTrackingSpec: record "Tracking Specification";
        BaseResEntry: Record "Reservation Entry";
        BaseResEntry2: Record "Reservation Entry";
        recSerialNoInfo: Record "Serial No. Information";
        recLotNoInfo: Record "Lot No. Information";
        RecLItem: Record Item;
    begin
        ForReservEntry."Serial No." := SerialNo;
        ForReservEntry."Lot No." := LotNo;
        cduCreateReservEntry.CreateReservEntryFor(
                            ForType,
                            ForSubtype,
                            ForID,
                            ForBatchName,
                            ForProdOrderLine,
                            ForRefNo,
                            ForQtyPerUOM,
                            Quantity,
                            QuantityBase,
                            ForReservEntry);

        if booOrderToOrder then begin
            BaseResEntry.SetRange("Source Type", ForType);
            BaseResEntry.SetRange("Source Subtype", ForSubtype);
            BaseResEntry.SetRange("Source ID", ForID);
            BaseResEntry.SetRange("Source Prod. Order Line", ForProdOrderLine);
            BaseResEntry.SetRange("Item No.", ItemNo);
            BaseResEntry.SetRange(Binding, BaseResEntry.Binding::"Order-to-Order");
            if BaseResEntry.FindFirst() then begin
                BaseResEntry2.SetFilter("Entry No.", '%1', BaseResEntry."Entry No.");
                BaseResEntry2.SetFilter(Positive, '%1', not (BaseResEntry.Positive));
                if BaseResEntry2.FindFirst() then begin
                    TempTrackingSpec.Init();
                    TempTrackingSpec.SetSource(BaseResEntry2."Source Type", BaseResEntry2."Source Subtype", BaseResEntry2."Source ID", BaseResEntry2."Source Ref. No.", BaseResEntry2."Source Batch Name", BaseResEntry2."Source Prod. Order Line");
                    //TempTrackingSpec."Serial No." := SerialNo;
                    //TempTrackingSpec."Lot No." := LotNo;
                    cduCreateReservEntry.SetBinding(1);
                    cduCreateReservEntry.CreateReservEntryFrom(TempTrackingSpec);
                end;
            end;

            /*
            FromReservEntry.SetSourceFilter(ForType, ForSubtype, ForID, ForRefNo, false);
            FromReservEntry.SetSourceFilter(ForBatchName, ForProdOrderLine);
            FromReservEntry.SETRANGE("Reservation Status", FromReservEntry."Reservation Status"::Reservation);
            FromReservEntry.SETRANGE(Binding, FromReservEntry.Binding::"Order-to-Order");
            */

            /*
                                ForType,
                                    ForSubtype,
                                ForID,
                                ForBatchName,
                                ForProdOrderLine,
                                ForRefNo,
                                ForQtyPerUOM,
                                SerialNo,
                                LotNo
            );*/
        end;
        cduCreateReservEntry.CreateEntry(
            ItemNo,//"Item No.",
            VariantCode,
            LocationCode,//"Location Code",
            txtDescription,//''Description,
            RcptDate,
            ShpDate,//"Shipment Date",
            0,
            ResStatus);
        if SerialNo <> '' then begin
            recSerialNoInfo.Init();
            recSerialNoInfo."Item No." := ItemNo;
            recSerialNoInfo."Serial No." := SerialNo;
            recSerialNoInfo.BBXKey := "Key";
            recSerialNoInfo."BBXTest Date" := "Test Date";
            recSerialNoInfo."BBXIO Board Firmware" := "IO Board Firmware";
            recSerialNoInfo."BBX BootFile" := Format("Bootfile Number");
            recSerialNoInfo."BBX Customer ID" := "Customer ID";
            if RecLItem.Get(ItemNo) then
                recSerialNoInfo.Description := RecLItem.Description;
            if recSerialNoInfo.Insert(true) then;
        end;
        if LotNo <> '' then begin
            recLotNoInfo.Init();
            recLotNoInfo."Item No." := ItemNo;
            recLotNoInfo."Lot No." := LotNo;
            /*
            recLotNoInfo.BBSKey := "Key";
            recLotNoInfo."BBSTest Date" := "Test Date";
            recLotNoInfo."BBSIO Board Firmware" := "IO Board Firmware";
            */
            if recLotNoInfo.Insert(true) then;

        end;
    end;
    /*
    procedure CreateEntry(var InsertReservEntry: Record "Reservation Entry"; ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; Description: Text[100]; ExpectedReceiptDate: Date; ShipmentDate: Date; TransferredFromEntryNo: Integer; Status: Enum "Reservation Status")
    var
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ReservMgt: Codeunit "Reservation Management";
        TrackingSpecificationExists: Boolean;
        FirstSplit: Boolean;
    begin
        TempTrkgSpec1.Reset();
        TempTrkgSpec2.Reset();
        TempTrkgSpec1.DeleteAll();
        TempTrkgSpec2.DeleteAll();

        // Status Surplus gets special treatment.

        if Status < Status::Surplus then
            if InsertReservEntry."Quantity (Base)" = 0 then
                exit;

        InsertReservEntry.TestField("Source Type");

        ReservEntry := InsertReservEntry;
        ReservEntry."Reservation Status" := Status;
        ReservEntry."Item No." := ItemNo;
        ReservEntry."Variant Code" := VariantCode;
        ReservEntry."Location Code" := LocationCode;
        ReservEntry.Description := Description;
        ReservEntry."Creation Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry."Expected Receipt Date" := ExpectedReceiptDate;
        ReservEntry."Shipment Date" := ShipmentDate;
        ReservEntry."Transferred from Entry No." := TransferredFromEntryNo;
        ReservEntry.Positive := (ReservEntry."Quantity (Base)" > 0);
        if (ReservEntry."Quantity (Base)" <> 0) and
           ((ReservEntry.Quantity = 0) or (ReservEntry."Qty. per Unit of Measure" <> InsertReservEntry2."Qty. per Unit of Measure"))
        then
            ReservEntry.Quantity := Round(ReservEntry."Quantity (Base)" / ReservEntry."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision);
        if not QtyToHandleAndInvoiceIsSet then begin
            ReservEntry."Qty. to Handle (Base)" := ReservEntry."Quantity (Base)";
            ReservEntry."Qty. to Invoice (Base)" := ReservEntry."Quantity (Base)";
        end;
        ReservEntry."Untracked Surplus" := InsertReservEntry."Untracked Surplus" and not ReservEntry.Positive;


        if Status < Status::Surplus then begin
            InsertReservEntry2.TestField("Source Type");

            ReservEntry2 := ReservEntry;
            ReservEntry2."Quantity (Base)" := -ReservEntry."Quantity (Base)";
            ReservEntry2.Quantity :=
              Round(ReservEntry2."Quantity (Base)" / InsertReservEntry2."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision);
            ReservEntry2."Qty. to Handle (Base)" := -ReservEntry."Qty. to Handle (Base)";
            ReservEntry2."Qty. to Invoice (Base)" := -ReservEntry."Qty. to Invoice (Base)";
            ReservEntry2.Positive := (ReservEntry2."Quantity (Base)" > 0);
            ReservEntry2."Source Type" := InsertReservEntry2."Source Type";
            ReservEntry2."Source Subtype" := InsertReservEntry2."Source Subtype";
            ReservEntry2."Source ID" := InsertReservEntry2."Source ID";
            ReservEntry2."Source Batch Name" := InsertReservEntry2."Source Batch Name";
            ReservEntry2."Source Prod. Order Line" := InsertReservEntry2."Source Prod. Order Line";
            ReservEntry2."Source Ref. No." := InsertReservEntry2."Source Ref. No.";
            ReservEntry2.CopyTrackingFromreservEntry(InsertReservEntry2);
            ReservEntry2."Qty. per Unit of Measure" := InsertReservEntry2."Qty. per Unit of Measure";
            ReservEntry2."Untracked Surplus" := InsertReservEntry2."Untracked Surplus" and not ReservEntry2.Positive;



            if not QtyToHandleAndInvoiceIsSet then begin
                ReservEntry2."Qty. to Handle (Base)" := ReservEntry2."Quantity (Base)";
                ReservEntry2."Qty. to Invoice (Base)" := ReservEntry2."Quantity (Base)";
            end;

            ReservEntry2.ClearApplFromToItemEntry;

            if Status = Status::Reservation then
                if TransferredFromEntryNo = 0 then begin
                    ReservMgt.MakeRoomForReservation(ReservEntry2);
                    TrackingSpecificationExists :=
                      ReservMgt.CollectTrackingSpecification(TempTrkgSpec2);
                end;
            CheckValidity(ReservEntry2);
            AdjustDateIfItemLedgerEntry(ReservEntry2);
        end;

        ReservEntry.ClearApplFromToItemEntry;

        CheckValidity(ReservEntry);
        AdjustDateIfItemLedgerEntry(ReservEntry);
        if Status = Status::Reservation then
            if TransferredFromEntryNo = 0 then begin
                ReservMgt.MakeRoomForReservation(ReservEntry);
                TrackingSpecificationExists := TrackingSpecificationExists or
                  ReservMgt.CollectTrackingSpecification(TempTrkgSpec1);
            end;

        if TrackingSpecificationExists then
            SetupSplitReservEntry(ReservEntry, ReservEntry2);



        FirstSplit := true;
        while SplitReservEntry(ReservEntry, ReservEntry2, TrackingSpecificationExists, FirstSplit) do begin
            ReservEntry."Entry No." := 0;
            ReservEntry.UpdateItemTracking;

            ReservEntry.Insert();

            if Status < Status::Surplus then begin
                ReservEntry2."Entry No." := ReservEntry."Entry No.";

                ReservEntry2.UpdateItemTracking();

                ReservEntry2.Insert();

            end;
        end;

        LastReservEntry := ReservEntry;

        Clear(InsertReservEntry);
        Clear(InsertReservEntry2);
        Clear(QtyToHandleAndInvoiceIsSet);


    end;
    */
}