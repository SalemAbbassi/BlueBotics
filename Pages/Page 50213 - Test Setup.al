page 50213 "BBX Test Setup"
{

    ApplicationArea = All;
    Caption = 'BlueBotics Test Setup';
    PageType = List;
    SourceTable = "BBX Setup Table";
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Key"; Rec."Key")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("ANT Box Serial No."; Rec."ANT Box Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Bootfile Number"; Rec."Bootfile Number")
                {
                    ApplicationArea = All;
                }
                field("IO Board Firmware"; Rec."IO Board Firmware")
                {
                    ApplicationArea = All;
                }
                field("Production Order Item Code"; Rec."Production Order Item Code")
                {
                    ApplicationArea = All;
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Test Date"; Rec."Test Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
