pageextension 50246 "BBX EnteringJobTimes" extends "DBE Entering Job times"
{
    layout
    {
        modify("Customer No.")
        {
            Visible = false;
        }
        modify("Customer Name")
        {
            Visible = false;
        }
        modify("DBE Job Task Company To Inv")
        {
            Visible = false;
        }
        modify("Task Description")
        {
            Visible = false;
            Enabled = false;
        }
        modify(Description)
        {
            Visible = false;
        }
        modify("Description 2")
        {
            Visible = false;
        }
        modify("Job No.")
        {
            Visible = false;
        }
        modify("Job Task No.")
        {
            Visible = false;
        }
        addafter("Job No.")
        {
            field("BBX JobNo"; CodGJob)
            {
                caption = 'Job No.';
                Style = Strong;
                StyleExpr = Rec."Qty. Posted" <> 0;
                ApplicationArea = all;
                TableRelation = Job."No." WHERE(Status = FILTER(<> Completed));

                trigger OnValidate()
                begin
                    Rec.VALIDATE("Job No.", CodGJob);
                    Rec.CalcFields("DBE Job Description");
                    TxtGJobDescription := Rec."DBE Job Description";
                end;
            }

            field("BBX Job Description"; TxtGJobDescription)//Rec."BBX Job Description")
            {
                Caption = 'Job Description';
                ApplicationArea = All;
                Editable = false;
            }

            field("BBX CodGJobTask"; CodGJobTask)
            {
                Caption = 'Job Task No.';
                StyleExpr = Rec."Qty. Posted" <> 0;
                ApplicationArea = all;
                TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."), "DBE Status" = const("In Progress"));

                trigger OnValidate()
                var
                    RecLDBEPlace: Record "DBE Place";
                begin
                    Rec.VALIDATE("Job Task No.", CodGJobTask);
                    RecLDBEPlace.SetRange("BBX Default", True);
                    if RecLDBEPlace.FindFirst() then
                        Rec.Validate("DBE Place", RecLDBEPlace.Code);
                    //if (Rec."DBE Company To Invoice" in ['', CompanyName]) then
                    CurrPage.SAVERECORD;

                    Rec.CalcFields("DBE Task Description");
                    TxtGJobTaskDescription := Rec."DBE Task Description";
                end;
            }
        }
        addafter("DBE ending Time")
        {
            field("BBX Comment"; Rec."BBX Comment")
            {
                ApplicationArea = all;
            }
        }
        modify(CodGResourceNo)
        {
            Editable = false;
        }
        addafter("Task Description")
        {
            field("BBX Task Descirption"; TxtGJobTaskDescription)
            {
                ApplicationArea = all;
                Caption = 'Job Task Description';
                Editable = false;
            }
        }
        addafter(TimesFactbox)
        {
            part(BonusMalusFactBox; "BBX Times Bonus Malus")
            {
                Caption = 'Bonus / Malus';
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        modify(Resource)
        {
            Visible = false;
            Enabled = false;
        }
        modify("Previous Resource")
        {
            Visible = false;
        }
        modify("Next Resource")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.BonusMalusFactBox.Page.FctSetParameters(Rec."No.", Rec."Planning Date");
    end;

    trigger OnafterGetRecord()
    begin
        CodGJob := Rec."Job No.";
        CodGJobTask := Rec."Job Task No.";
        Rec.CalcFields("DBE Job Description");
        TxtGJobDescription := Rec."DBE Job Description";
        Rec.CalcFields("DBE Task Description");
        TxtGJobTaskDescription := Rec."DBE Task Description";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CodGJob := '';
        CodGJobTask := '';
        Clear(TxtGJobDescription);
        Clear(TxtGJobTaskDescription);
    end;

    var
        CodGJob: Code[20];
        CodGJobTask: Code[20];
        TxtGJobDescription: Text[100];
        TxtGJobTaskDescription: Text[100];
}