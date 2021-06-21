page 50235 "BBX Task Types List"
{
    Caption = 'BlueBotics Task Type';
    PageType = List;
    SourceTable = "BBX Task Types";
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

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Description.';
                }

            }
        }
    }

}