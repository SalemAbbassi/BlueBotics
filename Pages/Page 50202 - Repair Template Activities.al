page 50202 "BBX Repair Template Activities"
{
    PageType = ListPart;
    SourceTable = "BBX Repair Template Activities";
    Caption = 'Repair Template Activities Lines';
    layout
    {
        area(Content)
        {
            repeater(control1)
            {

                field("Repair Template Code"; Rec."Repair Template Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CASE Rec.Type OF
                            Rec.Type::"G/L Account":
                                CopyFromGLAccount;
                            Rec.Type::Cost:
                                CopyFromCost;
                            Rec.Type::Item:
                                CopyFromItem;
                            Rec.Type::Resource:
                                CopyFromResource;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Unit Price Excl VAT"; Rec."Unit Price Excl VAT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    local procedure CopyFromGLAccount()
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get(Rec."No.");
        GLAcc.CheckGLAcc;
        Rec.Description := GLAcc.Name;
    end;

    local procedure CopyFromItem()
    var
        Item: Record Item;
        IsHandled: Boolean;
    begin
        Item.Get(Rec."No.");
        Item.TestField(Blocked, false);
        if Item.IsInventoriableType then
            Item.TestField("Inventory Posting Group");
        Item.TestField("Gen. Prod. Posting Group");
        Rec.Description := Item.Description;
    end;

    local procedure CopyFromResource()
    var
        Res: Record Resource;
    begin
        Res.Get(Rec."No.");
        Res.CheckResourcePrivacyBlocked(false);
        Res.TestField(Blocked, false);
        Res.TestField("Gen. Prod. Posting Group");
        Rec.Description := Res.Name;
    end;

    local procedure CopyFromCost()
    var
        ServCost: Record "Service Cost";
    begin
        ServCost.Get(Rec."No.");
        Rec.Description := ServCost.Description;
    end;
}