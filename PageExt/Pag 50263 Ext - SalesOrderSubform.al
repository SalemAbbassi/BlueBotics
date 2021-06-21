pageextension 50263 "BBX Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("BBX Task Type"; Rec."BBX Task Type")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(Reserve)
        {
            action("BBX Ventilation Lines")
            {
                Caption = 'Ventilation Lines';
                ApplicationArea = Basic, Suite;
                Image = SetupList;
                trigger OnAction()
                var
                    PagLVentilationList: Page "BBX Ventilation Lines";
                    RecLVent: Record "BBX Ventilation Lines";
                begin
                    PagLVentilationList.SetValues(Rec."Document No.", Rec."Line No.", Rec."No.", Rec.Amount);
                    PagLVentilationList.RunModal();
                end;
            }
        }
    }
}