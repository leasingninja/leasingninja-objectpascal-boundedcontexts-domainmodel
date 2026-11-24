unit LeasingNinja.Sales.Domain.CustomerTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TCustomerTest = class(TTestCase)
  published
    procedure GivenAStringWithOnlyLetters_WhenIsValid_ThenTrue;
    procedure GivenAStringWithNonStandardLatinCharacter_WhenIsValid_ThenTrue;
    procedure GivenAStringWithOnlyLettersAndSpace_WhenIsValid_ThenTrue;
    procedure GivenAStringWithNonStandardLatinCharacterAndSpace_WhenIsValid_ThenTrue;
    procedure GivenAStringWithNumbers_WhenIsValid_ThenFalse;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.Customer;

procedure TCustomerTest.GivenAStringWithOnlyLetters_WhenIsValid_ThenTrue;
var
  NameString: string;
  IsValid: Boolean;
begin
  // given
  NameString := 'John';

  // when
  IsValid := TCustomer.IsValid(NameString);

  // then
  AssertTrue(IsValid);
end;

procedure TCustomerTest.GivenAStringWithNonStandardLatinCharacter_WhenIsValid_ThenTrue;
var
  NameString: string;
  IsValid: Boolean;
begin
  // given
  NameString := 'Björn';

  // when
  IsValid := TCustomer.IsValid(NameString);

  // then
  AssertTrue(IsValid);
end;

procedure TCustomerTest.GivenAStringWithOnlyLettersAndSpace_WhenIsValid_ThenTrue;
var
  NameString: string;
  IsValid: Boolean;
begin
  // given
  NameString := 'John Buyer';

  // when
  IsValid := TCustomer.IsValid(NameString);

  // then
  AssertTrue(IsValid);
end;

procedure TCustomerTest.GivenAStringWithNonStandardLatinCharacterAndSpace_WhenIsValid_ThenTrue;
var
  NameString: string;
  IsValid: Boolean;
begin
  // given
  NameString := 'John le Carré';

  // when
  IsValid := TCustomer.IsValid(NameString);

  // then
  AssertTrue(IsValid);
end;

procedure TCustomerTest.GivenAStringWithNumbers_WhenIsValid_ThenFalse;
var
  NameString: string;
  IsValid: Boolean;
begin
  // given
  NameString := 'John42';

  // when
  IsValid := TCustomer.IsValid(NameString);

  // then
  AssertFalse(IsValid);
end;

initialization
  RegisterTest(TCustomerTest);

end.
