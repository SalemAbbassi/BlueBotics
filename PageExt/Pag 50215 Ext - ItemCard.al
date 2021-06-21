pageextension 50215 "BBX ItemCardExt" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {

            field("BBX No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field("BBX Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("BBX Task Type"; Rec."BBX Task Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor No.")
        {

            field("BBX Vendor Name"; Rec.BBXVendorName)
            {
                ApplicationArea = All;
            }
        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        addlast(Warehouse)
        {
            field("BBX Prevent Negative Inventory"; Rec."Prevent Negative Inventory")
            {
                ApplicationArea = All;
            }

            field("BBX Stockout Warning"; Rec."Stockout Warning")
            {
                ApplicationArea = All;
            }
            field("BBX Inventory Value Zero"; Rec."Inventory Value Zero")
            {
                ApplicationArea = All;
            }
        }
        addlast(Item)
        {
            field(BBXPilot; Rec.BBXPilot)
            {
                ApplicationArea = All;
            }
            field("BBX Automatic Delivery"; Rec."BBX Automatic Delivery")
            {
                ToolTip = 'Specifies the value of the Automatic Delivery field';
                ApplicationArea = All;
                Editable = Rec.Type <> Rec.Type::Inventory;
            }

        }
    }
    actions
    {
        addlast(Functions)
        {
            action("BBX Ventilation Setup")
            {
                Caption = 'Ventilation Setup';
                ApplicationArea = Basic, Suite;
                Image = LogSetup;
                RunObject = page "BBX Ventilation Setup";
                RunPageLink = "Item No." = field("No.");
            }
        }
    }
}