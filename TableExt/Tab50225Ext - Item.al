tableextension 50225 BBXItem extends Item
{
    fields
    {
        field(50200; BBXVendorName; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
        }
        field(50201; "BBXPilot"; Boolean)
        {
            Caption = 'Pilot';
        }
        field(50202; "BBX Task Type"; Code[20])
        {
            Caption = 'Task Types';
            TableRelation = "BBX Task Types".Code;
        }
        field(50203; "BBX Automatic Delivery"; Boolean)
        {
            Caption = 'Automatic Delivery';
        }
    }
}