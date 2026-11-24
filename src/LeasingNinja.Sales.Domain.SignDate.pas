unit LeasingNinja.Sales.Domain.SignDate;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

type
  { @ValueObject }
  TSignDate = record
  private
    FDate: TDate;
    function GetYear: Word;
    function GetMonth: Word;
    function GetDay: Word;
  public
    class function From(ADate: TDate): TSignDate; overload; static;
    class function From(AYear, AMonth, ADay: Word): TSignDate; overload; static;

    property Date: TDate read FDate;
    property Year: Word read GetYear;
    property Month: Word read GetMonth;
    property Day: Word read GetDay;

    class operator Equal(const ALeft, ARight: TSignDate): Boolean;
    class operator NotEqual(const ALeft, ARight: TSignDate): Boolean;
  end;

implementation

uses
  SysUtils, DateUtils;

class function TSignDate.From(ADate: TDate): TSignDate;
begin
  Result.FDate := DateOf(ADate);
end;

class function TSignDate.From(AYear, AMonth, ADay: Word): TSignDate;
begin
  Result := From(EncodeDate(AYear, AMonth, ADay));
end;

function TSignDate.GetYear: Word;
begin
  Result := YearOf(FDate);
end;

function TSignDate.GetMonth: Word;
begin
  Result := MonthOf(FDate);
end;

function TSignDate.GetDay: Word;
begin
  Result := DayOf(FDate);
end;

class operator TSignDate.Equal(const ALeft, ARight: TSignDate): Boolean;
begin
  Result := ALeft.FDate = ARight.FDate;
end;

class operator TSignDate.NotEqual(const ALeft, ARight: TSignDate): Boolean;
begin
  Result := not (ALeft = ARight);
end;

end.
