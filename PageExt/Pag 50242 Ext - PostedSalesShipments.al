pageextension 50242 "BBX Posted Sales Shipments" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {

            field("DBE Job No."; Rec."DBE Job No.")
            {
                ToolTip = 'Specifies the value of the Job No. field';
                ApplicationArea = All;
            }
            field("DBE Job Description"; Rec."DBE Job Description")
            {
                ToolTip = 'Specifies the value of the Job Description field';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("BBX EUR1")
            {
                ApplicationArea = All;
                Caption = 'EUR1';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "BBX EUR. 1";
            }
        }
        addafter("&Track Package")
        {
            action("BBX NewPacking")
            {
                Caption = 'New Packing';
                ApplicationArea = all;
                Image = NewItemNonStock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    cduPackingMgt: Codeunit "BBX PackingMgt";
                begin
                    cduPackingMgt.newPacking();
                end;

            }
            action("BBX PackingList")
            {
                Caption = 'Packings List';
                ApplicationArea = all;
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "BBX PackingList";
            }
        }
    }

    var
        myInt: Integer;
}