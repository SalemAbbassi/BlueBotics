tableextension 50246 "BBX Job Queue Log Entry" extends "Job Queue Log Entry"
{
    fields
    {
        field(50200; "BBX Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
        }
    }

    var
        myInt: Integer;
}