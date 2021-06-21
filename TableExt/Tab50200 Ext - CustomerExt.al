tableextension 50200 BBXCustomerExt extends Customer
{
    fields
    {
        modify("Name 2")
        {
            Caption = 'Distributor Name';
        }
        field(50200; "BBX EORI Number"; Code[20])
        {
            Caption = 'EORI Number';
            trigger OnValidate()
            var
                RecLCustomer: Record Customer;
            begin
                IF "BBX EORI Number" <> '' then begin
                    RecLCustomer.SetRange(RecLCustomer."BBX EORI Number", "BBX EORI Number");
                    IF NOT (RecLCustomer.IsEmpty) then
                        Error(CstGCustomerEORIUniqueError);
                end;

            end;
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
        field(50204; "BBX Pilot"; Boolean)
        {
            Caption = 'Pilot';
        }
        field(50205; "BBX Invoicing Contact"; Text[100])
        {
            Caption = 'Invoicing Contact Email';
            Editable = false;
        }
        field(50206; "BBX Logistics Contact"; Text[100])
        {
            Caption = 'Logistics Contact Email';
            Editable = false;
        }
        field(50207; "BBX Invoicing Contact Name"; Text[100])
        {
            Caption = 'Invoicing Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Invoicing Contact No.")));
        }
        field(50208; "BBX Logistics Contact Name"; Text[100])
        {
            Caption = 'Logistics Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Logistics Contact No.")));
        }
        field(50209; "BBXProject Manager"; Code[50])
        {
            Caption = 'Project Manager';
            TableRelation = "User Setup";
        }
        field(50210; "BBX Invoicing Contact No."; Code[20])
        {
            Caption = 'Invoicing Contact No.';
            TableRelation = Contact."No.";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                RecLContact: Record Contact;
                RecLContactBusinessRelation: Record "Contact Business Relation";
            begin

                if RecLContactBusinessRelation.FindByRelation(RecLContactBusinessRelation."Link to Table"::Customer, "No.") then
                    RecLContact.SetRange("Company No.", RecLContactBusinessRelation."Contact No.")
                else
                    RecLContact.SetRange("Company No.", '');


                if "Primary Contact No." <> '' then
                    if RecLContact.Get("Primary Contact No.") then;
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

        field(50211; "BBX Logistics Contact No."; Code[20])
        {
            Caption = 'Logistics Contact No.';
            TableRelation = Contact."No.";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                RecLContact: Record Contact;
                RecLContactBusinessRelation: Record "Contact Business Relation";
            begin

                if RecLContactBusinessRelation.FindByRelation(RecLContactBusinessRelation."Link to Table"::Customer, "No.") then
                    RecLContact.SetRange("Company No.", RecLContactBusinessRelation."Contact No.")
                else
                    RecLContact.SetRange("Company No.", '');


                if "Primary Contact No." <> '' then
                    if RecLContact.Get("Primary Contact No.") then;
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
        field(50212; "BBX Transport OrganizedBy Cust."; Boolean)
        {
            Caption = 'Transport Organized By Customer';
        }
        field(50213; "BBX Standard Text Code"; Code[20])
        {
            Caption = 'Standard Text Code';
            TableRelation = "Standard Text".Code;
        }
        field(50214; "BBX Contact Order Conf. No."; Text[100])
        {
            Caption = 'Order Confirmation Contact No.';
            TableRelation = Contact.Name;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                RecLContact: Record Contact;
                RecLContactBusinessRelation: Record "Contact Business Relation";
            begin

                if RecLContactBusinessRelation.FindByRelation(RecLContactBusinessRelation."Link to Table"::Customer, "No.") then
                    RecLContact.SetRange("Company No.", RecLContactBusinessRelation."Contact No.")
                else
                    RecLContact.SetRange("Company No.", '');


                if "Primary Contact No." <> '' then
                    if RecLContact.Get("Primary Contact No.") then;
                if Page.RunModal(0, RecLContact) = Action::LookupOK then begin
                    xRec := Rec;
                    Validate("BBX Contact Order Conf. No.", RecLContact."No.");
                end;
            end;

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                if ("BBX Contact Order Conf. No." <> '') and
                    ("BBX Contact Order Conf. No." <> xRec."BBX Contact Order Conf. No.") then begin
                    if RecLContact.Get("BBX Contact Order Conf. No.") then
                        Validate("BBX Contact Order Conf. Email", RecLContact."E-Mail");
                end;
            end;
        }
        field(50215; "BBX Contact Order Conf. Name"; Text[100])
        {
            Caption = 'Order Confirmation Contact Name';
            TableRelation = Contact.Name;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("BBX Contact Order Conf. No.")));
        }
        field(50216; "BBX Contact Order Conf. Email"; Text[100])
        {
            Caption = 'Order Confirmation Contact Email';
            Editable = false;
        }
        field(50217; "BBX EUR.1 Enum"; Enum "BBX Customer EUR1")
        {
            Caption = 'EUR.1';
        }
        field(50218; "BBX Sticker Code"; Code[20])
        {
            Caption = 'Sticker';
            TableRelation = "BBX Stickers".Code;
        }
        field(50219; "BBX IOSS"; Code[20])
        {
            Caption = 'IOSS';
        }
    }
    var
        CstGCustomerIDUniqueError: Label 'The "Customer ID" must be unique', Comment = 'The "Customer ID" must be unique';
        CstGCustomerEORIUniqueError: Label 'The "EORI Number" must be unique', Comment = 'The "EORI Number" must be unique';

    procedure CheckMandatoryFields()
    begin
        TestField(Address);
        TestField(City);
        TestField("Post Code");
        TestField("Language Code");
        TestField("Gen. Bus. Posting Group");
        TestField("VAT Bus. Posting Group");
        TestField("Customer Posting Group");
    end;
}