pageextension 50236 "BBX Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("BBX No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
        addafter(Status)
        {

            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }

            field(BBXConfirmationReceived; Rec.BBXConfirmationReceived)
            {
                ApplicationArea = All;
            }
            field("BBX Expected delivery date"; Rec."BBX Expected delivery date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(SendCustom)
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
                PromotedCategory = Category10;
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

    var
        myInt: Integer;
}