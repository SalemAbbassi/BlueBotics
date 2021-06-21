table 50204 "BBX PackingLine"
{
    Caption = 'Packaging';

    fields
    {
        field(1; PackingNo; Code[20])
        {
            Caption = 'Packing No.';

        }
        field(2; LineNo; Integer)
        {
            Caption = 'Line No.';

        }

        field(10; ShipmentNo; Code[20])
        {
            Caption = 'Shipment No.';
            TableRelation = "Sales Shipment Header";
        }
        field(20; ItemNo; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "Sales Shipment Line"."Line No." WHERE("Type" = const(item),
                                                                    "Document No." = FIELD(ShipmentNo),
                                                                    Quantity = filter('<>0'));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                recSalesShipmentLine: Record "Sales Shipment Line";
                intTMP: Integer;
            begin
                //if Confirm(Format(ItemNo)) then;
                Evaluate(intTMP, ItemNo);
                recSalesShipmentLine.SetFilter("Type", '%1', recSalesShipmentLine.Type::Item);
                recSalesShipmentLine.SetFilter("Document No.", '%1', ShipmentNo);
                //recSalesShipmentLine.SetFilter("No.", '%1', ItemNo);
                recSalesShipmentLine.SetFilter("Line No.", '%1', intTMP);//ItemNo);
                recSalesShipmentLine.FindFirst();
                ItemNo := recSalesShipmentLine."No.";
                ShipmentQty := recSalesShipmentLine.Quantity;
                Description := recSalesShipmentLine.Description;
                VariantCode := recSalesShipmentLine."Variant Code";
                WeightLine := calculateTotalWeight();
            end;
            /*
            trigger OnLookup()
            var
                recSalesShipmentLine: Record "Sales Shipment Line";
                pagSalesShipmentLine: page "Posted Sales Shipment Lines";
            begin
                recSalesShipmentLine.SetFilter("Type", '%1', recSalesShipmentLine.Type::Item);
                recSalesShipmentLine.SetFilter("Document No.", '%1', ShipmentNo);
                recSalesShipmentLine.FindSet();
                Clear(pagSalesShipmentLine);
                pagSalesShipmentLine.LookupMode(true);
                pagSalesShipmentLine.SetRecord(recSalesShipmentLine);
                pagSalesShipmentLine.SetTableView(recSalesShipmentLine);
                if pagSalesShipmentLine.RunModal() = Action::LookupOK then begin
                    pagSalesShipmentLine.GetRecord(recSalesShipmentLine);
                    ItemNo := recSalesShipmentLine."No.";
                    Description := recSalesShipmentLine.Description;
                    VariantCode := recSalesShipmentLine."Variant Code";
                end;
                
            end;
            */
        }
        field(21; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(22; VariantCode; code[20])
        {
            Caption = 'Variant';
        }
        field(25; Qty; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()

            begin
                WeightLine := calculateTotalWeight();
            end;
        }
        field(30; BoxType; Code[20])
        {
            Caption = 'Box Type';
            TableRelation = "BBX Packaging".CodePackaging;// WHERE (TypePackaging = const (parcel));
            trigger OnValidate()
            var
                cduPackingMgt: Codeunit "BBX PackingMgt";
            begin
                WeightLine := calculateTotalWeight();
                //PaletteNo := cduPackingMgt.getExistingPaletteNo(rec);
            end;
        }
        field(31; Size; Text[50])
        {
            Caption = 'Size';
        }
        field(32; WeightLine; Decimal)
        {
            Caption = 'Total Weight';
        }
        field(33; BoxNo; Code[20])
        {
            Caption = 'Box No.';
        }
        field(35; PaletteType; Code[20])
        {
            Caption = 'Palette type';

            TableRelation = "BBX Packaging".CodePackaging WHERE(TypePackaging = const(Palette));
        }
        field(36; PaletteNo; Code[20])
        {
            Caption = 'Palette No.';

        }
        field(40; TotalBoxWeight; Decimal)
        {
            Caption = 'Total Weight';
        }
        field(50; ShipmentQty; Decimal)
        {
            Caption = 'Shipment Quantity';
        }
    }
    keys
    {
        key(PK; PackingNo, LineNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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

    procedure calculateTotalWeight(): Decimal
    var
        recPackaging: Record "BBX Packaging";
        recItem: Record Item;
    begin
        if not recItem.get(rec.ItemNo) then
            recItem.init;

        if not recPackaging.get(recPackaging.TypePackaging::Parcel, Rec.BoxType) then
            recPackaging.init;

        Rec.Size := recPackaging.Size;
        //rec.Description := recItem.Description;
        exit((recItem."Gross Weight" * Rec.Qty) + recPackaging.Weight);



    end;
}