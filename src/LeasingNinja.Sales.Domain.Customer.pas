unit LeasingNinja.Sales.Domain.Customer;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}
{$ASSERTIONS ON}

interface

type
  { @ValueObject }
  TCustomer = record
  private
    FName: string;
  public
    class function From(const AName: string): TCustomer; static;
    class function IsValid(const ANameString: string): Boolean; static;

    property Name: string read FName;

    class operator Equal(const ALeft, ARight: TCustomer): Boolean;
    class operator NotEqual(const ALeft, ARight: TCustomer): Boolean;
  end;

implementation

uses
  Character;

class function TCustomer.From(const AName: string): TCustomer;
begin
  Assert(IsValid(AName));

  Result.FName := AName;
end;

class function TCustomer.IsValid(const ANameString: string): Boolean;
var
  C: Char;
  PreviousIsLetter: Boolean;
begin
  // Words of letters, separated by single whitespace characters
  // TODO: Use the regular expression '^\p{L}+(\s\p{L}+)*$' like the other incarnations,
  // as soon as Delphi and Free Pascal share a regex library that supports \p{L}
  PreviousIsLetter := False;
  for C in ANameString do
    if TCharacter.IsLetter(C) then
      PreviousIsLetter := True
    else if TCharacter.IsWhiteSpace(C) and PreviousIsLetter then
      PreviousIsLetter := False
    else
      Exit(False);

  Result := PreviousIsLetter;
end;

class operator TCustomer.Equal(const ALeft, ARight: TCustomer): Boolean;
begin
  Result := ALeft.FName = ARight.FName;
end;

class operator TCustomer.NotEqual(const ALeft, ARight: TCustomer): Boolean;
begin
  Result := not (ALeft = ARight);
end;

end.
