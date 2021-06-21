tableextension 50245 "BBX Transfer Shipment Header" extends "Transfer Shipment Header"
{
    fields
    {
        field(50200; "BBX Shipment Cost CHF"; Decimal)
        {
            Caption = 'Shipment Cost [CHF]';
        }
        field(50201; "BBX Not Shippable"; Boolean)
        {
            Caption = 'Not Shippable';
        }
        field(50202; "BBX Proof of export Enum"; Enum "BBX Proof Of Export")
        {
            Caption = 'Proof of export';
        }
        field(50203; "BBX EUR1 Enum"; Enum "BBX EUR1")
        {
            Caption = 'EUR1';
        }
        field(50204; "BBX Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
        }
        field(50205; "BBX Shipment received"; Boolean)
        {
            Caption = 'Shipment received';
        }
        field(50215; "BBX Parcel 1 Size"; Text[50])
        {
            Caption = 'Parcel 1 Size';
            TableRelation = "BBX Packaging".Size;
            ValidateTableRelation = false;
        }
        field(50216; "BBX Parcel 1 Weight"; Decimal)
        {
            Caption = 'Parcel 1 Weight';
        }
        field(50217; "BBX Parcel 2 Size"; Text[50])
        {
            Caption = 'Parcel 2 Size';
            TableRelation = "BBX Packaging".Size;
            ValidateTableRelation = false;
        }
        field(50218; "BBX Parcel 2 Weight"; Decimal)
        {
            Caption = 'Parcel 2 Weight';
        }
        field(50219; "BBX Parcel 3 Size"; Text[50])
        {
            Caption = 'Parcel 3 Size';
            TableRelation = "BBX Packaging".Size;
            ValidateTableRelation = false;
        }
        field(50220; "BBX Parcel 3 Weight"; Decimal)
        {
            Caption = 'Parcel 3 Weight';
        }
        field(50221; "BBX Parcel 4 Size"; Text[50])
        {
            Caption = 'Parcel 4 Size';
            TableRelation = "BBX Packaging".Size;
            ValidateTableRelation = false;
        }
        field(50222; "BBX Parcel 4 Weight"; Decimal)
        {
            Caption = 'Parcel 4 Weight';
        }
        field(50223; "BBX Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
        }

    }
}