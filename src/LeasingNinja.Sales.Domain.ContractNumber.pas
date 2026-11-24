unit LeasingNinja.Sales.Domain.ContractNumber;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

type
  { @ValueObject }
  TContractNumber = record
  private
    FValue: string;
  public
    class function From(const AValue: string): TContractNumber; static;

    property Value: string read FValue;

    class operator Equal(const ALeft, ARight: TContractNumber): Boolean;
    class operator NotEqual(const ALeft, ARight: TContractNumber): Boolean;
  end;

implementation

class function TContractNumber.From(const AValue: string): TContractNumber;
begin
  Result.FValue := AValue;
end;

class operator TContractNumber.Equal(const ALeft, ARight: TContractNumber): Boolean;
begin
  Result := ALeft.FValue = ARight.FValue;
end;

class operator TContractNumber.NotEqual(const ALeft, ARight: TContractNumber): Boolean;
begin
  Result := not (ALeft = ARight);
end;

end.
