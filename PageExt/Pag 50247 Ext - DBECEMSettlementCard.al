pageextension 50247 BBXCEMSettlementCard extends "CEM Settlement Card"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BBX DatGPostingDate"; DatGPostingDate)
            {
                ApplicationArea = All;
                Caption = 'New Posting Date';
                Importance = Promoted;
                trigger OnValidate()
                begin
                    Rec.Validate("Posting Date", DatGPostingDate);
                    Rec.TESTFIELD(Posted, FALSE);
                    Rec.Modify(false);
                    CurrPage.Update(false);
                end;
            }
        }
        modify("Posting Date")
        {
            Visible = false;
        }
    }
    /*  actions
      {
          addlast(Settlement)
          {
              action(ModifyPostingDate)
              {
                  ApplicationArea = All;
                  Caption = 'Modify Posting Date';
                  Promoted = true;
                  Image = ChangeDate;
                  trigger OnAction()
                  begin
                      Rec.Validate("Posting Date");
                  end;
              }
          }
      }*/
    trigger OnAfterGetRecord()
    var
    begin
        DatGPostingDate := Rec."Posting Date";
    end;

    var
        DatGPostingDate: Date;
}