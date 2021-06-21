pageextension 50241 "BBX Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter(Status)
        {
            field("BBX PO Count"; Rec."BBX PO Count")
            {
                ApplicationArea = All;
            }
            field("BBX Firm Planned PO"; Rec."BBX Firm Planned PO")
            {
                ApplicationArea = All;
            }
            field("BBX Released PO"; Rec."BBX Released PO")
            {
                ApplicationArea = All;
            }
            field("BBX Finished PO"; Rec."BBX Finished PO")
            {
                ApplicationArea = All;
            }
            field("BBX CodOpenWarehouseNo"; Rec.GetOpenWarehouseShipmentNo)
            {
                ApplicationArea = all;
                Caption = 'Open Warehouse Shipment No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
                    PagLWhseShipList: Page "Warehouse Shipment List";
                begin

                    //  if RecLWarehouseShipmentHeader.Get(GetOpenWarehouseShipmentNo()) then begin
                    RecLWarehouseShipmentHeader.FilterGroup(2);
                    RecLWarehouseShipmentHeader.SetRange("No.", Rec.GetOpenWarehouseShipmentNo());
                    RecLWarehouseShipmentHeader.FilterGroup(0);
                    if RecLWarehouseShipmentHeader.FindSet() then begin
                        PagLWhseShipList.LookupMode(true);
                        PagLWhseShipList.SetTableView(RecLWarehouseShipmentHeader);
                        PagLWhseShipList.RunModal();
                    end;
                end;
            }
            field("BBX Project Manager"; "BBX Project Manager")
            {
                ApplicationArea = all;
            }
            field("BBX CodReleasedWarehouseNo"; Rec.GetReleasedWarehouseShipmentNo)
            {
                ApplicationArea = all;
                Caption = 'Released Warehouse Shipment No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
                    PagLWhseShipList: Page "Warehouse Shipment List";
                begin
                    //if RecLWarehouseShipmentHeader.Get(GetReleasedWarehouseShipmentNo()) then begin
                    RecLWarehouseShipmentHeader.FilterGroup(2);
                    RecLWarehouseShipmentHeader.SetRange("No.", Rec.GetReleasedWarehouseShipmentNo());
                    RecLWarehouseShipmentHeader.FilterGroup(0);
                    if RecLWarehouseShipmentHeader.FindSet() then begin
                        PagLWhseShipList.LookupMode(true);
                        PagLWhseShipList.SetTableView(RecLWarehouseShipmentHeader);
                        PagLWhseShipList.RunModal();
                    end;
                end;
            }
            field("BBX CodWarehouseNo"; Rec.GetWarehouseShipmentNo)
            {
                ApplicationArea = all;
                Caption = 'Warehouse Shipment No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
                    PagLWhseShipList: Page "Warehouse Shipment List";
                begin
                    //  if RecLWarehouseShipmentHeader.Get(GetWarehouseShipmentNo()) then begin
                    RecLWarehouseShipmentHeader.FilterGroup(2);
                    RecLWarehouseShipmentHeader.SetRange("No.", Rec.GetWarehouseShipmentNo());
                    RecLWarehouseShipmentHeader.FilterGroup(0);
                    if RecLWarehouseShipmentHeader.FindSet() then begin
                        PagLWhseShipList.LookupMode(true);
                        PagLWhseShipList.SetTableView(RecLWarehouseShipmentHeader);
                        PagLWhseShipList.RunModal();
                    end;
                end;
            }
            field("BBX CodPostedWarehouseNo"; Rec.GetPostedWhseShipmentNo())
            {
                ApplicationArea = all;
                Caption = 'Posted Warehouse Shipment No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    RecLPostedWhsShptHeader: Record "Posted Whse. Shipment Header";
                    PagLPostedWhseShipList: Page "Posted Whse. Shipment List";
                begin
                    //  if RecLPostedWhsShptHeader.Get(GetPostedWhseShipmentNo()) then begin
                    RecLPostedWhsShptHeader.FilterGroup(2);
                    RecLPostedWhsShptHeader.SetRange("No.", Rec.GetPostedWhseShipmentNo());
                    RecLPostedWhsShptHeader.FilterGroup(0);
                    if RecLPostedWhsShptHeader.FindSet() then begin
                        PagLPostedWhseShipList.LookupMode(true);
                        PagLPostedWhseShipList.SetTableView(RecLPostedWhsShptHeader);
                        PagLPostedWhseShipList.RunModal();
                    end;
                end;
            }
            field("BBX Prepayment %"; Rec."Prepayment %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {

            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BBX Expected Delivery Date"; Rec."BBX Expected Delivery Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amount Including VAT")
        {
            field("Invoiced Amount"; Rec.GetOrderInvoicedAmount())
            {
                ApplicationArea = All;
                Caption = 'Invoiced Amount';
            }
        }
        addafter("External Document No.")
        {
            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ToolTip = 'Specifies the value of the Sent by Mail field';
                ApplicationArea = All;
            }
        }
    }
    /*trigger OnAfterGetRecord()
    begin
        //Rec.SetCurrentKey("Document Type", "No.");
        //Rec.SetAscending("No.", false);
    end;

    trigger OnOpenPage()
    begin
        //Rec.FindLast();

        Rec.SetCurrentKey("Document Type", "No.");
        Rec.SetAscending("No.", false);
        if Rec.FindSet() then;
    end;*/
    actions
    {
        addafter("Print Confirmation")
        {
            action("BBX Draft")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Draft';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category8;
                trigger OnAction()
                var
                    RecLSalesHeader: Record "Sales Header";
                    RepLSalesOrderDraft: Report "BBX Sales Order Draft";
                begin
                    RecLSalesHeader.SetRange("Document Type", Rec."Document Type");
                    RecLSalesHeader.SetRange("No.", Rec."No.");
                    RepLSalesOrderDraft.SetTableView(RecLSalesHeader);
                    RepLSalesOrderDraft.RunModal();
                end;
            }
        }
    }
}