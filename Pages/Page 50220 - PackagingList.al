page 50220 "BBX PackagingList"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "BBX Packaging";
    UsageCategory = Lists;
    AccessByPermission = page "BBX PackagingList" = X;
    Caption = 'Packaging List';
    DelayedInsert = true;
    //CaptionML = ENU = 'Packaging List', FRA = 'Liste emballage';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(TypePackaging; Rec.TypePackaging)
                {
                    ApplicationArea = All;
                }

                field(CodePackaging; Rec.CodePackaging)
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    /*actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }*/
}