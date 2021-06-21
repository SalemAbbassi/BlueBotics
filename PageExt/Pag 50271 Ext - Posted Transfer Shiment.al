pageextension 50271 "BBX Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        addlast(General)
        {
            field("BBX Parcel 1 Size"; Rec."BBX Parcel 1 Size")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 1 Weight"; Rec."BBX Parcel 1 Weight")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 2 Size"; Rec."BBX Parcel 2 Size")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 2 Weight"; Rec."BBX Parcel 2 Weight")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 3 Size"; Rec."BBX Parcel 3 Size")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 3 Weight"; Rec."BBX Parcel 3 Weight")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 4 Size"; Rec."BBX Parcel 4 Size")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BBX Parcel 4 Weight"; Rec."BBX Parcel 4 Weight")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(Shipment)
        {

            field("BBX Package Tracking No."; Rec."BBX Package Tracking No.")
            {
                ToolTip = 'Specifies the value of the Package Tracking No. field';
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5744),
                              "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(ReportEUR1)
            {
                ApplicationArea = All;
                Caption = 'EUR1';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = True;
                RunObject = Report "BBX Posted Transfer EUR. 1";
            }

            action("BBX Proforma")
            {
                ApplicationArea = All;
                Caption = 'Proforma';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = True;

                trigger OnAction()
                var
                    RePLProformaTransfer: Report "BBX Proforma Transfer";
                    RecLTransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    RecLTransferShipmentHeader.SetRange("No.", Rec."No.");
                    RecLTransferShipmentHeader.SetRange("Transfer-from Code", Rec."Transfer-from Code");
                    RecLTransferShipmentHeader.SetRange("Transfer-to Code", Rec."Transfer-to Code");
                    RePLProformaTransfer.SetTableView(RecLTransferShipmentHeader);
                    RePLProformaTransfer.RunModal();
                end;
            }
        }
        addfirst(processing)
        {
            action("Update Document")
            {
                ApplicationArea = Suite;
                Caption = 'Update Document';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add new information that is relevant to the document, such as information from the shipping agent. You can only edit a few fields because the document has already been posted.';

                trigger OnAction()
                var
                    PostedtransferShipmentUpdate: Page "Posted Transfer Ship. - Update";
                begin
                    PostedtransferShipmentUpdate.LookupMode := true;
                    PostedtransferShipmentUpdate.SetRec(Rec);
                    PostedtransferShipmentUpdate.RunModal;
                end;
            }
        }
    }
}