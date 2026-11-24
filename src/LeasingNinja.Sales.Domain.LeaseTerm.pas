unit LeasingNinja.Sales.Domain.LeaseTerm;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}
{$ASSERTIONS ON}

interface

type
  { @ValueObject }
  TLeaseTerm = record
  private
    FNoOfMonths: Integer;
  public
    class function FromMonths(ANoOfMonths: Integer): TLeaseTerm; static;
    class function FromYears(ANoOfYears: Integer): TLeaseTerm; static;

    property NoOfMonths: Integer read FNoOfMonths;

    class operator Equal(const ALeft, ARight: TLeaseTerm): Boolean;
    class operator NotEqual(const ALeft, ARight: TLeaseTerm): Boolean;
  end;

implementation

class function TLeaseTerm.FromMonths(ANoOfMonths: Integer): TLeaseTerm;
begin
  Assert(ANoOfMonths > 0);

  Result.FNoOfMonths := ANoOfMonths;
end;

class function TLeaseTerm.FromYears(ANoOfYears: Integer): TLeaseTerm;
begin
  Result := FromMonths(ANoOfYears * 12);
end;

class operator TLeaseTerm.Equal(const ALeft, ARight: TLeaseTerm): Boolean;
begin
  Result := ALeft.FNoOfMonths = ARight.FNoOfMonths;
end;

class operator TLeaseTerm.NotEqual(const ALeft, ARight: TLeaseTerm): Boolean;
begin
  Result := not (ALeft = ARight);
end;

end.
