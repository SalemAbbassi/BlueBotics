table 50207 "BBX Stickers"
{
    Caption = 'Stickers';
    LookupPageId = "BBX Stickers List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Type; Enum "BBX Stickers Type")
        {
            Caption = 'Type';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; Code)
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

}