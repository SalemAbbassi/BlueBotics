pageextension 50230 BBXTransferOrderSubform extends "Transfer Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BBX Sales Line No."; Rec."BBX Sales Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {

            field("BBX Value"; Rec."BBX Value")
            {
                ToolTip = 'Specifies the value of the Value field';
                ApplicationArea = All;
            }
            field("BBX Currency Code"; Rec."BBX Currency Code")
            {
                ToolTip = 'Specifies the value of the Currency Code field';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}