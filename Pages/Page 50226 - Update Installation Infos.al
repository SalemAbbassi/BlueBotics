page 50226 "BBX Update Installtion Infos"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Serial No. Information";
    Caption = 'Update Informations';

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("License No."; TxtGLicenceNo)
                {
                    Caption = 'Licence No.';
                    TableRelation = "License Information";
                    ApplicationArea = all;
                }
                field("Installation Name"; TxtGInstallationName)
                {
                    Caption = 'Installation Name';
                    ApplicationArea = all;
                }
                field("Installtion Address"; TxtGInstalltionAddress)
                {
                    Caption = 'Installation Address';
                    ApplicationArea = all;
                }
                field(IntGQuantityOfVehicles; IntGQuantityOfVehicles)
                {
                    Caption = 'Quantity Of Vehicles';
                    ApplicationArea = all;
                }
                field("Requested By"; TxtGRequestedBy)
                {
                    Caption = 'Requested By';
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then
            if Confirm(LblGConfirmMsg) then begin
                if TxtGLicenceNo <> '' then
                    Rec.ModifyAll("BBX License No.", TxtGLicenceNo);
                if TxtGInstallationName <> '' then
                    Rec.ModifyAll("BBX Installation Name", TxtGInstallationName);
                if TxtGInstalltionAddress <> '' then
                    Rec.ModifyAll("BBX Installation Address", TxtGInstalltionAddress);
                if TxtGRequestedBy <> '' then
                    Rec.ModifyAll("BBX Requested By", TxtGRequestedBy);
                if IntGQuantityOfVehicles <> 0 then
                    Rec.ModifyAll("BBX Quantity Of Vehicles", IntGQuantityOfVehicles);
            end;
    end;

    var
        TxtGInstalltionAddress: Text[100];
        TxtGInstallationName: Text[100];
        TxtGLicenceNo: Text[250];
        TxtGRequestedBy: Text[150];
        IntGQuantityOfVehicles: Integer;
        LblGConfirmMsg: Label 'Do you want to update the selected line(s)?';
}