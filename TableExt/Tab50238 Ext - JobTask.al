tableextension 50238 BBXJobTask extends "Job Task"
{
    fields
    {
        // Add changes to table fields here
        field(50200; "BBX Standby From"; Date)
        {
            Caption = 'Standby From';
        }
        field(50201; "BBX New Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ","Pending","In progress","Canceled","Stand By","Finished";
            OptionCaption = ' ,Pending,In progress,Canceled,Stand By,Finished';
            trigger OnValidate()
            begin
                if xRec."BBX New Status" <> Rec."BBX New Status" then begin
                    "BBX Standby From" := 0D;
                    case "BBX New Status" of
                        "BBX New Status"::" ":
                            "DBE Status" := "DBE Status"::" ";
                        "BBX New Status"::Pending:
                            "DBE Status" := "DBE Status"::Pending;
                        "BBX New Status"::"In progress":
                            "DBE Status" := "DBE Status"::"In progress";
                        "BBX New Status"::Canceled:
                            "DBE Status" := "DBE Status"::Canceled;
                        "BBX New Status"::Finished:
                            "DBE Status" := "DBE Status"::"Finished/In Prod";
                        "BBX New Status"::"Stand By":
                            begin
                                "DBE Status" := "DBE Status"::" ";
                                "BBX Standby From" := DT2Date(CurrentDateTime);
                            end;
                    end;
                end;
            end;
        }
        field(50202; "BBX Task Type"; Code[20])
        {
            Caption = 'Task Type';
            TableRelation = "BBX Task Types".Code;
        }

    }

    var
        myInt: Integer;
}