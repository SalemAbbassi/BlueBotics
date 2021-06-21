page 50204 "BBX Insert Repair Template Act"
{
    PageType = Card;
    Caption = 'Insert Repair Template Activities';
    layout
    {
        area(Content)
        {
            field("Repair Template Code"; CodGRepairTemplateCode)
            {
                ApplicationArea = All;
                TableRelation = "BBX Repair Template";
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RecRef: RecordRef;
        RecLServiceItemLine: Record "Service Item Line";
        FieldRef: FieldRef;
        CodLDocumentNo: Code[20];
        IntLLineNo: Integer;
        OptLdocumentType: Option Quote,Order,Invoice,"Credit Memo";
    begin
        IF CloseAction = ACTION::LookupOK THEN BEGIN
            IF BooGValuesFromServiceItemLine THEN
                CduGBlueBoticsFunctionMgt.InsertRepairTemplateActivitiesFromServiceItemLine(RecGServiceItemLine, CodGRepairTemplateCode)
            ELSE
                CduGBlueBoticsFunctionMgt.InsertRepairTemplateActivitiesFromServiceLine(RecGServiceLine, CodGRepairTemplateCode);
        END;
    end;

    var
        CodGRepairTemplateCode: Code[20];
        CduGBlueBoticsFunctionMgt: Codeunit "BBX Function Mgt";
        BooGValuesFromServiceItemLine: Boolean;
        RecGServiceItemLine: Record "Service Item Line";
        RecGServiceLine: Record "Service Line";

    procedure FctSetParametersFromServiceItemLine(RecPServiceItemLine: Record "Service Item Line")
    begin
        RecGServiceItemLine.COPY(RecPServiceItemLine);
        BooGValuesFromServiceItemLine := TRUE;
        ;
    end;

    procedure FctSetParametersFromServiceLine(RecPServiceLine: Record "Service Line")
    begin
        RecGServiceLine.COPY(RecPServiceLine);
        BooGValuesFromServiceItemLine := FALSE;
    end;
}