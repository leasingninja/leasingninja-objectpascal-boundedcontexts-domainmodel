unit LeasingNinja.Sales.Domain.AmountTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TAmountTest = class(TTestCase)
  published
    procedure GivenTwoEqualAmounts_WhenEquals_ThenAreEqual;
    procedure GivenTwoUnequalAmounts_WhenEquals_ThenAreNotEqual;
    procedure GivenTwoAmountsWithUnequalCurrencies_WhenEquals_ThenAreNotEqual;
    procedure GivenTwoAmountsWithRoundingAfterThePoint_WhenEquals_ThenAreEqual;
    procedure GivenAnAmountsWithCents_WhenToString_ThenAfterThePointIsCorrectlyPrinted;
    procedure GivenTwoAmountsOfEurosAndCents_WhenEquals_ThenAreEqual;
    procedure GivenTwoAmounts_WhenOperatorPlus_ThenSumIsCorrect;
    procedure GivenTwoAmounts_WhenOperatorMinus_ThenDifferenceIsCorrect;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.Currency,
  LeasingNinja.Sales.Domain.Amount;

procedure TAmountTest.GivenTwoEqualAmounts_WhenEquals_ThenAreEqual;
var
  Amount1, Amount2: TAmount;
  AreEqual: Boolean;
begin
  // given
  Amount1 := TAmount.From(100, TCurrency.EUR);
  Amount2 := TAmount.From(100, TCurrency.EUR);

  // when
  AreEqual := Amount1 = Amount2;

  // then
  AssertTrue(AreEqual);
end;

procedure TAmountTest.GivenTwoUnequalAmounts_WhenEquals_ThenAreNotEqual;
var
  Amount1, Amount2: TAmount;
  AreEqual: Boolean;
begin
  // given
  Amount1 := TAmount.From(100, TCurrency.EUR);
  Amount2 := TAmount.From(200, TCurrency.EUR);

  // when
  AreEqual := Amount1 = Amount2;

  // then
  AssertFalse(AreEqual);
end;

procedure TAmountTest.GivenTwoAmountsWithUnequalCurrencies_WhenEquals_ThenAreNotEqual;
var
  Amount1, Amount2: TAmount;
  AreEqual: Boolean;
begin
  // given
  Amount1 := TAmount.From(100, TCurrency.EUR);
  Amount2 := TAmount.From(100, TCurrency.GBP);

  // when
  AreEqual := Amount1 = Amount2;

  // then
  AssertFalse(AreEqual);
end;

procedure TAmountTest.GivenTwoAmountsWithRoundingAfterThePoint_WhenEquals_ThenAreEqual;
var
  Amount1, Amount2: TAmount;
  AreEqual: Boolean;
begin
  // given
  Amount1 := TAmount.From(100.45, TCurrency.EUR);
  Amount2 := TAmount.From(100.447123, TCurrency.EUR);

  // when
  AreEqual := Amount1 = Amount2;

  // then
  AssertTrue(AreEqual);
end;

procedure TAmountTest.GivenAnAmountsWithCents_WhenToString_ThenAfterThePointIsCorrectlyPrinted;
var
  Amount: TAmount;
  AmountString: string;
begin
  // given
  Amount := TAmount.From(100.45, TCurrency.EUR);

  // when
  AmountString := Amount.ToString;

  // then
  AssertEquals('EUR 100.45', AmountString);
end;

procedure TAmountTest.GivenTwoAmountsOfEurosAndCents_WhenEquals_ThenAreEqual;
var
  Amount1, Amount2: TAmount;
  AreEqual: Boolean;
begin
  // given
  Amount1 := TAmount.From(100.45, TCurrency.EUR);
  Amount2 := TAmount.FromCents(10045, TCurrency.EUR);

  // when
  AreEqual := Amount1 = Amount2;

  // then
  AssertTrue(AreEqual);
end;

procedure TAmountTest.GivenTwoAmounts_WhenOperatorPlus_ThenSumIsCorrect;
var
  Amount1, Amount2, Sum: TAmount;
begin
  // given
  Amount1 := TAmount.From(100, TCurrency.EUR);
  Amount2 := TAmount.From(200, TCurrency.EUR);

  // when
  Sum := Amount1 + Amount2;

  // then
  AssertTrue(Sum = TAmount.From(300, TCurrency.EUR));
end;

procedure TAmountTest.GivenTwoAmounts_WhenOperatorMinus_ThenDifferenceIsCorrect;
var
  Amount1, Amount2, Difference: TAmount;
begin
  // given
  Amount1 := TAmount.From(300, TCurrency.EUR);
  Amount2 := TAmount.From(200, TCurrency.EUR);

  // when
  Difference := Amount1 - Amount2;

  // then
  AssertTrue(Difference = TAmount.From(100, TCurrency.EUR));
end;

initialization
  RegisterTest(TAmountTest);

end.
