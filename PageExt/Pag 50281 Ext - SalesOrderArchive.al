pageextension 50281 "BBX Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BBX Project Manager"; Rec."BBX Project Manager")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {

            field("BBX Partner"; Rec."BBX Partner ")
            {
                ApplicationArea = All;
            }
            field(BBXSentByMail; Rec.BBXSentByMail)
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact No."; Rec."BBX Invoicing Contact No.")
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact Name"; Rec."BBX Invoicing Contact Name")
            {
                ApplicationArea = All;
            }
            field("BBX Invoicing Contact"; Rec."BBX Invoicing Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact No."; Rec."BBX Logistics Contact No.")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact Name"; Rec."BBX Logistics Contact Name")
            {
                ApplicationArea = All;
            }
            field("BBX Logistics Contact"; Rec."BBX Logistics Contact")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf No."; Rec."BBX Contact Order Conf No.")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf Name"; Rec."BBX Contact Order Conf Name")
            {
                ApplicationArea = All;
            }
            field("BBX Contact Order Conf Email"; Rec."BBX Contact Order Conf Email")
            {
                ApplicationArea = All;
            }

        }
        addafter("Requested Delivery Date")
        {
            field("BBX Try Buy Ending Date"; Rec."BBX Try Buy Ending Date")
            {
                ApplicationArea = All;
            }
            field("BBX Try Buy Starting Date"; Rec."BBX Try Buy Starting Date")
            {
                ApplicationArea = All;
            }
            field("BBX Expected Delivery Date"; Rec."BBX Expected Delivery Date")
            {
                ApplicationArea = All;
            }

        }
        addlast(General)
        {
            field("BBX Courier Account"; Rec."BBX Courier Account")
            {
                ApplicationArea = All;
            }
            field("BBX Transport OrganizedBy Cust."; Rec."BBX Transport OrganizedBy Cust.")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5159),
                              "No." = FIELD("No.");
            }
        }
    }
}