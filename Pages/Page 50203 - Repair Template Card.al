page 50203 "BBX Repair Template Card"
{
    PageType = Card;
    SourceTable = "BBX Repair Template";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Repair Template Code"; Rec."Repair Template Code")
                {
                    ApplicationArea = All;
                }
                field("Repair Template Description"; Rec."Repair Template Description")
                {
                    ApplicationArea = All;
                }
            }
            part("Repair Template Activities"; "BBX Repair Template Activities")
            {
                SubPageLink = "Repair Template Code" = field("Repair Template Code");
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
        }

    }
}