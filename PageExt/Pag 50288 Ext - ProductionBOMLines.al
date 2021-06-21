pageextension 50288 "BBX Production BOM Lines" extends "Production BOM Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("BBX Service Item Creation"; Rec."BBX Service Item Creation")
            {
                ToolTip = 'Specifies the value of the Service Item Creation field';
                ApplicationArea = All;
            }

            field("BBX Vendor No."; Rec."BBX Vendor No.")
            {
                ToolTip = 'Specifies the value of the Vendor No. field';
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    RecLVendor: Record Vendor;
                    PagLVendorList: Page "Vendor List";
                begin
                    Rec.CalcFields("BBX Vendor No.");
                    RecLVendor.SetRange("No.", Rec."BBX Vendor No.");
                    PagLVendorList.SetTableView(RecLVendor);
                    PagLVendorList.LookupMode(true);
                    PagLVendorList.RunModal();
                end;
            }
            field("BBX Vendor Name"; Rec.GetVendorName())
            {
                Caption = 'Vendor Name';
                ToolTip = 'Specifies the value of the Vendor Name field';
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    RecLVendor: Record Vendor;
                    PagLVendorList: Page "Vendor List";
                begin
                    Rec.CalcFields("BBX Vendor No.");
                    RecLVendor.SetRange("No.", Rec."BBX Vendor No.");
                    PagLVendorList.SetTableView(RecLVendor);
                    PagLVendorList.LookupMode(true);
                    PagLVendorList.RunModal();
                end;
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