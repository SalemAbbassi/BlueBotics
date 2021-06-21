report 50201 "BBX Inspection report"
{
    DefaultLayout = Word;
    WordLayout = './BlueBotics Inspection Report.docx';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inspection report';
    ApplicationArea = All;
    WordMergeDataItem = ServiceItemLine;

    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            RequestFilterFields = "No.";
            column(No_ServiceHeader; "No.")
            {
            }
            column(assignedUserID_ServiceHeader; ServiceHeader."Assigned User ID")
            {

            }
            column(FinishingDate_ServiceHeader; FORMAT("Finishing Date"))
            {
            }
            column(Name_ServiceHeader; Name)
            {
            }

            column(Workperformed; "BBX Work performed")
            {
            }
            column(InspectionReportTitle; InspectionReportTitle)
            {
            }
            column(RepairLb; RepairLbl)
            {
            }
            column(Pagelbl; Pagelbl)
            {
            }
            column(FinishDateCaption; FinishDateCaptionLbl)
            {
            }
            column(OperatorCaption; OperatorCaptionLbl)
            {
            }
            column(SerialNoCaption; SerialNoCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(WorkPerformedCaption; WorkPerformedCaptionLbl)
            {
            }
            column(OperatorSignatureCaption; OperatorSignatureCaptionLbl)
            {
            }

            column(LangCaption; LangCaptionLbl)
            {
            }
            column(VersionCaption; VersionCaptionLbl)
            {
            }
            column(DeviceIDCaption; DeviceIDCaptionLbl)
            {

            }
            column(Picture_CompnayInfo; CompanyInfo.Picture)
            {

            }
            column(Descrption_Symptom; TxtGSymptomDescription)
            {
            }
            column(Signature; RecGTenantMedia.Content)
            {
            }
            column(BBXAnalysisBlueBotics_ServiceHeader; "BBX Analysis BlueBotics")
            {
            }

            trigger OnAfterGetRecord()
            var
                RecLSymptom: Record "BBX Symptom";
            begin
                RecLSymptom.SetRange("Service Order No.", "No.");
                IF RecLSymptom.FindSet() then
                    repeat
                        If TxtGSymptomDescription = '' then
                            TxtGSymptomDescription += RecLSymptom.Descrption
                        else
                            TxtGSymptomDescription += '. ' + RecLSymptom.Descrption;
                    until RecLSymptom.Next() = 0;

                if RecGUserSetup.Get(ServiceHeader."Assigned User ID") then
                    CalcSignature(RecGUserSetup, RecGTenantMedia);
            end;
        }

        dataitem(ServiceItemLine; "Service Item Line")
        {

            DataItemTableView = SORTING("Document No.", "Line No.");
            DataItemLinkReference = ServiceHeader;
            DataItemLink = "Document No." = field("No.");
            column(Description_ServiceItemLine; Description)
            {
            }
            column(DocumentNo_ServiceItemLine; "Document No.")
            {
            }
            column(LineNo_ServiceItemLine; "Line No.")
            {
            }
            column(SerialNo_ServiceItemLine; "Serial No.")
            {
            }
            column(ItemNo_ServiceItemLine; "Item No.")
            {
            }
            column(DeviceTypeCaption; DeviceTypeCaptionLbl)
            {
            }
            column(CustomerInputCaption; CustomerInputCaptionLbl)
            {
            }
            column(FreshdeskDescription; ServiceHeader."BBX Freshdesk Description")
            {
            }
            column(RepairTypeCaption; RepairTypeCaptionLbl)
            {

            }
            column(RepairCaption; RepairLbl)
            {

            }
            column(AnalysisBlueBoticsCaption; AnalysisBlueBoticsCaptionLbl)
            {
            }
            column(Warranty_ServiceItemLine; TxtGRepairType)
            {

            }

            column(PrintingDate; Format(Today))
            {

            }
            column(ItemName; RecGItem.Description)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(ItemDesc; ItemDescLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                If Warranty then
                    TxtGRepairType := 'Warranty repair'
                else
                    TxtGRepairType := 'Defect, to be invoiced to customer';

                if not RecGItem.Get("Item No.") then RecGItem.Init();
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        InspectionReportTitle: Label 'Inspection Report';
        RepairLbl: Label 'A: Warranty repair. B: Defect, to be invoiced to customer.';
        Pagelbl: Label 'Page';
        FinishDateCaptionLbl: Label 'Date';
        OperatorCaptionLbl: Label 'Operator';
        SerialNoCaptionLbl: Label 'Serial No (N/S de la boite)';
        CustomerCaptionLbl: Label 'Customer';
        DeviceTypeCaptionLbl: Label 'Device Type';
        DeviceIDCaptionLbl: Label 'Device ID';
        CustomerInputCaptionLbl: Label 'Customer Input';
        RepairTypeCaptionLbl: Label 'Repair Type';
        WorkPerformedCaptionLbl: Label 'Work performed';
        OperatorSignatureCaptionLbl: Label 'Operator Signature';
        AnalysisBlueBoticsCaptionLbl: Label 'Analysis BlueBotics';
        LangCaptionLbl: Label 'Lang.: E';

        VersionCaptionLbl: Label 'Version: 0.1';
        ItemNoCaptionLbl: Label 'Item No.';
        ItemDescLbl: Label 'Item Description';
        TxtGSymptomDescription: Text;
        TxtGRepairType: Text;
        RecGUserSetup: Record "User Setup";
        RecGTenantMedia: Record "Tenant Media";
        RecGItem: Record Item;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure CalcSignature(var RecPUserSetup: Record "User Setup"; var RecPMediaTenant: Record "Tenant Media")
    var
        IntLIndex: Integer;
    begin
        if RecPUserSetup."BBX Signature".Count = 0 then
            exit
        else
            for IntLIndex := 1 to RecPUserSetup."BBX Signature".Count do begin
                if RecPMediaTenant.Get(RecPUserSetup."BBX Signature".Item(IntLIndex)) then begin
                    RecPMediaTenant.calcfields(Content);
                end;
            end;
    end;
}