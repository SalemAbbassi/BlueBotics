pageextension 50223 BBXServiceOrderSubform extends "Service Order Subform"
{
    layout
    {
        addafter(Warranty)
        {
            field("BBX Value"; Rec."BBX Value")
            {
                ApplicationArea = All;
            }
        }
        modify("Symptom Code")
        {
            Visible = true;
        }
    }
}