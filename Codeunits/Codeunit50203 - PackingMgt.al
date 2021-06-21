codeunit 50203 "BBX PackingMgt"
{
    trigger OnRun()
    begin

    end;

    procedure newPacking()
    var
        recPacking: Record "BBX PackingLine";
        recSalesSetup: record "Sales & Receivables Setup";
        pagPackingCard: Page "BBX PackingDoc";
        cduNoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        recSalesSetup.get;
        recSalesSetup.TestField("BBX PackingNos");
        recPacking.init;
        recPacking.PackingNo := cduNoSeriesMgt.GetNextNo(recSalesSetup."BBX PackingNos", Today(), TRUE);
        recPacking.LineNo := 10000;
        recPacking.Insert(true);
        Commit();
        recPacking.SetFilter(PackingNo, '%1', recPacking.PackingNo);
        pagPackingCard.SetTableView(recPacking);
        pagPackingCard.RunModal();
    end;

    procedure viewPackingList(var p_recPackingTMP: Record "BBX PackingLine" temporary)
    var
        recPacking: Record "BBX PackingLine";
        xcop: code[20];
    begin

        xcop := '-$ùm@ççè^l';
        p_recPackingTMP.DeleteAll();
        recPacking.SetCurrentKey(PackingNo);
        //Message(p_codPackingNo);
        if recPacking.FindSet() then begin
            //Message(Format(recPacking.Count()));
            repeat
                //Message(p_codPackingNo + ' - lopop');
                if xcop <> recPacking.PackingNo then begin
                    xcop := recPacking.PackingNo;
                    p_recPackingTMP.TransferFields(recPacking);
                    p_recPackingTMP.TotalBoxWeight := recPacking.WeightLine;
                    p_recPackingTMP.Insert();
                end
                else begin
                    p_recPackingTMP.TotalBoxWeight += recPacking.WeightLine;
                    p_recPackingTMP.Modify();
                end;
            until recPacking.Next() = 0;
        end;
    end;

    procedure openPacking(p_codPackingNo: code[20])
    var
        recPacking: Record "BBX PackingLine";
        pagPackingCard: Page "BBX PackingDoc";
    begin
        recPacking.SetFilter(PackingNo, '%1', p_codPackingNo);
        pagPackingCard.SetTableView(recPacking);
        pagPackingCard.RunModal();
    end;

    procedure printPacking(p_codPackingNo: code[20])
    var
        recPacking: Record "BBX PackingLine";
        repPacking: Report "BBX Packing";
    begin
        recPacking.SetFilter(PackingNo, '%1', p_codPackingNo);
        repPacking.SetTableView(recPacking);
        repPacking.RunModal();
    end;

    procedure updatePaletteNo(var p_recPacking: Record "BBX PackingLine")
    var
        recPacking: Record "BBX PackingLine";
    begin
        recPacking.SetFilter(PackingNo, '%1', p_recPacking.PackingNo);
        recPacking.SetFilter(BoxType, '%1', p_recPacking.BoxType);
        recPacking.SetFilter(BoxNo, '%1', p_recPacking.BoxNo);
        if recPacking.FindSet() then begin
            recPacking.ModifyAll(PaletteType, p_recPacking.PaletteType);
            recPacking.ModifyAll(PaletteNo, p_recPacking.PaletteNo);

        end;

    end;

    procedure getExistingPaletteNo(var p_recPacking: Record "BBX PackingLine"): Code[20]
    var
        recPacking: Record "BBX PackingLine";
    begin
        recPacking.SetFilter(PackingNo, '%1', p_recPacking.PackingNo);
        recPacking.SetFilter(BoxType, '%1', p_recPacking.BoxType);
        recPacking.SetFilter(BoxNo, '%1', p_recPacking.BoxNo);
        recPacking.SetFilter(PaletteNo, '<>%1', '');
        if recPacking.FindSet() then
            exit(recPacking.PaletteNo);
    end;

    var
        myInt: Integer;


}