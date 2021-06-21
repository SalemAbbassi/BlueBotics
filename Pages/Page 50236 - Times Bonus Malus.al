page 50236 "BBX Times Bonus Malus"
{
    PageType = CardPart;
    ApplicationArea = Tasks;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Day)
            {
                Caption = 'Day';
                Visible = false;
                field(BBXDayBonusMalus; StrSubstNo(LblGBonusMalus, DecGDayBonusMalus))
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    StyleExpr = TxtGDayStyle;
                }
            }
            group(Period)
            {
                Caption = 'Month';
                Visible = false;
                field(BBXPriodBonusMalus; StrSubstNo(LblGBonusMalus, DecGPeriodBonusMalus))
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    StyleExpr = TxtGPeriodStyle;
                }
            }
            group(Year)
            {
                Caption = 'Year';
                ShowCaption = false;
                field(BBXYearBonusMalus; StrSubstNo(LblGBonusMalus, DecGYearBonusMalus))
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    StyleExpr = TxtGYearStyle;
                }
            }
        }
    }

    var
        DecGBaseCapacityDay: Decimal;
        DecGHourCapacityDay: Decimal;
        DecGBaseDayPosted: Decimal;
        DecGHourDayPosted: Decimal;
        DecGDayBonusMalus: Decimal;
        DecGPeriodBonusMalus: Decimal;

        DecGBasePeriodPlanned: Decimal;
        DecGHourPeriodPlanned: Decimal;
        DecGBasePeriodPosted: Decimal;
        DecGHourPeriodPosted: Decimal;
        DecGBaseYearPlanned: Decimal;
        DecGHourYearPlanned: Decimal;
        DecGBaseYearPosted: Decimal;
        DecGHourYearPosted: Decimal;
        DecGYearBonusMalus: Decimal;
        DecGBaseCapacityPeriod: Decimal;
        DecGHourCapacityPeriod: Decimal;
        DecGHourCapacityYear: Decimal;
        DecGBaseCapacityYear: Decimal;
        CduGTimesCalculation: Codeunit "DBE Times Calculation";
        TxtGDayStyle: Text;
        TxtGPeriodStyle: Text;
        TxtGYearStyle: Text;

        LblGBonusMalus: Label '%1 hour(s)';

    procedure FctSetParameters(CodPResourceCode: Code[20]; var DaPDate: Date)
    var
        RecLResource: Record Resource;
        DatLDate: Date;
        DatCurrYear: Text;
        DatCurrYear2: Text;
    begin
        CLEARALL;
        Clear(RecLResource);

        RecLResource.Get(CodPResourceCode);
        RecLResource.SetRange("Date Filter", DaPDate);
        DecGBaseCapacityDay := CduGTimesCalculation.FctBaseCapacity(RecLResource);
        DecGHourCapacityDay := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBaseCapacityDay);

        DecGBaseDayPosted := CduGTimesCalculation.FctBasePosted(RecLResource);
        DecGHourDayPosted := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBaseDayPosted);

        DecGDayBonusMalus := DecGHourDayPosted - DecGHourCapacityDay;

        if DaPDate = 0D then
            DaPDate := Today;
        RecLResource.SetRange("Date Filter", CALCDATE('<-CM>', DaPDate), CALCDATE('<CM>', DaPDate));
        DecGBaseCapacityPeriod := CduGTimesCalculation.FctBaseCapacity(RecLResource);
        DecGHourCapacityPeriod := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBaseCapacityPeriod);

        DecGBasePeriodPosted := CduGTimesCalculation.FctBasePosted(RecLResource);
        DecGHourPeriodPosted := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBasePeriodPosted);

        DecGPeriodBonusMalus := DecGHourPeriodPosted - DecGHourCapacityPeriod;

        RecLResource.SetRange("Date Filter", CALCDATE('<-CY>', DaPDate), Today);
        DecGBaseCapacityYear := CduGTimesCalculation.FctBaseCapacity(RecLResource);
        DecGHourCapacityYear := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBaseCapacityYear);

        DecGBaseYearPosted := CduGTimesCalculation.FctBasePosted(RecLResource);
        DecGHourYearPosted := CduGTimesCalculation.ConvertBaseUnitToHours(RecLResource."No.", DecGBaseYearPosted);

        DecGYearBonusMalus := DecGHourYearPosted - DecGHourCapacityYear;
        FctSetStyle();

        CurrPage.UPDATE(false);
    end;

    procedure FctSetStyle()
    begin
        TxtGDayStyle := 'Standard';
        TxtGPeriodStyle := 'Standard';
        TxtGYearStyle := 'Standard';

        if DecGDayBonusMalus > 0 then
            TxtGDayStyle := 'Favorable'
        else
            if DecGDayBonusMalus < 0 then
                TxtGDayStyle := 'Unfavorable';

        if DecGPeriodBonusMalus > 0 then
            TxtGPeriodStyle := 'Favorable'
        else
            if DecGPeriodBonusMalus < 0 then
                TxtGPeriodStyle := 'Unfavorable';

        if DecGYearBonusMalus > 0 then
            TxtGYearStyle := 'Favorable'
        else
            if DecGYearBonusMalus < 0 then
                TxtGYearStyle := 'Unfavorable';
    end;
}