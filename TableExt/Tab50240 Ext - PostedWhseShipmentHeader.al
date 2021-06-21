tableextension 50240 BBXPostedWhseShipmentHeader extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50200; "BBX Parcel 1 Size"; Text[50])
        {
            Caption = 'Parcel 1 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50201; "BBX Parcel 1 Weight"; Decimal)
        {
            Caption = 'Parcel 1 Weight';
        }
        field(50202; "BBX Parcel 2 Size"; Text[50])
        {
            Caption = 'Parcel 2 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50203; "BBX Parcel 2 Weight"; Decimal)
        {
            Caption = 'Parcel 2 Weight';
        }
        field(50204; "BBX Parcel 3 Size"; Text[50])
        {
            Caption = 'Parcel 3 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50205; "BBX Parcel 3 Weight"; Decimal)
        {
            Caption = 'Parcel 3 Weight';
        }
        field(50206; "BBX Parcel 4 Size"; Text[50])
        {
            Caption = 'Parcel 4 Size';
            TableRelation = "BBX Packaging".Size;
        }
        field(50207; "BBX Parcel 4 Weight"; Decimal)
        {
            Caption = 'Parcel 4 Weight';
        }
        field(50208; "BBX Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."Source No." where("No." = field("No.")));
        }
        field(50209; "BBX Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
            CalcFormula = lookup("Sales Header"."Sell-to Customer No." where("Document Type" = const(Order),
                                                                            "No." = field("BBX Source No.")));
        }
        field(50210; "BBX Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("Document Type" = const(Order),
                                                                            "No." = field("BBX Source No.")));
        }
        field(50212; "BBX Project Manager"; Code[50])
        {
            Caption = 'Project Manager';
            TableRelation = "User Setup";
        }
        field(50213; "BBX Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
        }
    }
}