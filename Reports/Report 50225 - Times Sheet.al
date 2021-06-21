report 50225 "BBX Times Sheet"
{
    // version INV1.00,DBE1.00

    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.fr/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // INV01 : ARH 08/08/2018 : Invoicing Job
    //              - Creation
    // 
    // +----------------------------------------------------------------------------------------------------------------+
    DefaultLayout = Word;
    WordLayout = './BlueBotics Times Sheet.docx';
    WordMergeDataItem = Job;

    Caption = 'Times Sheet';

    dataset
    {
        dataitem(Job; Job)
        {
            RequestFilterFields = "No.", "Planning Date Filter";
            column(Job_No; "No.")
            {
            }
            column(Job_No_Caption; CstG001)
            {
            }
            column(Job_Description; Description)
            {
            }
            column(Job_BillToCustomerNo; "Bill-to Customer No.")
            {
            }
            column(Job_BillToCustomerName_Caption; FIELDCAPTION("Bill-to Name"))
            {
            }
            column(Job_BillToCustomerName; "Bill-to Name")
            {
            }
            column(Job_PersonResponsibleName_Caption; CstG002)
            {
            }
            column(Job_PersonResponsibleName; RecGResource.Name)
            {
            }
            column(Job_ProjectManager_Caption; FieldCaption("Project Manager"))
            {
            }
            column(Job_ProjectManager; RecGUser."Full Name")
            {
            }
            column(HoursInvoicables; STRSUBSTNO(CstG003, DecGHoursInvoicables))
            {
            }
            column(HoursNotInvoicables; STRSUBSTNO(CstG004, DecGHoursNotInvoicables))
            {
            }
            column(HoursInvoicableLater; STRSUBSTNO(CstG005, DecGHoursInvoicablesLater))
            {
            }
            column(HoursPosted; STRSUBSTNO(CstG006, DecGHoursPosted))
            {
            }
            column(HoursMilestone; STRSUBSTNO(CstG010, DecGHoursMilestone))
            {
            }
            column(Title_Caption; TxtGTitleCaption)
            {
            }
            column(Totaux_Caption; CstG008)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyFooter1; CompanyFooter[1])
            {
            }
            column(CompanyFooter2; CompanyFooter[2])
            {
            }
            column(CompanyFooter3; CompanyFooter[3])
            {
            }
            column(CompanyFooter4; CompanyFooter[4])
            {
            }
            column(CompanyFooter5; CompanyFooter[5])
            {
            }
            column(CompanyFooter6; CompanyFooter[6])
            {
            }
            column(CompanyFooter7; CompanyFooter[7])
            {
            }
            column(CompanyFooter8; CompanyFooter[8])
            {
            }
            dataitem("Job planning Line"; "Job planning Line")
            {
                DataItemLink = "Job no." = FIELD("No."), "Planning date" = FIELD("Planning Date Filter");
                DataItemTableView = SORTING("Job No.", "Planning date", "DBE Invoice Status") where(type = filter(resource), "Qty. Posted" = filter(<> 0));
                column(Detail_Date_Caption; FIELDCAPTION("Planning date"))
                {
                }
                column(Detail_Date; FORMAT("Planning date", 0, '<Day,2>.<Month,2>.<Year4>'))
                {
                }
                column(Detail_ResourceNo_Caption; FIELDCAPTION("No."))
                {
                }
                column(Detail_ResourceName_Caption; RecGResource2.FIELDCAPTION(Name))
                {
                }
                column(Detail_ResourceName; RecGResource2.Name)
                {
                }
                column(Detail_ResourceNo; "No.")
                {
                }
                column(Detail_JobTaskNo_Caption; FIELDCAPTION("Job Task No."))
                {
                }
                column(Detail_JobTaskNo; "Job Task No.")
                {
                }
                column(Detail_TaskDescription_Caption; FIELDCAPTION("DBE Task Description"))
                {
                }
                column(Detail_Comment_Caption; FieldCaption("BBX Comment"))
                {
                }
                column(Detail_comment; "BBX comment")
                {
                }
                column(Detail_TaskDescription; "DBE Task Description")
                {
                }
                column(Detail_Description_Caption; FIELDCAPTION(Description))
                {
                }
                column(Detail_Description; Description)
                {
                }
                column(Detail_Description2_Caption; FIELDCAPTION("Description 2"))
                {
                }
                column(Detail_Description2; "Description 2")
                {
                }
                column(Detail_Quantity_Caption; FIELDCAPTION("Quantity"))
                {
                }
                column(Detail_Quantity; "Qty. Posted")
                {
                }
                column(Detail_QuantityInvoiced_Caption; FIELDCAPTION("DBE Quantity Invoiced"))
                {
                }
                column(Detail_QuantityInvoiced; "DBE Quantity Invoiced")
                {
                }
                column(Detail_InvoiceStatus_Caption; FIELDCAPTION("DBE Invoice Status"))
                {
                }
                column(Detail_InvoiceStatus; "DBE Invoice Status")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if not RecGResource2.Get("No.") then RecGResource2.Init();
                end;
            }

            trigger OnAfterGetRecord();
            var
                RecLJobPlanningLine: Record "Job Planning Line";
                DatLMonth: Date;
            begin
                if not RecGResource.GET("Person Responsible") then RecGResource.INIT;
                RecGUser.SetRange("User Name", "Project Manager");
                if not RecGUser.FindFirst() then RecGUser.Init();


                RecLJobPlanningLine.SETCURRENTKEY("Job No.", "Planning date", "DBE Invoice Status");
                RecLJobPlanningLine.SETRANGE("Job No.", Job."No.");
                RecLJobPlanningLine.SETFILTER("Planning date", Job.GETFILTER(Job."Planning Date Filter"));
                RecLJobPlanningLine.SetFilter("Qty. Posted", '<>%1', 0);
                RecLJobPlanningLine.SETRANGE("DBE Invoice Status", RecLJobPlanningLine."DBE Invoice Status"::Invoicable);
                RecLJobPlanningLine.CALCSUMS("DBE Quantity Invoiced");
                DecGHoursInvoicables := RecLJobPlanningLine."DBE Quantity Invoiced";

                RecLJobPlanningLine.SETFILTER("DBE Invoice Status", '%1|%2', RecLJobPlanningLine."DBE Invoice Status"::"Not Invoicable", RecLJobPlanningLine."DBE Invoice Status"::Invoicable);
                RecLJobPlanningLine.CALCSUMS("Qty. Posted");
                DecGHoursNotInvoicables := RecLJobPlanningLine."Qty. Posted" - RecLJobPlanningLine."DBE Quantity Invoiced";

                RecLJobPlanningLine.SETRANGE("DBE Invoice Status", RecLJobPlanningLine."DBE Invoice Status"::"Invoicable + later");
                RecLJobPlanningLine.CALCSUMS("Qty. Posted");
                DecGHoursInvoicablesLater := RecLJobPlanningLine."Qty. Posted";

                RecLJobPlanningLine.SETRANGE("DBE Invoice Status");
                RecLJobPlanningLine.CALCSUMS("Qty. Posted");
                DecGHoursPosted := RecLJobPlanningLine."Qty. Posted";

                RecLJobPlanningLine.SETRANGE("DBE Invoice Status", RecLJobPlanningLine."DBE Invoice Status"::Milestone);
                RecLJobPlanningLine.CALCSUMS("Qty. Posted");
                DecGHoursMilestone := RecLJobPlanningLine."Qty. Posted";

                DatLMonth := Job.GETRANGEMIN("Planning Date Filter");
                TxtGTitleCaption := STRSUBSTNO(CstG007, UPPERCASE(FORMAT(DatLMonth, 0, '<Month Text> <Year4>')));
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

                // Company INFOS FOOTER
                CompanyFooter[1] := CompanyInfo.Name + ' - ';
                CompanyFooter[2] := CompanyInfo."Name 2" + ' - ';
                CompanyFooter[3] := CompanyInfo.Address + ' - ';
                CompanyFooter[4] := CompanyInfo."Country/Region Code" + ' - ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' - ';
                CompanyFooter[5] := CompanyInfo."Phone No." + ' - ';
                CompanyFooter[6] := CompanyInfo."Home Page" + ' - ';
                CompanyFooter[7] := CompanyInfo."E-Mail";
                COMPRESSARRAY(CompanyFooter);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage();

        begin
            //Job.SETFILTER("Planning Date Filter", FORMAT(CALCDATE('<-CM-1D-CM>', TODAY)) + '..' + FORMAT(CALCDATE('<-CM-1D>', TODAY)));
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        var
            RecLJobPlanningLine: Record "Job Planning Line";
        begin
            /*RecLJobPlanningLine.RESET;
            RecLJobPlanningLine.SETCURRENTKEY("Job No.", "Planning Date", "DBE Invoice Status");
            RecLJobPlanningLine.SETRANGE("Job No.", Job.GETFILTER("No."));
            RecLJobPlanningLine.SETFILTER("Job No.", Job.GETFILTER("Planning Date Filter"));
            if RecLJobPlanningLine.IsEmpty() then
                ERROR(CstG009, RecLJobPlanningLine.GETFILTERS);*/
        end;
    }

    labels
    {
    }

    var
        CstG001: label 'Job No.';
        CstG002: label 'Accountable';
        RecGResource: Record Resource;
        RecGResource2: Record Resource;
        CstG003: label '%1 Hour(s) Invoicable(s)';
        CstG004: label '%1 Hour(s) Not Invoicable(s)';
        CstG005: label '%1 hour(s) Invoicable(s) + later';
        CstG006: label '%1 hour(s) Posted';
        DecGHoursInvoicables: Decimal;
        DecGHoursNotInvoicables: Decimal;
        DecGHoursInvoicablesLater: Decimal;
        DecGHoursPosted: Decimal;
        CstG007: label 'TIME SHEET OF THE MONTH OF %1';
        TxtGTitleCaption: Text;
        CstG008: label 'TOTALS';
        CstG009: label 'No schedule lines for this period.\%1';
        DecGHoursMilestone: Decimal;
        CstG010: label '%1 hour(s) Milestone';
        CompanyInfo: Record "Company Information";
        CompanyFooter: array[10] of Text;
        RecGUser: Record "User";
    /*procedure GetJobComments(): Text
    var
        RecLCommentLine: Record "Comment Line";
    begin
        RecLCommentLine.SetRange("Table Name", RecLCommentLine."Table Name"::Job);
        RecLCommentLine.SetRange("No.", );
    end;*/
}

