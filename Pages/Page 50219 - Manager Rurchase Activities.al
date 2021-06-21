page 50219 "BBX Manager Purchase Activ."
{
    Caption = 'Purchase Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Purchase)
            {
                field("DBE PO All"; Rec."BBX PO All")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecLPurchaseHeader: Record "Purchase Header";
                        PagLPurchaseOrderList: Page "Purchase Order List";
                    begin
                        RecLPurchaseHeader.SetRange("Document Type", RecLPurchaseHeader."Document Type"::Order);
                        PagLPurchaseOrderList.SetTableView(RecLPurchaseHeader);
                        PagLPurchaseOrderList.LookupMode(true);
                        PagLPurchaseOrderList.RunModal();
                    end;
                }
                field("DBE PO Pending Approval"; Rec."BBX PO Pending Approval")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecLPurchaseHeader: Record "Purchase Header";
                        PagLPurchaseOrderList: Page "Purchase Order List";
                    begin
                        RecLPurchaseHeader.SetRange("Document Type", RecLPurchaseHeader."Document Type"::Order);
                        RecLPurchaseHeader.SetRange(Status, RecLPurchaseHeader.Status::"Pending Approval");
                        PagLPurchaseOrderList.SetTableView(RecLPurchaseHeader);
                        PagLPurchaseOrderList.LookupMode(true);
                        PagLPurchaseOrderList.RunModal();
                    end;
                }
                field("DBE PO Not Sent Yet"; Rec."BBX PO Not Sent Yet")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecLPurchaseHeader: Record "Purchase Header";
                        PagLPurchaseOrderList: Page "Purchase Order List";
                    begin
                        RecLPurchaseHeader.SetRange("Document Type", RecLPurchaseHeader."Document Type"::Order);
                        RecLPurchaseHeader.SetRange(BBXSentByMail, false);

                        PagLPurchaseOrderList.SetTableView(RecLPurchaseHeader);
                        PagLPurchaseOrderList.LookupMode(true);
                        PagLPurchaseOrderList.RunModal();
                    end;
                }
                field("DBE PO Partially Received"; Rec."BBX PO Partially Received")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecLPurchaseHeader: Record "Purchase Header";
                        PagLPurchaseOrderList: Page "Purchase Order List";
                    begin
                        RecLPurchaseHeader.SetRange("Document Type", RecLPurchaseHeader."Document Type"::Order);
                        RecLPurchaseHeader.SetRange(Receive, true);
                        RecLPurchaseHeader.SetRange("Completely Received", false);
                        PagLPurchaseOrderList.SetTableView(RecLPurchaseHeader);
                        PagLPurchaseOrderList.LookupMode(true);
                        PagLPurchaseOrderList.RunModal();
                    end;
                }
                field("DBE PO Not Received"; Rec."BBX PO Not Received")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecLPurchaseHeader: Record "Purchase Header";
                        PagLPurchaseOrderList: Page "Purchase Order List";
                    begin
                        RecLPurchaseHeader.SetRange("Document Type", RecLPurchaseHeader."Document Type"::Order);
                        RecLPurchaseHeader.SetRange(Receive, false);
                        PagLPurchaseOrderList.SetTableView(RecLPurchaseHeader);
                        PagLPurchaseOrderList.LookupMode(true);
                        PagLPurchaseOrderList.RunModal();
                    end;
                }
            }
        }
    }
}