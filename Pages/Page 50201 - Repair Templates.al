page 50201 "BBX Repair Templates"
{
    PageType = list;
    ApplicationArea = Service;
    UsageCategory = Lists;
    SourceTable = "BBX Repair Template";
    Caption = 'Repair Template List';
    CardPageId = "BBX Repair Template Card";

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
                field("Repair Template Description"; Rec."Repair Template Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}