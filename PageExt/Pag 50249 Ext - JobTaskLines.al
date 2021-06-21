pageextension 50249 BBXJobTaskLines extends "Job Task Lines"
{
    trigger Onopenpage()
    begin
        Rec.SetRange("DBE Status", Rec."DBE Status"::"In progress");
    end;
}