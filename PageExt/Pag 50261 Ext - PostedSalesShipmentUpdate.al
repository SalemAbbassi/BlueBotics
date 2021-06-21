pageextension 50261 "BBX Posted Sales Ship Update" extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter(Shipping)
        {
            group(Packing)
            {
                Caption = 'Packaging';

                field("BBX Parcel 1 Size"; Rec."BBX Parcel 1 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 2 Size"; Rec."BBX Parcel 2 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 3 Size"; Rec."BBX Parcel 3 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 4 Size"; Rec."BBX Parcel 4 Size")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 1 Weight"; Rec."BBX Parcel 1 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 2 Weight"; Rec."BBX Parcel 2 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 3 Weight"; Rec."BBX Parcel 3 Weight")
                {
                    ApplicationArea = All;
                }
                field("BBX Parcel 4 Weight"; Rec."BBX Parcel 4 Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}