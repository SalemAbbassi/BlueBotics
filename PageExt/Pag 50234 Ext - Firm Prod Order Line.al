pageextension 50234 "BBX Firm Prod Order Line" extends "Firm Planned Prod. Order Lines"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field(BBXKey; Rec.BBXKey) { ApplicationArea = all; }
            field("BBXTest Date"; Rec."BBXTest Date") { ApplicationArea = all; }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}