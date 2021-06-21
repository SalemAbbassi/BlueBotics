pageextension 50218 "BBX StandardTextCodesExt" extends "Standard Text Codes"
{
    layout
    {
        addafter(Description)
        {
            field("BBX CH PREF ORIGIN"; Rec."BBX CH PREF ORIGIN")
            {
                ApplicationArea = All;
            }
            field("BBX Partner cust"; Rec."BBX Partner cust")
            {
                ApplicationArea = all;
            }
            field("BBX Transport Fee Text"; Rec."BBX Transport Fee Text")
            {
                ApplicationArea = All;
            }
        }
    }
}