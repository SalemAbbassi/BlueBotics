page 50223 "BBX PackingList"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "BBX PackingLine";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    AccessByPermission = page "BBX PackingList" = X;
    Caption = 'Packing List';
    PopulateAllFields = true;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(PackingNo; Rec.PackingNo)
                {
                    ApplicationArea = All;

                }
                field(TotalBoxWeight; Rec.TotalBoxWeight)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ModifyPacking)
            {
                Caption = 'Modify';
                ApplicationArea = All;
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    cduPackingMgt: Codeunit "BBX PackingMgt";
                begin
                    cduPackingMgt.openPacking(rec.PackingNo);
                end;
            }
            action(PrintPacking)
            {
                Caption = 'Print';
                ApplicationArea = All;
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    cduPackingMgt: Codeunit "BBX PackingMgt";
                begin
                    cduPackingMgt.printPacking(rec.PackingNo);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        cduPackingMgt: Codeunit "BBX PackingMgt";
    begin
        cduPackingMgt.viewPackingList(Rec);
    end;
}