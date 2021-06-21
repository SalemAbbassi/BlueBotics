page 50221 "BBX PackingDoc"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "BBX PackingLine";
    UsageCategory = Documents;
    AccessByPermission = page "BBX PackingDoc" = X;
    Caption = 'Packing Document';
    AutoSplitKey = true;
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(PackingNo; Rec.PackingNo)
                {
                    ApplicationArea = all;
                }
                field(LineNo; Rec.LineNo)
                {
                    ApplicationArea = all;
                }
                field(ShipmentNo; Rec.ShipmentNo)
                {
                    ApplicationArea = All;

                }
                field(ItemNo; Rec.ItemNo)
                {
                    ApplicationArea = all;
                }
                field(ShipmentQty; Rec.ShipmentQty)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(VariantCode; Rec.VariantCode)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Qty; Rec.Qty)
                {
                    ApplicationArea = all;
                }
                field(BoxType; Rec.BoxType)
                {
                    ApplicationArea = all;
                }
                field(BoxNo; Rec.BoxNo)
                {
                    ApplicationArea = all;
                }
                field(WeightLine; Rec.WeightLine)
                {
                    ApplicationArea = all;
                }
            }
            part(PackingSubDoc; "BBX PackingSubDoc")
            {

                ApplicationArea = all;
                //SubPageLink = PackingNo = FIELD (PackingNo);
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
            /*action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }*/
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

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.PackingSubDoc.Page.refreshData(rec.PackingNo);
    end;
}