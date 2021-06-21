tableextension 50256 "BBX Production BOM Line" extends "Production BOM Line"
{
    fields
    {
        field(50200; "BBX Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Vendor No." where("No." = field("No.")));
        }
        field(50201; "BBX Service Item Creation"; Boolean)
        {
            Caption = 'Service Item Creation';
        }
    }
    procedure GetVendorName(): Text[50]
    var
        RecLVendor: Record Vendor;
        TxtLVendorName: Text[50];
    begin
        CalcFields("BBX Vendor No.");
        Clear(TxtLVendorName);
        if RecLVendor.Get("BBX Vendor No.") then
            TxtLVendorName := RecLVendor.Name;
        exit(TxtLVendorName);
    end;
}