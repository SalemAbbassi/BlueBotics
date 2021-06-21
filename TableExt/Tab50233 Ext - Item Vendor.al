tableextension 50233 "BBX Item Vendor" extends "Item Vendor"
{
    fields
    {
        // Add changes to table fields here
        field(50200; BBXVendorName; text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
        field(50201; BBXItemDescription; text[100])
        {
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
    }

    var
        myInt: Integer;
}