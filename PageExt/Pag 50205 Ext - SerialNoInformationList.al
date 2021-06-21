pageextension 50205 "BBX SerialNoInformationListExt" extends "Serial No. Information List"
{
    layout
    {
        //>>PRO-GC22
        addlast(Control1)
        {
            field("BBX Requested By"; Rec."BBX Requested By")
            {
                ApplicationArea = All;
            }
            field("BBX Quantity Of Vehicles"; Rec."BBX Quantity Of Vehicles")
            {
                ApplicationArea = All;
            }
            field("BBX BootFile"; Rec."BBX BootFile")
            {
                ApplicationArea = All;
            }
            field("BBX Customer ID"; Rec."BBX Customer ID")
            {
                ApplicationArea = All;
            }
            field(BBXKey; Rec.BBXKey)
            {
                ApplicationArea = All;
            }
            field("BBXTest Date"; Rec."BBXTest Date")
            {
                ApplicationArea = All;
            }
            field("BBXIO Board Firmware"; Rec."BBXIO Board Firmware")
            {
                ApplicationArea = All;
            }
            field("BBX License No."; Rec."BBX License No.")
            {
                ApplicationArea = All;
            }
            field("BBX Installation Name"; Rec."BBX Installation Name")
            {
                ApplicationArea = All;
            }
            field("BBX Installation Address"; Rec."BBX Installation Address")
            {
                ApplicationArea = All;
            }


        }
        //<<PRO-GC22
    }
    actions
    {
        addafter("&Item Tracing")
        {
            action("BBX Update Installation Info.")
            {
                Caption = 'Update Installation Infos';
                Image = UpdateDescription;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    RecLSerialNoInfo: Record "Serial No. Information";
                    PageLUpdateInfo: Page "BBX Update Installtion Infos";
                begin
                    RecLSerialNoInfo.Reset();
                    CurrPage.SetSelectionFilter(RecLSerialNoInfo);
                    PageLUpdateInfo.SetTableView(RecLSerialNoInfo);
                    PageLUpdateInfo.RunModal();
                    CurrPage.Update();
                end;
            }
        }
    }
}