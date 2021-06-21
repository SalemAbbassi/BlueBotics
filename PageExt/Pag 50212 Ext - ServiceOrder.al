pageextension 50212 "BBX ServiceOrderExt" extends "Service Order"
{
    layout
    {
        addlast(General)
        {
            field("BBX Freshdesk Description"; Rec."BBX Freshdesk Description")
            {
                ApplicationArea = All;
                ToolTip = 'Description coming from Freshdesk.';
            }
            field("BBX Work performed"; Rec."BBX Work performed")
            {
                ApplicationArea = All;
                ToolTip = 'Description of the work done';
            }
            field("BBX Analysis BlueBotics"; Rec."BBX Analysis BlueBotics")
            {
                ToolTip = 'Specifies the value of the Analysis BlueBotics field';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action("BBX InspectionReportprint")
            {
                ApplicationArea = all;
                Caption = 'Inspection Report Print';
                Image = PrintReport;
                Promoted = true;
                Ellipsis = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    RecLServiceHeader: Record "Service Header";
                    RepLInspectionReport: Report "BBX Inspection report";
                begin
                    RecLServiceHeader.SetRange("Document Type", Rec."Document Type");
                    RecLServiceHeader.SetRange("No.", Rec."No.");
                    IF RecLServiceHeader.FindSet() then begin
                        RepLInspectionReport.SetTableView(RecLServiceHeader);
                        RepLInspectionReport.RunModal();
                    end;
                end;
            }
            action("BBX SetSymptomCodes")
            {
                ApplicationArea = all;
                Caption = 'Symptom Codes';
                Image = CodesList;
                RunObject = Page "BBX Symptom Codes List";
                RunPageLink = "Service Order No." = field("No.");
            }
        }
    }
}