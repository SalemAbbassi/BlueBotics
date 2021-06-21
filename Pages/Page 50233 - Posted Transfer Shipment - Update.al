page 50233 "Posted Transfer Ship. - Update"
{
    Caption = 'Posted Transfer Shipment - Update';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Transfer Shipment Header";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the record.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Agent';
                    Editable = true;
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Agent Service';
                    Editable = true;
                    ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
                }
            }
            group(Packing)
            {
                Caption = 'Packaging';

                field("BBX Parcel 1 Size"; Rec."BBX Parcel 1 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 2 Size"; Rec."BBX Parcel 2 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 3 Size"; Rec."BBX Parcel 3 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 4 Size"; Rec."BBX Parcel 4 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 1 Weight"; Rec."BBX Parcel 1 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 2 Weight"; Rec."BBX Parcel 2 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 3 Weight"; Rec."BBX Parcel 3 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 4 Weight"; Rec."BBX Parcel 4 Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        xTransferShipmentHeader := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RecLTransferShipmentHeader: Record "Transfer Shipment Header";
    begin
        if CloseAction = ACTION::LookupOK then
            if RecordChanged then begin
                RecLTransferShipmentHeader := Rec;
                RecLTransferShipmentHeader.LockTable();
                RecLTransferShipmentHeader.Find;
                RecLTransferShipmentHeader."Shipping Agent Code" := Rec."Shipping Agent Code";
                RecLTransferShipmentHeader."Shipping Agent Service Code" := Rec."Shipping Agent Service Code";
                RecLTransferShipmentHeader.TestField("No.", Rec."No.");
                RecLTransferShipmentHeader."BBX Parcel 1 Size" := Rec."BBX Parcel 1 Size";
                RecLTransferShipmentHeader."BBX Parcel 2 Size" := Rec."BBX Parcel 2 Size";
                RecLTransferShipmentHeader."BBX Parcel 3 Size" := Rec."BBX Parcel 3 Size";
                RecLTransferShipmentHeader."BBX Parcel 4 Size" := Rec."BBX Parcel 4 Size";
                RecLTransferShipmentHeader."BBX Parcel 1 Weight" := Rec."BBX Parcel 1 Weight";
                RecLTransferShipmentHeader."BBX Parcel 2 Weight" := Rec."BBX Parcel 2 Weight";
                RecLTransferShipmentHeader."BBX Parcel 3 Weight" := Rec."BBX Parcel 3 Weight";
                RecLTransferShipmentHeader."BBX Parcel 4 Weight" := Rec."BBX Parcel 4 Weight";
                RecLTransferShipmentHeader.Modify();
                Rec := RecLTransferShipmentHeader;
            end;
    end;

    var
        xTransferShipmentHeader: Record "Transfer Shipment Header";

    local procedure RecordChanged() IsChanged: Boolean
    begin
        IsChanged :=
          (Rec."Shipping Agent Code" <> xTransferShipmentHeader."Shipping Agent Code") or
          (Rec."Shipping Agent Service Code" <> xTransferShipmentHeader."Shipping Agent Service Code") or
          (Rec."BBX Parcel 1 Size" <> xTransferShipmentHeader."BBX Parcel 1 Size") or
          (Rec."BBX Parcel 2 Size" <> xTransferShipmentHeader."BBX Parcel 2 Size") or
          (Rec."BBX Parcel 3 Size" <> xTransferShipmentHeader."BBX Parcel 3 Size") or
          (Rec."BBX Parcel 4 Size" <> xTransferShipmentHeader."BBX Parcel 4 Size") or
          (Rec."BBX Parcel 1 Weight" <> xTransferShipmentHeader."BBX Parcel 1 Weight") or
          (Rec."BBX Parcel 2 Weight" <> xTransferShipmentHeader."BBX Parcel 2 Weight") or
          (Rec."BBX Parcel 3 Weight" <> xTransferShipmentHeader."BBX Parcel 3 Weight") or
          (Rec."BBX Parcel 4 Weight" <> xTransferShipmentHeader."BBX Parcel 4 Weight");
    end;

    procedure SetRec(TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        Rec := TransferShipmentHeader;
        Rec.Insert;
    end;
}

