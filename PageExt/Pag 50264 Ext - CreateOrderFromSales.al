pageextension 50264 "BBX Create Order From Sales" extends "Create Order From Sales"
{
    layout
    {
        modify(Status)
        {
            OptionCaption = ',Planned,Firm Planned';
        }
    }

    actions
    {
    }
}