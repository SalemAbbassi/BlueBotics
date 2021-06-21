pageextension 50200 "BBX CustomerCardExt" extends "Customer Card"
{
    layout
    {
        modify("EORI Number")
        {
            Visible = false;
            Enabled = false;
        }
        addafter("Salesperson Code")
        {

            field("BBX EORI Number"; Rec."BBX EORI Number")
            {
                ApplicationArea = All;
            }
            field("BBX IOSS"; Rec."BBX IOSS")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            field("BBX Partner "; Rec."BBX Partner")
            {
                ApplicationArea = All;
            }
            field("BBX Transport OrganizedBy Cust."; Rec."BBX Transport OrganizedBy Cust.")
            {
                ApplicationArea = All;
            }
            field("BBX Project Manager"; Rec."BBXProject Manager")
            {
                ApplicationArea = all;
            }
            field("BBX Pilot"; Rec."BBX Pilot")
            {
                ApplicationArea = All;
            }
            field("BBX Standard Text Code"; Rec."BBX Standard Text Code")
            {
                ApplicationArea = All;
            }
            //<<VTE-Gap04
            field("BBX Invoicing Contact No."; Rec."BBX Invoicing Contact No.")
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact Name"; Rec."BBX Invoicing Contact Name")
            {
                ApplicationArea = All;
            }
            field("BBX  Invoicing Contact"; Rec."BBX Invoicing Contact")
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
            field("BBX  Logistics Contact"; Rec."BBX Logistics Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf. No."; Rec."BBX Contact Order Conf. No.")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf. Name"; Rec."BBX Contact Order Conf. Name")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf. Email"; Rec."BBX Contact Order Conf. Email")
            {
                ApplicationArea = All;
            }
            field("BBX Sticker Code"; Rec."BBX Sticker Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Service Code")
        {
            field("BBX Courier Account"; Rec."BBX Courier Account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("BBX EUR.1 Enum"; Rec."BBX EUR.1 Enum")
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {

            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
    var
        BooGIsNewRecord: Boolean;
        LblGCheckCurrencyCode: Label 'Please verify the Currecy Code!';

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction IN [Action::OK, Action::LookupOK] then
            rec.CheckMandatoryFields();
        if BooGIsNewRecord then
            Message(LblGCheckCurrencyCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."BBX Pilot" := true;
        BooGIsNewRecord := true;
    end;

}