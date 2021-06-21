page 50231 "BBX Update Expense Lines"
{
    PageType = Card;
    Caption = 'Update Expense Lines';
    PromotedActionCategories = 'New,Process';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(ExpenseLineFilter; TxtGExpenseLineFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Expense Line Filter';
                    ShowMandatory = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        PagLCEMExpensesList: Page "BBX CEM Expense List";
                        RecLCEMExpense: Record "CEM Expense";
                    begin
                        PagLCEMExpensesList.LookupMode(true);
                        if Not (PagLCEMExpensesList.RunModal() = Action::LookupOK) then
                            exit(false);
                        PagLCEMExpensesList.GetSelectionFilter(RecLCEMExpense);
                        if RecLCEMExpense.FindSet() then begin
                            if Text = '' then
                                Text := Format(RecLCEMExpense."Entry No.")
                            else
                                Text += '|' + Format(RecLCEMExpense."Entry No.");
                        end;
                        exit(true)
                    end;
                }
                field(OptGDocType; OptGDocType)
                {
                    ApplicationArea = all;
                    Caption = 'Expense Account Type';
                    OptionCaption = ' ,G/L Account, Item';
                    ShowMandatory = true;
                }
                field("Item/Account No."; TxtGAccountItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item / G/L Account No.';
                    ShowMandatory = true;
                    Editable = OptGDocType <> OptGDocType::" ";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        PagLGLAccList: Page "G/L Account List";
                        PagLItemList: Page "Item List";
                        LblLExpenseTypeError: Label 'You must Choose a expense account type';
                    begin
                        case OptGDocType of
                            OptGDocType::" ":
                                Error(LblLExpenseTypeError);

                            OptGDocType::"G/L Account":
                                begin
                                    PagLGLAccList.LOOKUPMODE(TRUE);
                                    IF NOT (PagLGLAccList.RUNMODAL = ACTION::LookupOK) THEN
                                        EXIT(FALSE);

                                    Text := PagLGLAccList.GetSelectionFilter;
                                    EXIT(TRUE)
                                end;
                            OptGDocType::Item:
                                begin
                                    PagLItemList.LOOKUPMODE(TRUE);
                                    IF NOT (PagLItemList.RUNMODAL = ACTION::LookupOK) THEN
                                        EXIT(FALSE);

                                    Text := PagLItemList.GetSelectionFilter;
                                    EXIT(TRUE)
                                end;
                        end;
                    end;
                }
                field(GDocumentDate; DatGDocumentDate)
                {
                    ApplicationArea = all;
                    Caption = 'Document Date';

                }

                field(GenBusPostingGroup; CodGGenBusPostingGroup)
                {
                    ApplicationArea = all;
                    Caption = 'Gen. Bus. Posting Group';
                    TableRelation = "Gen. Business Posting Group";
                }
                field(GenProdPostingGroup; CodGGenProdPostingGroup)
                {
                    ApplicationArea = all;
                    Caption = 'Gen. Prod. Posting Group';
                    TableRelation = "Gen. Product Posting Group";
                }
                field(VATProdPostingGroup; CodGVATProdPostingGroup)
                {
                    ApplicationArea = all;
                    Caption = 'VAT Prod. Posting Group';
                    TableRelation = "VAT Product Posting Group";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(UpdateExpenseLine)
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                Caption = 'Update Expense Line';

                trigger OnAction()
                var
                    RecLCEMExpense: Record "CEM Expense";
                    LblLConfirm: Label 'Do you want to update the selected line(s)?';
                    LblUpdateError: Label 'You can not update lines with non empty account type or account no.';
                begin
                    if not Confirm(LblLConfirm) then
                        exit;
                    RecLCEMExpense.SetFilter("Entry No.", TxtGExpenseLineFilter);
                    if RecLCEMExpense.FindSet() then begin

                        if OptGDocType = OptGDocType::"G/L Account" then
                            RecLCEMExpense."Expense Account Type" := RecLCEMExpense."Expense Account Type"::"G/L Account"
                        else
                            if OptGDocType = OptGDocType::Item then
                                RecLCEMExpense."Expense Account Type" := RecLCEMExpense."Expense Account Type"::Item;

                        if TxtGAccountItemNo <> '' then
                            RecLCEMExpense."Expense Account" := TxtGAccountItemNo;

                        if DatGDocumentDate <> 0D then
                            RecLCEMExpense."Document Date" := DatGDocumentDate;

                        if CodGGenBusPostingGroup <> '' then
                            RecLCEMExpense."Gen. Bus. Posting Group" := CodGGenBusPostingGroup;

                        if CodGGenProdPostingGroup <> '' then
                            RecLCEMExpense."Gen. Prod. Posting Group" := CodGGenProdPostingGroup;

                        if CodGVATProdPostingGroup <> '' then
                            RecLCEMExpense."VAT Prod. Posting Group" := CodGVATProdPostingGroup;

                        RecLCEMExpense.Modify(false);
                    end;
                end;
            }
        }
    }

    var
        TxtGAccountItemNo: Text;
        OptGDocType: Option " ","G/L Account",Item;
        TxtGExpenseLineFilter: Text;
        DatGDocumentDate: Date;
        CodGGenBusPostingGroup: Code[20];
        CodGGenProdPostingGroup: Code[20];
        CodGVATProdPostingGroup: Code[20];
}