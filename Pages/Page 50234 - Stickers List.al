page 50234 "BBX Stickers List"
{
    Caption = 'BlueBotics Stickers List';
    PageType = List;
    SourceTable = "BBX Stickers";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Code.';
                }

                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Type.';
                }

                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Name.';
                }

            }
        }
    }

}