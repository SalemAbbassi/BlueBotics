tableextension 50201 BBXSalesHeaderExt extends "Sales Header"
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
        field(50202; "BBX Partner"; Boolean)
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

        //>>VTE-Gap01
        field(50204; "BBX Effective date"; Date)
        {
            Caption = 'Effective date';
            trigger OnValidate()
            var
                RecLSalesLine: Record "Sales Line";
            begin
                If ("Document Type" = "Document Type"::"Blanket Order") AND
                 ("BBX Effective date" <> xRec."BBX Effective date") then begin
                    RecLSalesLine.SetRange("Document Type", "Document Type"::"Blanket Order");
                    RecLSalesLine.SetRange("Document No.", "No.");
                    IF RecLSalesLine.FindSet() then begin
                        RecLSalesLine.Validate("BBX Effective date", "BBX Effective date");
                        RecLSalesLine.Modify();
                    end;
                end;
            end;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
                RecLSalesLine: Record "Sales Line";
            begin
                If ("Document Type" = "Document Type"::"Blanket Order") AND
                ("Due Date" <> xRec."Due Date") then begin
                    RecLSalesLine.SetRange("Document Type", "Document Type"::"Blanket Order");
                    RecLSalesLine.SetRange("Document No.", "No.");
                    IF RecLSalesLine.FindSet() then begin
                        RecLSalesLine.Validate("BBX Due Date", "Due Date");
                        RecLSalesLine.Modify();
                    end;
                end;
            end;
        }
        //<<VTE-Gap01

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
        field(50210; "BBX Firm Planned PO"; Code[20])
        {
            Caption = 'Firm Planned PO';
            FieldClass = FlowField;
            CalcFormula = Lookup("Production Order"."No." WHERE("BBX Sales Order No." = FIELD("No."), Status = filter("Firm Planned")));
        }
        field(50211; "BBX Released PO"; Code[20])
        {
            Caption = 'Released PO';
            FieldClass = FlowField;
            CalcFormula = Lookup("Production Order"."No." WHERE("BBX Sales Order No." = FIELD("No."), Status = filter(Released)));
        }
        field(50212; "BBX Finished PO"; Code[20])
        {
            Caption = 'Finished PO';
            FieldClass = FlowField;
            CalcFormula = Lookup("Production Order"."No." WHERE("BBX Sales Order No." = FIELD("No."), Status = filter(Finished)));
        }
        field(50213; BBXSentByMail; Boolean)
        {
            Caption = 'Sent by Mail';
        }
        field(50214; "BBX PO Count"; Integer)
        {
            Caption = 'Number of PO';
            FieldClass = FlowField;
            CalcFormula = count("Production Order" where("BBX Sales Order No." = FIELD("No."), Status = filter(Released | "Firm Planned")));
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
            Caption = 'Invoicing Contact Email';
            TableRelation = Contact."E-Mail";
            ValidateTableRelation = false;
            Editable = false;

            /*trigger OnLookup()
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
                    Validate("BBX Invoicing Contact", RecLContact."E-Mail");
                end;
            end;*/

        }
        field(50224; "BBX Logistics Contact"; Text[100])
        {
            Caption = 'Logistics Contact Email';
            TableRelation = Contact."E-Mail";
            ValidateTableRelation = false;

            /*trigger OnLookup()
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
                    Validate("BBX Logistics Contact", RecLContact."E-Mail");
                end;
            end;*/
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
        field(50239; "BBX Invoicing Contact No."; Code[20])
        {
            Caption = 'Invoicing Contact No.';
            TableRelation = Contact."E-Mail";
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
                    Validate("BBX Invoicing Contact No.", RecLContact."No.");
                end;
            end;

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                if ("BBX Invoicing Contact No." <> '') and
                    ("BBX Invoicing Contact No." <> xRec."BBX Invoicing Contact No.") then begin
                    if RecLContact.Get("BBX Invoicing Contact No.") then
                        Validate("BBX Invoicing Contact", RecLContact."E-Mail");
                end;
            end;

        }
        field(50240; "BBX Invoicing Contact Name"; Text[100])
        {
            Caption = 'Invoicing Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Invoicing Contact No.")));
        }
        field(50241; "BBX Logistics Contact No."; Code[20])
        {
            Caption = 'Logistics Contact No.';
            TableRelation = Contact."E-Mail";
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
                    Validate("BBX Logistics Contact No.", RecLContact."No.");
                end;
            end;

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                if ("BBX Logistics Contact No." <> '') and
                    ("BBX Logistics Contact No." <> xRec."BBX Logistics Contact No.") then begin
                    if RecLContact.Get("BBX Logistics Contact No.") then
                        Validate("BBX Logistics Contact", RecLContact."E-Mail");
                end;
            end;
        }
        field(50242; "BBX Logistics Contact Name"; Text[100])
        {
            Caption = 'Logistics Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Logistics Contact No.")));
        }
        field(50243; "BBX Sticker Code"; Code[20])
        {
            Caption = 'Sticker';
            TableRelation = "BBX Stickers".Code;
        }
    }
    trigger OnAfterInsert()
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            "Assigned User ID" := UserId;
    end;

    procedure GetWarehouseShipmentNo(): Code[20];
    var
        RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
        RecLWarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        RecLWarehouseShipmentLine.SetRange("Source No.", "No.");
        if RecLWarehouseShipmentLine.FindFirst() then
            if RecLWarehouseShipmentHeader.Get(RecLWarehouseShipmentLine."No.") then
                exit(RecLWarehouseShipmentHeader."No.");
    end;

    procedure GetOpenWarehouseShipmentNo(): Code[20];
    var
        RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
        RecLWarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        RecLWarehouseShipmentLine.SetRange("Source No.", "No.");
        if RecLWarehouseShipmentLine.FindSet() then
            repeat
                if RecLWarehouseShipmentHeader.Get(RecLWarehouseShipmentLine."No.") AND (RecLWarehouseShipmentHeader.Status = RecLWarehouseShipmentHeader.Status::Open) then
                    exit(RecLWarehouseShipmentHeader."No.");
            until RecLWarehouseShipmentLine.next = 0;
    end;

    procedure GetReleasedWarehouseShipmentNo(): Code[20];
    var
        RecLWarehouseShipmentHeader: Record "Warehouse Shipment Header";
        RecLWarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        RecLWarehouseShipmentLine.SetRange("Source No.", "No.");
        if RecLWarehouseShipmentLine.FindSet() then
            repeat
                if RecLWarehouseShipmentHeader.Get(RecLWarehouseShipmentLine."No.") AND (RecLWarehouseShipmentHeader.Status = RecLWarehouseShipmentHeader.Status::Released) then
                    exit(RecLWarehouseShipmentHeader."No.");
            until RecLWarehouseShipmentLine.next = 0;
    end;

    procedure GetPostedWhseShipmentNo(): Code[20];
    var
        RecLPostedWhsShptHeader: Record "Posted Whse. Shipment Header";
        RecLPostedWhsShptLine: Record "Posted Whse. Shipment Line";
    begin
        RecLPostedWhsShptLine.SetRange("Source No.", "No.");
        if RecLPostedWhsShptLine.FindFirst() then
            if RecLPostedWhsShptHeader.Get(RecLPostedWhsShptLine."No.") then
                exit(RecLPostedWhsShptHeader."No.");
    end;

    procedure GetOrderInvoicedAmount() DecRInvoicedAmount: Decimal
    var
        RecLSalesLine: Record "Sales Line";
    begin
        DecRInvoicedAmount := 0;
        RecLSalesLine.SetRange("Document Type", "Document Type"::Order);
        RecLSalesLine.SetRange("Document No.", "No.");
        RecLSalesLine.SetFilter("DBE Task Billing Type", '<>%1', RecLSalesLine."DBE Task Billing Type"::"Milestone Task");
        if RecLSalesLine.FindSet() then
            repeat
                //DecRInvoicedAmount += RecLSalesLine.Amount - RecLSalesLine."Outstanding Amount";
                if RecLSalesLine."Quantity Invoiced" <> 0 then
                    DecRInvoicedAmount += RecLSalesLine."Quantity Invoiced" * RecLSalesLine."Unit Price" - (RecLSalesLine."Line Discount Amount" + RecLSalesLine."Inv. Discount Amount");
            until RecLSalesLine.Next() = 0;
        exit(DecRInvoicedAmount);
    end;
}