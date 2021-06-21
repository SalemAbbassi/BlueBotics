page 50228 "BBX Ventilation Setup"
{
    Caption = 'Ventilation Setup';
    PageType = List;
    SourceTable = "BBX Ventilation Setup";
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
                    Tooltip = 'Specifies the Item No.';
                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Description.';
                }

                field("Ventilation %"; Rec."Ventilation %")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Tooltip = 'Specifies the Ventilation %.';
                }

                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Gen. Prod. Posting Group.';
                }

            }
        }
    }
    var
        CodGItemNo: Code[20];

    trigger OnOpenPage()
    begin
        SetItemNo(Rec."Item No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Item No.", CodGItemNo);
    end;

    procedure SetItemNo(CodPNewItemNo: Code[20])
    begin
        CodGItemNo := CodPNewItemNo;
    end;

}