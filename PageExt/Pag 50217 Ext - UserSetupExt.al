pageextension 50217 "BBX UserSetupExt" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {

            field("BBX Full Name"; Rec."BBX Full Name")
            {
                ApplicationArea = All;
            }

        }

        addafter("Register Time")
        {
            field("BBX Signatory PROFORMA"; Rec."BBX Signatory PROFORMA")
            {
                ApplicationArea = All;
            }
        }

        addfirst(factboxes)
        {
            part("BBX Signature Factbox"; "BBX Signature Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "User ID" = FIELD("User ID");
            }
        }
    }
}