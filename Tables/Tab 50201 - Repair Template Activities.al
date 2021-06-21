table 50201 "BBX Repair Template Activities"
{
    Caption = 'Repair Template Activities';
    DataCaptionFields = "Repair Template Code";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Repair Template Code"; Code[20])
        {
            Caption = 'Repair Template Code';
            TableRelation = "BBX Repair Template";
        }
        field(3; Type; Enum "BBX Repair Template Activities Type")
        {
            Caption = 'Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item WHERE
                (Type = FILTER('Inventory|Non-Inventory'), Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST(Cost)) "Service Cost";
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Type = Type::Item then
                    if "Location Code" <> '' then begin
                        GetItem(Item);
                        Item.TestField(Type, Item.Type::Inventory);
                    end;
            end;
        }
        field(7; UOM; Text[50])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price Excl VAT"; Decimal)
        {
            Caption = 'Unit Price Excl VAT';
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

    local procedure GetItem(var Item: Record Item)
    begin
        TestField("No.");
        Item.Get("No.");
    end;
}