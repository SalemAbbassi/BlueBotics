pageextension 50202 "BBX PostedSalesShipmentExt" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("BBX Invoicing Contact"; Rec."BBX Invoicing Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact"; Rec."BBX Logistics Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 1 Size"; Rec."BBX Parcel 1 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 1 Weight"; Rec."BBX Parcel 1 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 2 Size"; Rec."BBX Parcel 2 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 2 Weight"; Rec."BBX Parcel 2 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 3 Size"; Rec."BBX Parcel 3 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 3 Weight"; Rec."BBX Parcel 3 Weight")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 4 Size"; Rec."BBX Parcel 4 Size")
            {
                ApplicationArea = All;
            }
            field("BBX Parcel 4 Weight"; Rec."BBX Parcel 4 Weight")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part("BBX Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(110),
                              "No." = FIELD("No.");
            }
        }
        addafter("Shipment Date")
        {

            field("BBX Courier Account"; Rec."BBX Courier Account")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action("BBX DocAttach")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
        }
        addafter("&Print")
        {
            action("BBX Proforma")
            {
                ApplicationArea = All;
                Caption = 'Proforma';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    RePLProformaInvoice: Report "BBX Proforma Invoice";
                    RecLSalesShipmentHeader: Record "Sales Shipment Header";
                begin
                    RecLSalesShipmentHeader.SetRange("No.", Rec."No.");
                    RecLSalesShipmentHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    RePLProformaInvoice.SetTableView(RecLSalesShipmentHeader);
                    RePLProformaInvoice.RunModal();
                end;
            }
            action("BBX AttachAsPDF")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach as PDF';
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Create a PDF file and attach it to the document.';

                trigger OnAction()
                var
                    RecLSalesShipmentHeader: Record "Sales Shipment Header";
                    CduLBlueBoticsFctMgt: Codeunit "BBX Function Mgt";
                begin
                    RecLSalesShipmentHeader := Rec;
                    CurrPage.SetSelectionFilter(RecLSalesShipmentHeader);
                    CduLBlueBoticsFctMgt.PrintSalesShipmentHeaderToDocumentAttachment(RecLSalesShipmentHeader);
                end;
            }
        }
    }

}