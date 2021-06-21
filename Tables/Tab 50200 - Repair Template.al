table 50200 "BBX Repair Template"
{
    Caption = 'Repair Template';
    DataCaptionFields = "Repair Template Code", "Repair Template Description";

    fields
    {
        field(1; "Repair Template Code"; Code[20])
        {
            Caption = 'Repair Template Code';
        }
        field(2; "Repair Template Description"; Text[100])
        {
            Caption = 'Repair Template Description';
        }
    }

    keys
    {
        key(PK; "Repair Template Code")
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

}