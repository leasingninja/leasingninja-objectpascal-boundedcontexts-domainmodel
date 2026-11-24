unit LeasingNinja.Sales.Domain.CurrencyTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TCurrencyTest = class(TTestCase)
  published
    procedure GivenTwoUnequalCurrencies_WhenEquals_ThenAreNotEqual;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.Currency;

procedure TCurrencyTest.GivenTwoUnequalCurrencies_WhenEquals_ThenAreNotEqual;
var
  Currency1, Currency2: TCurrency;
  AreEqual: Boolean;
begin
  // given
  Currency1 := TCurrency.EUR;
  Currency2 := TCurrency.USD;

  // when
  AreEqual := Currency1 = Currency2;

  // then
  AssertFalse(AreEqual);
end;

initialization
  RegisterTest(TCurrencyTest);

end.
