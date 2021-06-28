table 50206 "BBX Ventilation Lines"
{
    Caption = 'Ventilation Lines';
    LookupPageId = "BBX Ventilation Lines";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
        }
        field(3; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            Editable = false;
            trigger OnValidate()
            var
                RecLItem: Record Item;
            begin
                if RecLItem.Get("Item No.") then
                    Rec.Validate(Description, RecLItem.Description);
            end;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; "Ventilation %"; Integer)
        {
            Caption = 'Ventilation %';
            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
                RecLSalesHeader: Record "Sales Header";
                RecLGeneralLedgerSetup: Record 98;
            begin
                if "Ventilation %" = 0 then
                    exit;
                CheckVentilationPercentage();
                if Amount <> 0 then begin
                    RecLSalesHeader.Get(RecLSalesHeader."Document Type"::Order, "Sales Order No.");
                    if RecLSalesHeader."Currency Code" <> '' then begin
                        RecLCurrency.Get(RecLSalesHeader."Currency Code");
                        Validate("Ventilated Amount", Round((Amount * ("Ventilation %" / 100)), RecLCurrency."Amount Rounding Precision"))
                    end else begin
                        RecLGeneralLedgerSetup.get();
                        Validate("Ventilated Amount", Round((Amount * ("Ventilation %" / 100)), RecLGeneralLedgerSetup."Amount Rounding Precision"))
                    end;
                end else
                    "Ventilated Amount" := 0;
            end;
        }
        field(7; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
                RecLSalesHeader: Record "Sales Header";
                RecLGeneralLedgerSetup: Record "General Ledger Setup";
            begin
                RecLSalesHeader.Get(RecLSalesHeader."Document Type"::Order, "Sales Order No.");
                if RecLSalesHeader."Currency Code" <> '' then begin
                    RecLCurrency.Get(RecLSalesHeader."Currency Code");
                    if Amount <> 0 then
                        Validate("Ventilated Amount", Round((Amount * ("Ventilation %" / 100)), RecLCurrency."Amount Rounding Precision"))
                    else
                        "Ventilated Amount" := 0;
                end
                else begin
                    RecLGeneralLedgerSetup.Get();
                    if Amount <> 0 then
                        Validate("Ventilated Amount", Round((Amount * ("Ventilation %" / 100)), RecLGeneralLedgerSetup."Amount Rounding Precision"))
                    else
                        "Ventilated Amount" := 0;
                end;

            end;
        }
        field(9; "Ventilated Amount"; Decimal)
        {
            Caption = 'Ventilated Amount';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure CheckVentilationPercentage()
    var
        RecLVentilationLines: Record "BBX Ventilation Lines";
        IntLVentilationPercentage: Integer;
        CstLPercentageError: Label 'The ventilation % total can not exceed 100';
    begin
        RecLVentilationLines.Reset();
        RecLVentilationLines.SetRange("Sales Order No.", Rec."Sales Order No.");
        RecLVentilationLines.SetRange("Sales Order Line No.", Rec."Sales Order Line No.");
        RecLVentilationLines.SetRange("Item No.", Rec."Item No.");
        if RecLVentilationLines.FindSet() then
            repeat
                IntLVentilationPercentage += RecLVentilationLines."Ventilation %";
            Until RecLVentilationLines.Next() = 0;
        if not (IntLVentilationPercentage + "Ventilation %" <= 100) then
            Error(CstLPercentageError);
    end;

    procedure CopyFromSalesLine(RecPSalesLine: Record "Sales Line")
    begin
        Rec.Validate("Sales Order No.", RecPSalesLine."Document No.");
        Rec.Validate("Sales Order Line No.", RecPSalesLine."Line No.");
        Rec.Validate("Item No.", RecPSalesLine."No.");
        Rec.Validate(Amount, RecPSalesLine.Amount);
    end;
}