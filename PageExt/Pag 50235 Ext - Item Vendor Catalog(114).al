pageextension 50235 "BBX Item Vendor Catalog" extends "Item Vendor Catalog"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor No.")
        {
            field(BBXVendorName; Rec.BBXVendorName)
            {
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field(BBXItemDescription; Rec.BBXItemDescription)
            {
                ApplicationArea = all;

            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}