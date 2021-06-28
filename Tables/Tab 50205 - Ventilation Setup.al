table 50205 "BBX Ventilation Setup"
{
    Caption = 'Ventilation Setup';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            Editable = false;
            trigger OnValidate()
            var
                RecLItem: Record Item;
            begin
                if RecLItem.Get("Item No.") then
                    Rec.Validate(Description, RecLItem.Description);
            end;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(4; "Ventilation %"; Integer)
        {
            Caption = 'Ventilation %';
            trigger OnValidate()
            begin
                if "Ventilation %" = 0 then
                    exit;
                CheckVentilationPercentage();
            end;
        }
        field(5; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure CheckVentilationPercentage()
    var
        RecLVentilationSetup: Record "BBX Ventilation Setup";
        IntLVentilationPercentage: Integer;
        CstLPercentageError: Label 'The ventilation % total can not exceed 100';
    begin
        RecLVentilationSetup.SetRange("Item No.", Rec."Item No.");
        if RecLVentilationSetup.FindSet() then
            repeat
                IntLVentilationPercentage += RecLVentilationSetup."Ventilation %";
            until RecLVentilationSetup.Next() = 0;
        if IntLVentilationPercentage + "Ventilation %" > 100 then
            Error(CstLPercentageError);
    end;
}