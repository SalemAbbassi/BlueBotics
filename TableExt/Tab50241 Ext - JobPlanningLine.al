tableextension 50241 "BBX Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(50210; "BBX Task Type"; Code[20])
        {
            Caption = 'Task Type';
            TableRelation = "BBX Task Types".Code;
        }
        field(50250; "BBX Job Description"; Text[100])
        {
            Caption = 'Job Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Description where("No." = field("Job No.")));
        }
        field(50251; "BBX Comment"; text[100])
        {
            Caption = 'Comment';
        }
    }
}