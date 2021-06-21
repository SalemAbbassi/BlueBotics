tableextension 50208 BBXItemJournalLineExt extends "Item Journal Line"
{
    fields
    {
        //>>VTE-Gap01
        field(50200; "BBX Effective date"; Date)
        {
            Caption = 'Effective date';
        }
        field(50201; "BBX Due Date"; Date)
        {
            Caption = 'Due date';
        }
        //<<VTE-Gap01

        //>>PRO-GC22
        field(50202; "BBX BootFile"; Text[100])
        {
            Caption = 'BootFile';
        }
        //<<PRO-GC22
    }
}