pageextension 50228 BBXTransferOrder extends "Transfer Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BBX Sales Order No."; Rec."BBX Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("BBX Validated By"; Rec."BBX Validated By")
            {
                ApplicationArea = All;
            }
            field("BBX Validated"; Rec."BBX Validated")
            {
                ApplicationArea = All;
            }
        }
        addlast(Shipment)
        {

            field("BBX Package Tracking No."; Rec."BBX Package Tracking No.")
            {
                ToolTip = 'Specifies the value of the Package Tracking No. field';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}