page 50232 "BBX CEM Expense List"
{
    Caption = 'CEM Expense List';
    PageType = List;
    SourceTable = "CEM Expense";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Entry No.';
                    Tooltip = 'Specifies the Entry No..';
                }

                field("Continia User ID"; Rec."Continia User ID")
                {
                    ApplicationArea = All;
                    //Caption = 'Continia User ID';
                    Tooltip = 'Specifies the Continia User ID.';
                }

                field("Continia User Name"; Rec."Continia User Name")
                {
                    ApplicationArea = All;
                    //Caption = 'Continia User Name';
                    Tooltip = 'Specifies the Continia User Name.';
                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    //Caption = 'Description';
                    Tooltip = 'Specifies the Description.';
                }

                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    //Caption = 'Description 2';
                    Tooltip = 'Specifies the Description 2.';
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    //Caption = 'Document Date';
                    Tooltip = 'Specifies the Document Date.';
                }

                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    //Caption = 'Date Created';
                    Tooltip = 'Specifies the Date Created.';
                }

                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Country/Region Code';
                    Tooltip = 'Specifies the Country/Region Code.';
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Currency Code';
                    Tooltip = 'Specifies the Currency Code.';
                }

                field("No Refund"; Rec."No Refund")
                {
                    ApplicationArea = All;
                    //Caption = 'No Refund';
                    Tooltip = 'Specifies the No Refund.';
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    //Caption = 'Amount';
                    Tooltip = 'Specifies the Amount.';
                }

                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    //Caption = 'Amount (LCY)';
                    Tooltip = 'Specifies the Amount (LCY).';
                }

                field("Created Doc. Type"; Rec."Created Doc. Type")
                {
                    ApplicationArea = All;
                    //Caption = 'Created Doc. Type';
                    Tooltip = 'Specifies the Created Doc. Type.';
                }

                field("Created Doc. Subtype"; Rec."Created Doc. Subtype")
                {
                    ApplicationArea = All;
                    //Caption = 'Created Doc. Subtype';
                    Tooltip = 'Specifies the Created Doc. Subtype.';
                }

                field("Created Doc. ID"; Rec."Created Doc. ID")
                {
                    ApplicationArea = All;
                    //Caption = 'Created Doc. ID';
                    Tooltip = 'Specifies the Created Doc. ID.';
                }

                field("Created Doc. Ref. No."; Rec."Created Doc. Ref. No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Created Doc. Ref. No.';
                    Tooltip = 'Specifies the Created Doc. Ref. No..';
                }

                field("Created By User ID"; Rec."Created By User ID")
                {
                    ApplicationArea = All;
                    //Caption = 'Created By User ID';
                    Tooltip = 'Specifies the Created By User ID.';
                }

                field("Bank-Currency Amount"; Rec."Bank-Currency Amount")
                {
                    ApplicationArea = All;
                    //Caption = 'Bank-Currency Amount';
                    Tooltip = 'Specifies the Bank-Currency Amount.';
                }

                field("Bank Currency Code"; Rec."Bank Currency Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Bank Currency Code';
                    Tooltip = 'Specifies the Bank Currency Code.';
                }

                field("Document Time"; Rec."Document Time")
                {
                    ApplicationArea = All;
                    //Caption = 'Document Time';
                    Tooltip = 'Specifies the Document Time.';
                }

                field("Admin Comment"; Rec."Admin Comment")
                {
                    ApplicationArea = All;
                    //Caption = 'Admin Comment';
                    Tooltip = 'Specifies the Admin Comment.';
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Global Dimension 1 Code';
                    Tooltip = 'Specifies the Global Dimension 1 Code.';
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Global Dimension 2 Code';
                    Tooltip = 'Specifies the Global Dimension 2 Code.';
                }

                field("Transfer Attachments to CO"; Rec."Transfer Attachments to CO")
                {
                    ApplicationArea = All;
                    //Caption = 'Transfer Attachments to CO';
                    Tooltip = 'Specifies the Transfer Attachments to CO.';
                }

                field("Allocated Amount (LCY)"; Rec."Allocated Amount (LCY)")
                {
                    ApplicationArea = All;
                    //Caption = 'Allocated Amount (LCY)';
                    Tooltip = 'Specifies the Allocated Amount (LCY).';
                }

                field("Business Description"; Rec."Business Description")
                {
                    ApplicationArea = All;
                    //Caption = 'Business Description';
                    Tooltip = 'Specifies the Business Description.';
                }

                field("Amount w/o VAT"; Rec."Amount w/o VAT")
                {
                    ApplicationArea = All;
                    //Caption = 'Amount w/o VAT';
                    Tooltip = 'Specifies the Amount w/o VAT.';
                }

                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    //Caption = 'VAT Amount';
                    Tooltip = 'Specifies the VAT Amount.';
                }

                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Tax Area Code';
                    Tooltip = 'Specifies the Tax Area Code.';
                }

                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    //Caption = 'Tax Group Code';
                    Tooltip = 'Specifies the Tax Group Code.';
                }

                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Register No.';
                    Tooltip = 'Specifies the Register No..';
                }

                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Job No.';
                    Tooltip = 'Specifies the Job No..';
                }

                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Job Task No.';
                    Tooltip = 'Specifies the Job Task No..';
                }

                field("Billable"; Rec."Billable")
                {
                    ApplicationArea = All;
                    //Caption = 'Billable';
                    Tooltip = 'Specifies the Billable.';
                }

                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    //Caption = 'Job Line Type';
                    Tooltip = 'Specifies the Job Line Type.';
                }

                field("Cash/Private Card"; Rec."Cash/Private Card")
                {
                    ApplicationArea = All;
                    //Caption = 'Cash/Private Card';
                    Tooltip = 'Specifies the Cash/Private Card.';
                }

                field("Reimbursement Register No."; Rec."Reimbursement Register No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Reimbursement Register No.';
                    Tooltip = 'Specifies the Reimbursement Register No..';
                }

                field("Reimbursement Method"; Rec."Reimbursement Method")
                {
                    ApplicationArea = All;
                    //Caption = 'Reimbursement Method';
                    Tooltip = 'Specifies the Reimbursement Method.';
                }

                field("Reimbursed"; Rec."Reimbursed")
                {
                    ApplicationArea = All;
                    //Caption = 'Reimbursed';
                    Tooltip = 'Specifies the Reimbursed.';
                }

                field("Employee Reimbursed"; Rec."Employee Reimbursed")
                {
                    ApplicationArea = All;
                    //Caption = 'Employee Reimbursed';
                    Tooltip = 'Specifies the Employee Reimbursed.';
                }

                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                    //Caption = 'On Hold';
                    Tooltip = 'Specifies the On Hold.';
                }

                field("Comment"; Rec."Comment")
                {
                    ApplicationArea = All;
                    //Caption = 'Comment';
                    Tooltip = 'Specifies the Comment.';
                }

                field("Original Expense Entry No."; Rec."Original Expense Entry No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Original Expense Entry No.';
                    Tooltip = 'Specifies the Original Expense Entry No..';
                }

                field("Entry No. (Code)"; Rec."Entry No. (Code)")
                {
                    ApplicationArea = All;
                    //Caption = 'Entry No. (Code)';
                    Tooltip = 'Specifies the Entry No. (Code).';
                }

                field("Usage Entry No."; Rec."Usage Entry No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Usage Entry No.';
                    Tooltip = 'Specifies the Usage Entry No..';
                }

                field("Expense GUID"; Rec."Expense GUID")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense GUID';
                    Tooltip = 'Specifies the Expense GUID.';
                }

                field("Expense Account Type"; Rec."Expense Account Type")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense Account Type';
                    Tooltip = 'Specifies the Expense Account Type.';
                }

                field("Expense Account"; Rec."Expense Account")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense Account';
                    Tooltip = 'Specifies the Expense Account.';
                }

                field("Exp. Account Manually Changed"; Rec."Exp. Account Manually Changed")
                {
                    ApplicationArea = All;
                    //Caption = 'Exp. Account Manually Changed';
                    Tooltip = 'Specifies the Exp. Account Manually Changed.';
                }

                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    //Caption = 'Gen. Prod. Posting Group';
                    Tooltip = 'Specifies the Gen. Prod. Posting Group.';
                }

                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    //Caption = 'VAT Prod. Posting Group';
                    Tooltip = 'Specifies the VAT Prod. Posting Group.';
                }

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    //Caption = 'Gen. Bus. Posting Group';
                    Tooltip = 'Specifies the Gen. Bus. Posting Group.';
                }

                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    //Caption = 'VAT Bus. Posting Group';
                    Tooltip = 'Specifies the VAT Bus. Posting Group.';
                }

                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    //Caption = 'Status';
                    Tooltip = 'Specifies the Status.';
                }

                field("Current Reminder Level"; Rec."Current Reminder Level")
                {
                    ApplicationArea = All;
                    //Caption = 'Current Reminder Level';
                    Tooltip = 'Specifies the Current Reminder Level.';
                }

                field("Settlement No."; Rec."Settlement No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Settlement No.';
                    Tooltip = 'Specifies the Settlement No..';
                }

                field("Settlement Line No."; Rec."Settlement Line No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Settlement Line No.';
                    Tooltip = 'Specifies the Settlement Line No..';
                }

                field("Expense Type"; Rec."Expense Type")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense Type';
                    Tooltip = 'Specifies the Expense Type.';
                }

                field("Matched to Bank Transaction"; Rec."Matched to Bank Transaction")
                {
                    ApplicationArea = All;
                    //Caption = 'Matched to Bank Transaction';
                    Tooltip = 'Specifies the Matched to Bank Transaction.';
                }

                field("Response from Dataloen"; Rec."Response from Dataloen")
                {
                    ApplicationArea = All;
                    //Caption = 'Response from Dataloen';
                    Tooltip = 'Specifies the Response from Dataloen.';
                }

                field("Posted"; Rec."Posted")
                {
                    ApplicationArea = All;
                    //Caption = 'Posted';
                    Tooltip = 'Specifies the Posted.';
                }

                field("Posted Date/Time"; Rec."Posted Date/Time")
                {
                    ApplicationArea = All;
                    //Caption = 'Posted Date/Time';
                    Tooltip = 'Specifies the Posted Date/Time.';
                }

                field("Posted by User ID"; Rec."Posted by User ID")
                {
                    ApplicationArea = All;
                    //Caption = 'Posted by User ID';
                    Tooltip = 'Specifies the Posted by User ID.';
                }

                field("Expense Completed"; Rec."Expense Completed")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense Completed';
                    Tooltip = 'Specifies the Expense Completed.';
                }

                field("Continia Online Version No."; Rec."Continia Online Version No.")
                {
                    ApplicationArea = All;
                    //Caption = 'Continia Online Version No.';
                    Tooltip = 'Specifies the Continia Online Version No..';
                }

                field("No. of Attachments"; Rec."No. of Attachments")
                {
                    ApplicationArea = All;
                    //Caption = 'No. of Attachments';
                    Tooltip = 'Specifies the No. of Attachments.';
                }

                field("No. of Attendees"; Rec."No. of Attendees")
                {
                    ApplicationArea = All;
                    //Caption = 'No. of Attendees';
                    Tooltip = 'Specifies the No. of Attendees.';
                }

                field("Expense Header GUID"; Rec."Expense Header GUID")
                {
                    ApplicationArea = All;
                    //Caption = 'Expense Header GUID';
                    Tooltip = 'Specifies the Expense Header GUID.';
                }

                field("External Posting Account Type"; Rec."External Posting Account Type")
                {
                    ApplicationArea = All;
                    //Caption = 'External Posting Account Type';
                    Tooltip = 'Specifies the External Posting Account Type.';
                }

                field("External Posting Account No."; Rec."External Posting Account No.")
                {
                    ApplicationArea = All;
                    //Caption = 'External Posting Account No.';
                    Tooltip = 'Specifies the External Posting Account No..';
                }

            }
        }
    }
    procedure GetSelectionFilter(var Expense: Record "CEM Expense")
    begin
        CurrPage.SETSELECTIONFILTER(Expense);
    end;
}