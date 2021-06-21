pageextension 50270 "BBX Job Queue Entries" extends "Job Queue Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("BBX Notification Sent"; Rec."BBX Notification Sent")
            {
                ApplicationArea = All;
            }
        }
    }
}