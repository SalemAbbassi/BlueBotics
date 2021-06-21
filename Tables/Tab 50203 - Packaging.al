table 50203 "BBX Packaging"
{
    Caption = 'Packaging';
    fields
    {
        field(1; TypePackaging; Option)
        {
            //CaptionML = ENU = 'Type', FRA = 'Type', FRS ='Type';
            Caption = 'Type';
            OptionCaption = 'Palette,Box,Parcel,Envelope';
            OptionMembers = "Palette","Box","Parcel","Envelope";
            //OptionCaptionML = ENU = 'Palette,Box,Parcel', FRA = 'Palette,Caisse,Carton',FRS = 'Palette,Caisse,Carton';            
        }
        field(2; CodePackaging; code[20])
        {
            Caption = 'Code';

        }
        field(10; Weight; Decimal)
        {
            Caption = 'Weight';

        }
        field(11; Size; Text[50])
        {
            Caption = 'Size';

        }
    }

    keys
    {
        key(PK; TypePackaging, CodePackaging)
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