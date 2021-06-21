pageextension 50238 BBXPurchaseOrderListExt extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {

            field("BBX SentByMail"; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }
            field(BBXConfirmationReceived; Rec.BBXConfirmationReceived)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify(Send)
        {
            trigger OnBeforeAction()
            begin
                if Rec.BBXSentByMail then
                    exit;
            end;
        }
        addafter(Print)
        {
            action("BBX Purchase Order Draft")
            {
                Caption = 'Purchase Order Draft';
                Image = Print;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    RecLPurchaseHeader: Record "Purchase Header";
                    RepLPurchaseDraft: Report "BBX Purchase Order Draft";
                begin
                    RecLPurchaseHeader.SetRange("No.", Rec."No.");
                    RecLPurchaseHeader.SetRange("Document Type", Rec."Document Type");
                    RepLPurchaseDraft.SetTableView(RecLPurchaseHeader);
                    RepLPurchaseDraft.RunModal();
                end;

            }
        }
    }
}