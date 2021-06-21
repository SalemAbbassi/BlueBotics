tableextension 50248 "BBX Resource" extends Resource
{
    fields
    {
        field(50200; "BBX Task type"; Code[20])
        {
            Caption = 'Task Type';
            TableRelation = "BBX Task Types".Code;
        }
    }
}