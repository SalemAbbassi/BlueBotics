page 50260 "BBX Update Dimension"
{
    PageType = Card;
    Caption = 'Update Dimensions';
    ApplicationArea = Basic, Suite;
    UsageCategory = Tasks;
    Permissions = tabledata "G/L Entry" = rm;

    actions
    {
        area(Processing)
        {
            action("DBE Update Dimensions")
            {
                ApplicationArea = All;
                Image = Change;
                Promoted = true;
                Caption = 'Update Dimensions';

                trigger OnAction()
                var
                    RecLGLEntry: Record "G/L Entry";
                    RecLDimSetEntry: Record "Dimension Set Entry";
                begin
                    RecLGLEntry.SetRange("Entry No.", 13880);
                    RecLGLEntry.SetRange("Source Type", RecLGLEntry."Source Type"::Customer);
                    if RecLGLEntry.FindSet() then
                        repeat
                            RecLDimSetEntry.SetFilter("Dimension Set ID", '%1', RecLGLEntry."Dimension Set ID");
                            RecLDimSetEntry.SetFilter("Dimension Code", '%1|%2|%3', 'GEOGRAPHY', 'GROUP', 'SECTOR');
                            if RecLDimSetEntry.Count < 3 then
                                FctUpdateDimensions(RecLGLEntry);
                        until RecLGLEntry.Next() = 0;
                end;
            }
        }
    }
    local procedure FctUpdateDimensions(var RecPGLEntry: Record "G/L Entry")
    var
        TempLDimSetEntry: Record "Dimension Set Entry" temporary;
        RecLDimSetEntry: Record "Dimension Set Entry";
        RecLDefaultDimension: Record "Default Dimension";
        IntLNewDimSetID: Integer;
        CduLDimensionMgt: Codeunit DimensionManagement;
        RecLDimValue: Record "Dimension Value";
        BooLUpdateGroup: Boolean;
        BooLUpdateSector: Boolean;
        BooLUpdateGeography: Boolean;
        CodLSectorCode: Code[20];
        CodLGroupCode: Code[20];
    begin
        BooLUpdateGroup := true;
        BooLUpdateSector := true;
        BooLUpdateGeography := true;

        RecLDimSetEntry.SetFilter("Dimension Set ID", '%1', RecPGLEntry."Dimension Set ID");
        if RecLDimSetEntry.FindSet() then begin
            TempLDimSetEntry.DeleteAll();
            repeat
                TempLDimSetEntry.Init();
                TempLDimSetEntry."Dimension Code" := RecLDimSetEntry."Dimension Code";
                TempLDimSetEntry."Dimension Value Code" := RecLDimSetEntry."Dimension Value Code";
                TempLDimSetEntry."Dimension Value ID" := RecLDimSetEntry."Dimension Value ID";
                TempLDimSetEntry.Insert(false);
                if RecLDimSetEntry."Dimension Code" = 'GEOGRAPHY' then
                    BooLUpdateGeography := false;
                if RecLDimSetEntry."Dimension Code" = 'SECTOR' then
                    BooLUpdateSector := false;
                if RecLDimSetEntry."Dimension Code" = 'GROUP' then
                    BooLUpdateGroup := false;
            until RecLDimSetEntry.Next() = 0;

            RecLDefaultDimension.SetRange("Table ID", 18);
            RecLDefaultDimension.SetRange("No.", RecPGLEntry."Source No.");
            if BooLUpdateGeography then begin
                RecLDefaultDimension.SetRange("Dimension Code", 'GEOGRAPHY');
                if RecLDefaultDimension.FindSet() then begin
                    if RecLDimValue.Get(RecLDefaultDimension."Dimension Code", RecLDefaultDimension."Dimension Value Code") then begin
                        TempLDimSetEntry.Init();
                        TempLDimSetEntry."Dimension Code" := RecLDefaultDimension."Dimension Code";
                        TempLDimSetEntry."Dimension Value Code" := RecLDefaultDimension."Dimension Value Code";
                        TempLDimSetEntry."Dimension Value ID" := RecLDimValue."Dimension Value ID";
                        TempLDimSetEntry.Insert(false);
                    end;
                end;
            end;
            if BooLUpdateGroup then begin
                RecLDefaultDimension.SetRange("Dimension Code", 'GROUP');
                if RecLDefaultDimension.FindSet() then begin
                    if RecLDimValue.Get(RecLDefaultDimension."Dimension Code", RecLDefaultDimension."Dimension Value Code") then begin
                        TempLDimSetEntry.Init();
                        TempLDimSetEntry."Dimension Code" := RecLDefaultDimension."Dimension Code";
                        TempLDimSetEntry."Dimension Value Code" := RecLDefaultDimension."Dimension Value Code";
                        TempLDimSetEntry."Dimension Value ID" := RecLDimValue."Dimension Value ID";
                        TempLDimSetEntry.Insert(false);
                        CodLGroupCode := RecLDefaultDimension."Dimension Value Code";
                    end;
                end;
            end;
            if BooLUpdateSector then begin
                RecLDefaultDimension.SetRange("Dimension Code", 'SECTOR');
                if RecLDefaultDimension.FindSet() then begin
                    if RecLDimValue.Get(RecLDefaultDimension."Dimension Code", RecLDefaultDimension."Dimension Value Code") then begin
                        TempLDimSetEntry.Init();
                        TempLDimSetEntry."Dimension Code" := RecLDefaultDimension."Dimension Code";
                        TempLDimSetEntry."Dimension Value Code" := RecLDefaultDimension."Dimension Value Code";
                        TempLDimSetEntry."Dimension Value ID" := RecLDimValue."Dimension Value ID";
                        TempLDimSetEntry.Insert(false);
                        CodLSectorCode := RecLDefaultDimension."Dimension Value Code";
                    end;
                end;
            end;
            IntLNewDimSetID := CduLDimensionMgt.GetDimensionSetID(TempLDimSetEntry);
            if IntLNewDimSetID <> 0 then begin
                RecPGLEntry."Dimension Set ID" := IntLNewDimSetID;
                if CodLSectorCode <> '' then
                    RecPGLEntry."Global Dimension 1 Code" := CodLSectorCode;
                if CodLGroupCode <> '' then
                    RecPGLEntry."Global Dimension 2 Code" := CodLGroupCode;
                RecPGLEntry.Modify();
            end;
        end;
    end;

}