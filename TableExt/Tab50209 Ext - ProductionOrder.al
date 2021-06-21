tableextension 50209 "BBX ProductionOrderHeaderExt" extends "Production Order"
{
    fields
    {
        //>>PRO-GC22
        field(50200; "BBX BootFile"; Text[100])
        {
            Caption = 'BootFile';
            trigger OnValidate()
            var
                RecLProdOrderLine: Record "Prod. Order Line";
            begin
                IF "BBX BootFile" <> xRec."BBX BootFile" then begin
                    RecLProdOrderLine.SetRange(Status, Status);
                    RecLProdOrderLine.SetRange("Prod. Order No.", "No.");
                    IF RecLProdOrderLine.FindSet() then
                        RecLProdOrderLine.ModifyAll("BBX BootFile", "BBX BootFile");
                end;
            end;
        }
        field(50201; "BBX Customer ID"; Text[100])
        {
            Caption = 'Customer ID';
            trigger OnValidate()
            var
                RecLProdOrderLine: Record "Prod. Order Line";
            begin
                IF "BBX Customer ID" <> xRec."BBX Customer ID" then begin
                    RecLProdOrderLine.SetRange(Status, Status);
                    RecLProdOrderLine.SetRange("Prod. Order No.", "No.");
                    IF RecLProdOrderLine.FindSet() then
                        RecLProdOrderLine.ModifyAll("BBX Customer ID", "BBX Customer ID");
                end;
            end;
        }
        //<<PRO-GC22

        field(50202; "BBXLink Main Prod. Order No."; Code[20])
        {
            Caption = 'Link To Main Prod. Order No.';
        }
        field(50203; "BBX Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
        }
        field(50204; "BBX Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            Editable = false;

            trigger OnValidate()
            var
                RecLCustomer: Record Customer;
            begin
                if "BBX Customer No." <> '' then begin
                    RecLCustomer.GET("BBX Customer No.");
                    "BBX Customer Name" := RecLCustomer.Name;
                end;
            end;
        }
        field(50205; "BBX Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            TableRelation = Customer;
            Editable = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                RecLCustomer: Record Customer;
            begin
                if "BBX Customer Name" <> '' then begin
                    RecLCustomer.GET("BBX Customer No.");
                    "BBX Customer No." := RecLCustomer."No.";
                end;
            end;

            trigger OnLookup()
            var
                Customer: Record Customer;
                CustomerLookup: Page "Customer Lookup";
            begin
                if "BBX Customer No." <> '' then
                    Customer.Get("BBX Customer No.");

                CustomerLookup.SetTableView(Customer);
                CustomerLookup.SetRecord(Customer);
                CustomerLookup.LookupMode := true;
                if CustomerLookup.RunModal = ACTION::LookupOK then begin
                    xRec := Rec;
                    "BBX Customer Name" := Customer.Name;
                    Validate("BBX Customer No.", Customer."No.");
                end;
            end;
        }
        field(50206; "BBX Finished Quantity"; Decimal)
        {
            Caption = 'Finished Quantity';
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line"."Finished Quantity" where(Status = field(Status), "Prod. Order No." = field("No.")));
        }
        field(50207; "BBX Sticker Code"; Code[20])
        {
            Caption = 'Sticker';
            TableRelation = "BBX Stickers".Code;
        }

        field(50250; "BBXKey"; text[100])
        {
            Caption = 'Key';
        }
        field(50251; "BBXTest Date"; Date)
        {
            Caption = 'Test Date';
        }
        field(50252; "BBXIO Board Firmware"; Text[50])
        {
            Caption = 'IO Board Firmware';
        }

    }
}