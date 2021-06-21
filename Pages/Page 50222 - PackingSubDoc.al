page 50222 "BBX PackingSubDoc"
{
    PageType = ListPart;
    //ApplicationArea = All;
    SourceTable = "BBX PackingLine";
    SourceTableTemporary = true;
    //UsageCategory = None;
    //AccessByPermission = page PackingSubList = X;
    Caption = 'Packing Sub Document';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(BoxType; Rec.BoxType)
                {
                    ApplicationArea = All;

                }
                field(BoxNo; Rec.BoxNo)
                {
                    ApplicationArea = All;

                }
                field(TotalBoxWeight; Rec.TotalBoxWeight)
                {
                    ApplicationArea = all;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = all;
                }
                field(PaletteType; Rec.PaletteType)
                {
                    ApplicationArea = all;
                }
                field(PaletteNo; Rec.PaletteNo)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        cduPackingMgt: Codeunit "BBX PackingMgt";
                    begin
                        cduPackingMgt.updatePaletteNo(Rec);
                    end;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    /*
    trigger OnFindRecord(Which : text) : Boolean
    var
        myInt: Integer;
    begin
        
    end;

    trigger OnNextRecord(Steps : Integer) : Integer;
    var
        myInt: Integer;
    begin
        
    end;
    */
    procedure refreshData(p_codPackingNo: code[20])
    var
        recPacking: Record "BBX PackingLine";
        xcop: code[20];
    begin


        xcop := '-$ùm@ççè^l';
        rec.DeleteAll();
        recPacking.SetCurrentKey(PackingNo, BoxType, BoxNo);
        recPacking.SetFilter(PackingNo, '%1', p_codPackingNo);
        //Message(p_codPackingNo);
        if recPacking.FindSet() then begin
            //Message(Format(recPacking.Count()));
            repeat
                //Message(p_codPackingNo + ' - lopop');
                if xcop <> (format(recpacking.BoxType) + recPacking.BoxNo) then begin
                    xcop := format(recpacking.BoxType) + recPacking.BoxNo;
                    rec.TransferFields(recPacking);
                    rec.TotalBoxWeight := recPacking.WeightLine;
                    rec.Insert();
                end
                else begin
                    rec.TotalBoxWeight += recPacking.WeightLine;
                    rec.Modify();
                end;

            until recPacking.Next() = 0;
        end;
        //Message(p_codPackingNo + ' end loop');
        if rec.FindSet() then
            CurrPage.Update(false);

    end;
}