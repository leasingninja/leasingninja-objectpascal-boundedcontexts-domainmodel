unit LeasingNinja.Sales.Domain.Car;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

type
  { @ValueObject }
  TCar = record
  private
    FName: string;
  public
    class function From(const AName: string): TCar; static;

    property Name: string read FName;

    class operator Equal(const ALeft, ARight: TCar): Boolean;
    class operator NotEqual(const ALeft, ARight: TCar): Boolean;
  end;

implementation

class function TCar.From(const AName: string): TCar;
begin
  Result.FName := AName;
end;

class operator TCar.Equal(const ALeft, ARight: TCar): Boolean;
begin
  Result := ALeft.FName = ARight.FName;
end;

class operator TCar.NotEqual(const ALeft, ARight: TCar): Boolean;
begin
  Result := not (ALeft = ARight);
end;

end.
