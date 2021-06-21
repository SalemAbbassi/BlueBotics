pageextension 50272 "BBX Service Quote" extends "Service Quote"
{
    layout
    {
        addlast(General)
        {

            field("BBX Freshdesk Description"; Rec."BBX Freshdesk Description")
            {
                ApplicationArea = All;
            }
            field("BBX Work performed"; Rec."BBX Work performed")
            {
                ApplicationArea = All;
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
        addafter("&Print")
        {
            action("BBX InspectionReportprint")
            {
                ApplicationArea = all;
                Caption = 'Inspection Report Print';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Category4;
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
        }
    }
}