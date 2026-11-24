unit LeasingNinja.Sales.Domain.Interest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}
{$ASSERTIONS ON}

interface

type
  { Interest in percent. @ValueObject }
  TInterest = record
  private
    FPerYear: Double;
    function GetPerMonth: Double;
  public
    class function From(APerYear: Double): TInterest; static;

    property PerYear: Double read FPerYear;
    property PerMonth: Double read GetPerMonth;

    class operator Equal(const ALeft, ARight: TInterest): Boolean;
    class operator NotEqual(const ALeft, ARight: TInterest): Boolean;

    function ToString: string;
  end;

implementation

uses
  SysUtils;

class function TInterest.From(APerYear: Double): TInterest;
begin
  Assert(APerYear >= 0);

  Result.FPerYear := APerYear;
end;

function TInterest.GetPerMonth: Double;
begin
  Result := FPerYear / 12;
end;

class operator TInterest.Equal(const ALeft, ARight: TInterest): Boolean;
begin
  Result := ALeft.FPerYear = ARight.FPerYear;
end;

class operator TInterest.NotEqual(const ALeft, ARight: TInterest): Boolean;
begin
  Result := not (ALeft = ARight);
end;

function TInterest.ToString: string;
var
  Settings: TFormatSettings;
begin
  Settings := FormatSettings;
  Settings.DecimalSeparator := '.';

  Result := 'Interest [' + FloatToStr(FPerYear, Settings) + '% p.a.]';
end;

end.
