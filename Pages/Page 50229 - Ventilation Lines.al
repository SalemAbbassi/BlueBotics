page 50229 "BBX Ventilation Lines"
{
    Caption = 'Ventilation Lines';
    PageType = List;
    SourceTable = "BBX Ventilation Lines";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Item No..';
                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Description.';
                }

                field("Ventilation %"; Rec."Ventilation %")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Ventilation %.';
                }

                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Gen. Prod. Posting Group.';
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Amount.';
                    Editable = false;
                }

                field("Ventilated Amount"; Rec."Ventilated Amount")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Ventilated Amount.';
                    Editable = false;
                }
            }
        }
    }
    var
        CodGItemNo: Code[20];
        CodGOrderNo: Code[20];
        IntGLineNo: Integer;
        DecGAmount: Decimal;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Sales Order No.", CodGOrderNo);
        Rec.SetRange("Sales Order Line No.", IntGLineNo);
        Rec.SetRange("Item No.", CodGItemNo);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Sales Order No.", CodGOrderNo);
        Rec.Validate("Sales Order Line No.", IntGLineNo);
        Rec.Validate("Item No.", CodGItemNo);
        Rec.Validate(Amount, DecGAmount);
    end;

    procedure SetValues(CodPNewOrderNo: Code[20]; IntPNewLineNo: Integer; CodPNewItemNo: Code[20]; DecPNewAmount: Decimal)
    begin
        CodGItemNo := CodPNewItemNo;
        CodGOrderNo := CodPNewOrderNo;
        IntGLineNo := IntPNewLineNo;
        DecGAmount := DecPNewAmount;
    end;

}