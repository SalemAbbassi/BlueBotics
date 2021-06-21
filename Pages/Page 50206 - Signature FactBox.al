page 50206 "BBX Signature Factbox"
{
    Caption = 'Signature';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            field(Signature; Rec."BBX Signature")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the signature of the user.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                begin
                    FctImportPicture();
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                begin
                    FctExportPicture();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."BBX Signature");
                    Rec.Modify(true);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a customer name before you can import a picture.';

    local procedure FctImportPicture();
    var
        PicInStream: InStream;
        FromFileName: Text;
    begin
        if Rec."BBX Signature".Count <> 0 then
            if not Confirm(OverrideImageQst) then
                exit;
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, PicInStream) then begin
            Clear(Rec."BBX Signature");
            Rec."BBX Signature".ImportStream(PicInStream, FromFileName);
            Rec.Modify(true);
        end;
    end;

    local procedure FctExportPicture();
    var
        PicInStream: InStream;
        Index: Integer;
        TenantMedia: Record "Tenant Media";
        FileName: Text;
    begin
        if Rec."BBX Signature".Count = 0 then
            exit;
        for Index := 1 to Rec."BBX Signature".Count do begin
            if TenantMedia.Get(Rec."BBX Signature".Item(Index)) then begin
                TenantMedia.calcfields(Content);
                if TenantMedia.Content.HasValue then begin
                    FileName := Rec.TableCaption + '_Image' + format(Index) + GetTenantMediaFileExtension(TenantMedia);
                    TenantMedia.Content.CreateInStream(PicInstream);
                    DownloadFromStream(PicInstream, '', '', '', FileName);
                end;
            end;
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."BBX Signature".Count <> 0;
    end;

    local procedure GetTenantMediaFileExtension(var TenantMedia: Record "Tenant Media"): Text;
    begin
        case TenantMedia."Mime Type" of
            'image/jpeg':
                exit('.jpg');
            'image/png':
                exit('.png');
            'image/bmp':
                exit('.bmp');
            'image/gif':
                exit('.gif');
            'image/tiff':
                exit('.tiff');
            'image/wmf':
                exit('.wmf');
        end;
    end;
}

