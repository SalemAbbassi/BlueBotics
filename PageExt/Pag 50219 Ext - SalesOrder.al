pageextension 50219 "BBX SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addafter("Assigned User ID")
        {

            field("BBX Partner"; Rec."BBX Partner")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("BBX Project Manager"; Rec."BBX Project Manager")
            {
                ApplicationArea = All;
            }
        }
        modify("Quote No.")
        {
            ApplicationArea = all;
            Visible = true;
            trigger OnDrillDown()
            var
                pagUpdateQuoteNo: Page "BBX Update Quote No";
            begin
                clear(pagUpdateQuoteNo);
                //pagUpdateQuoteNo.SetCustNo("Sell-to Customer No.");
                if ReC."Quote No." <> '' then
                    pagUpdateQuoteNo.SetQuoteNo(Rec."Quote No.");
                if pagUpdateQuoteNo.RunModal() = Action::Yes then begin
                    Rec."Quote No." := pagUpdateQuoteNo.getInputValue();
                    Rec.Modify(false);
                end;
            end;
        }
        movelast(General; "Quote No.")
        addafter(Status)
        {
            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact No."; Rec."BBX Invoicing Contact No.")
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact Name"; Rec."BBX Invoicing Contact Name")
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact"; Rec."BBX Invoicing Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact No."; Rec."BBX Logistics Contact No.")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact Name"; Rec."BBX Logistics Contact Name")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact"; Rec."BBX Logistics Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf No."; Rec."BBX Contact Order Conf No.")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf Name"; Rec."BBX Contact Order Conf Name")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf Email"; Rec."BBX Contact Order Conf Email")
            {
                ApplicationArea = All;
            }

        }
        addafter("Requested Delivery Date")
        {
            field("BBX Try Buy Ending Date"; Rec."BBX Try Buy Ending Date")
            {
                ApplicationArea = All;
            }
            field("BBX Try Buy Starting Date"; Rec."BBX Try Buy Starting Date")
            {
                ApplicationArea = All;
            }
            field("BBX Expected Delivery Date"; Rec."BBX Expected Delivery Date")
            {
                ApplicationArea = All;
            }

        }
        addlast(General)
        {
            field("BBX Courier Account"; Rec."BBX Courier Account")
            {
                ApplicationArea = All;
            }
            field("BBX Transport OrganizedBy Cust."; Rec."BBX Transport OrganizedBy Cust.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Documents)
        {
            action("BBX S&hipments")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'S&hipments';
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Category12;
                RunObject = Page "BBS Posted Sales Shipments";
                RunPageLink = "Order No." = FIELD("No.");
                RunPageView = SORTING("Order No.");
                ToolTip = 'View related posted sales shipments.';
            }
        }
        modify("S&hipments")
        {
            Visible = false;
        }
        modify("Create &Warehouse Shipment")
        {
            visible = false;
        }
        addafter("Create &Warehouse Shipment")
        {
            action("BBX Create Warehouse Shipment")
            {
                AccessByPermission = TableData "Warehouse Shipment Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create &Warehouse Shipment';
                Image = NewShipment;
                ToolTip = 'Create a warehouse shipment to start a pick a ship process according to an advanced warehouse configuration.';

                trigger OnAction()
                var
                    CduLBlueBoticsFctMg: Codeunit "BBX Function Mgt";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    RecLSalesHEader: Record "Sales Header";
                begin
                    //Rec.FctCreateFromSalesOrder();
                    If Rec.Status = Rec.Status::"Pending Approval" then begin
                        CduLBlueBoticsFctMg.FctCreateWhseRequests(Rec);
                        CduLBlueBoticsFctMg.FctCreateFromSalesOrder(Rec);
                    end
                    else
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                    if not Rec.Find('=><') then
                        Rec.Init;
                end;
            }
        }
        addafter("Print Confirmation")
        {
            action("BBX Draft")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Draft';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category11;
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