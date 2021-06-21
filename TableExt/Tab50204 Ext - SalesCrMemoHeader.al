tableextension 50204 BBXSalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        //>>VTE-Gap04
        field(50200; "BBX EORI Number"; Code[20])
        {
            Caption = 'EORI Number';
        }
        field(50201; "BBX Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
        }
        field(50202; "BBX Partner "; Boolean)
        {
            Caption = 'Partner';
        }
        field(50203; "BBX Courier Account"; Code[50])
        {
            Caption = 'Courier Account';
            trigger OnValidate()
            begin
                if xRec."BBX Courier Account" <> Rec."BBX Courier Account" then begin
                    if Rec."BBX Courier Account" <> '' then
                        Validate("BBX Transport OrganizedBy Cust.", true)
                    else
                        Validate("BBX Transport OrganizedBy Cust.", false);
                end;
            end;
        }
        //<<VTE-Gap04

        //>>VTE-Gap05
        field(50206; "BBX Proof of export"; Boolean)
        {
            Caption = 'Proof of export';
        }
        field(50207; "BBX EUR1"; Boolean)
        {
            Caption = 'EUR1';
        }
        field(50208; "BBX Shipment received"; Boolean)
        {
            Caption = 'Shipment received';
        }
        //<<VTE-Gap05
        field(50209; "BBX Project Manager"; Code[50])
        {
            Caption = 'Project Manager';
            TableRelation = "User Setup";
        }
        field(50213; BBXSentByMail; Boolean)
        {
            Caption = 'Sent by Mail';
        }
        field(50215; "BBX Parcel 1 Size"; Text[50])
        {
            Caption = 'Parcel 1 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50216; "BBX Parcel 1 Weight"; Decimal)
        {
            Caption = 'Parcel 1 Weight';
        }
        field(50217; "BBX Parcel 2 Size"; Text[50])
        {
            Caption = 'Parcel 2 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50218; "BBX Parcel 2 Weight"; Decimal)
        {
            Caption = 'Parcel 2 Weight';
        }
        field(50219; "BBX Parcel 3 Size"; Text[50])
        {
            Caption = 'Parcel 3 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50220; "BBX Parcel 3 Weight"; Decimal)
        {
            Caption = 'Parcel 3 Weight';
        }
        field(50221; "BBX Parcel 4 Size"; Text[50])
        {
            Caption = 'Parcel 4 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50222; "BBX Parcel 4 Weight"; Decimal)
        {
            Caption = 'Parcel 4 Weight';
        }
        field(50223; "BBX Invoicing Contact"; Text[100])
        {
            Caption = 'Invoicing Contact';
        }
        field(50224; "BBX Logistics Contact"; Text[100])
        {
            Caption = 'Logistics Contact';
        }
        field(50225; "BBX Contact Order Conf No."; Code[20])
        {
            Caption = 'Order Confirmation Contact No.';
            TableRelation = Contact."No.";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                RecLContact: Record Contact;
                RecLContactBusinessRelation: Record "Contact Business Relation";
                RecLCustomer: Record Customer;
                PagLContactList: Page "Contact List";
            begin

                if RecLContactBusinessRelation.FindByRelation(RecLContactBusinessRelation."Link to Table"::Customer, "Sell-to Customer No.") then
                    RecLContact.SetRange("Company No.", RecLContactBusinessRelation."Contact No.")
                else
                    RecLContact.SetRange("Company No.", '');

                if RecLCustomer.Get("Sell-to Customer No.") then
                    if RecLCustomer."Primary Contact No." <> '' then
                        if RecLContact.Get(RecLCustomer."Primary Contact No.") then;

                if Page.RunModal(0, RecLContact) = Action::LookupOK then begin
                    xRec := Rec;
                    Validate("BBX Contact Order Conf No.", RecLContact."No.");
                end;
            end;

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                if ("BBX Contact Order Conf No." <> '') and
                ("BBX Contact Order Conf No." <> xRec."BBX Contact Order Conf No.") then begin
                    if RecLContact.Get("BBX Contact Order Conf No.") then
                        Validate("BBX Contact Order Conf Email", RecLContact."E-Mail");
                end;
            end;
        }

        field(50226; "BBX Contact Order Conf Name"; Text[100])
        {
            Caption = 'Order Confirmation Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Contact Order Conf No.")));
        }
        field(50227; "BBX Contact Order Conf Email"; Text[100])
        {
            Caption = 'Order Confirmation Contact Email';
        }
        field(50228; "BBX Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(50230; "BBX Try Buy Starting Date"; Date)
        {
            Caption = 'Try & Buy Starting Date';
        }
        field(50231; "BBX Try Buy Ending Date"; Date)
        {
            Caption = 'Try & Buy Ending Date';
        }
        field(50232; "BBX Transport OrganizedBy Cust."; Boolean)
        {
            Caption = 'Transport Organized By Customer';
        }
        field(50233; "BBX Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
        }
        field(50234; "BBX Shipment Cost CHF"; Decimal)
        {
            Caption = 'Shipment Cost [CHF]';
        }
        field(50235; "BBX Not Shippable"; Boolean)
        {
            Caption = 'Not Shippable';
        }
        field(50236; "BBX Proof of export Enum"; Enum "BBX Proof Of Export")
        {
            Caption = 'Proof of export';
        }
        field(50237; "BBX EUR1 Enum"; Enum "BBX EUR1")
        {
            Caption = 'EUR1';
        }
        field(50238; "BBX Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
        }
        field(50243; "BBX Sticker Code"; Code[20])
        {
            Caption = 'Sticker';
            TableRelation = "BBX Stickers".Code;
        }

    }
}