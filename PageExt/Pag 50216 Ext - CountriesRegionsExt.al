pageextension 50216 "BBX CountriesRegionsExt" extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field("BBX CH PREF ORIGIN"; Rec."BBX CH PREF ORIGIN")
            {
                ApplicationArea = All;
            }
        }
    }
}