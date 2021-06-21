codeunit 50202 "BBX Workflow"
{
    trigger OnRun();
    begin
    end;

    var
        CstG0001: label 'Calculate Claim percent';

    local procedure CalcClaim2PercentWorkflowResponseCode(): Code[128];
    begin
        exit(UPPERCASE('BBC_CalcClaim2Percent'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure SendMailWorkflowResponsesToLibrary();
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(CalcClaim2PercentWorkflowResponseCode, 0, CstG0001, 'GROUP 4');
    end;

    local procedure CalcClaim2PercentWorkflowResponse(VarPVariant: Variant; RecPResponseWorkflowStepInstance: Record "Workflow Step Instance");
    var
        ApprovalEntry: Record "Approval Entry";
        ExpenseHeader: Record "CEM Expense Header";
        Rcf: RecordRef;
        Rcf2: RecordRef;
        RecLWorkflowStepArgument: Record "Workflow Step Argument";
        CduLBlueBoticsFunctionMgt: codeunit "BBX Function Mgt";
    begin
        RecLWorkflowStepArgument.GET(RecPResponseWorkflowStepInstance.Argument);
        Rcf.GETTABLE(VarPVariant);
        case Rcf.NUMBER of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := VarPVariant;
                    Rcf2.Get(ApprovalEntry."Record ID to Approve");
                    Rcf2.SetTable(ExpenseHeader);
                    CduLBlueBoticsFunctionMgt.CalcClaim2Percent(ExpenseHeader);
                end;
            DATABASE::"CEM Expense Header":
                begin
                    ExpenseHeader := VarPVariant;
                    CduLBlueBoticsFunctionMgt.CalcClaim2Percent(ExpenseHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure ExecuteSendMailResponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance");
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        if WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") then
            case WorkflowResponse."Function Name" of
                CalcClaim2PercentWorkflowResponseCode:
                    begin
                        CalcClaim2PercentWorkflowResponse(Variant, ResponseWorkflowStepInstance);
                        ResponseExecuted := true;
                    end;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddSendMailEventResponseCombinationsToLibrary(ResponseFunctionName: Code[128]);
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        //Disponible dans tous les cas
        case ResponseFunctionName of
        end;
    end;
}

