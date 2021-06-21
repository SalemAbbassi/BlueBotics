pageextension 50286 "BBX Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("BBX IOSS"; Rec."BBX IOSS")
            {
                ToolTip = 'Specifies the value of the IOSS field';
                ApplicationArea = All;
            }
        }
    }
}