page 50205 "BBX Symptom Codes List"
{
    PageType = List;
    SourceTable = "BBX Symptom";
    ApplicationArea = Administration;
    UsageCategory = Administration;
    Caption = 'Symptom Codes';

    layout
    {
        area(Content)
        {
            repeater(content1)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Descrption; Rec.Descrption)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}