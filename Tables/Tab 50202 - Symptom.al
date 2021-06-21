table 50202 "BBX Symptom"
{
    Caption = 'Sypmtom Codes';
    DataCaptionFields = "Service Order No.", Code;
    LookupPageId = "Symptom Codes";

    fields
    {
        field(1; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            TableRelation = "Service Header"."No.";
        }
        field(2; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Descrption; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Service Order No.", Code)
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