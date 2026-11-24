unit LeasingNinja.Sales.Domain.Amount;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}
{$ASSERTIONS ON}

interface

uses
  LeasingNinja.Sales.Domain.Currency;

type
  { @ValueObject }
  TAmount = record
  private
    FAmountInCents: Int64;
    FCurrency: TCurrency;
    function GetValue: System.Currency;
  public
    class function From(AAmount: System.Currency; ACurrency: TCurrency): TAmount; static;
    class function FromCents(AAmountInCents: Int64; ACurrency: TCurrency): TAmount; static;

    property Value: System.Currency read GetValue;
    property AmountInCents: Int64 read FAmountInCents;
    property Currency: TCurrency read FCurrency;

    class operator Add(const ALeft, ARight: TAmount): TAmount;
    class operator Subtract(const ALeft, ARight: TAmount): TAmount;
    class operator Equal(const ALeft, ARight: TAmount): Boolean;
    class operator NotEqual(const ALeft, ARight: TAmount): Boolean;

    function ToString: string;
  end;

implementation

uses
  SysUtils, TypInfo;

class function TAmount.From(AAmount: System.Currency; ACurrency: TCurrency): TAmount;
begin
  Result := FromCents(Round(AAmount * 100), ACurrency);
end;

class function TAmount.FromCents(AAmountInCents: Int64; ACurrency: TCurrency): TAmount;
begin
  Result.FAmountInCents := AAmountInCents;
  Result.FCurrency := ACurrency;
end;

function TAmount.GetValue: System.Currency;
begin
  Result := FAmountInCents / 100;
end;

class operator TAmount.Add(const ALeft, ARight: TAmount): TAmount;
begin
  Assert(ALeft.FCurrency = ARight.FCurrency);

  Result := FromCents(ALeft.FAmountInCents + ARight.FAmountInCents, ALeft.FCurrency);
end;

class operator TAmount.Subtract(const ALeft, ARight: TAmount): TAmount;
begin
  Assert(ALeft.FCurrency = ARight.FCurrency);

  Result := FromCents(ALeft.FAmountInCents - ARight.FAmountInCents, ALeft.FCurrency);
end;

class operator TAmount.Equal(const ALeft, ARight: TAmount): Boolean;
begin
  Result := (ALeft.FAmountInCents = ARight.FAmountInCents) and (ALeft.FCurrency = ARight.FCurrency);
end;

class operator TAmount.NotEqual(const ALeft, ARight: TAmount): Boolean;
begin
  Result := not (ALeft = ARight);
end;

function TAmount.ToString: string;
var
  Settings: TFormatSettings;
begin
  Settings := FormatSettings;
  Settings.DecimalSeparator := '.';

  Result := GetEnumName(TypeInfo(TCurrency), Ord(FCurrency)) + ' ' + CurrToStr(GetValue, Settings);
end;

end.
