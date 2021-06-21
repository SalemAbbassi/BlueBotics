pageextension 50252 BBXBlanketPurchaseOrder extends "Blanket Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field(BBXDescription; Rec.BBXDescription)
            {
                ApplicationArea = All;
            }

            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }

            field(BBXConfirmationReceived; Rec.BBXConfirmationReceived)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action(SendCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    if Rec.BBXSentByMail then
                        exit;
                    PurchaseHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchaseHeader);
                    PurchaseHeader.SendRecords;
                end;
            }
        }
    }
}