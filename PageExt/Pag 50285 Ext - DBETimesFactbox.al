pageextension 50285 "BBX Times Factbox" extends "DBE Times Factbox"
{
    layout
    {
        modify(DecGHourDayPlanned)
        {
            Visible = false;
        }
        modify(DecGHourPeriodPlanned)
        {
            Visible = false;
        }
    }
}