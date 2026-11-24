unit LeasingNinja.Sales.Domain.FinancialCalculatorTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TFinancialCalculatorTest = class(TTestCase)
  published
    procedure GivenALeaseOf40000Over48MonthsAt3Point7Percent_WhenPmt_ThenInstallmentIsCorrect;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.FinancialCalculator;

procedure TFinancialCalculatorTest.GivenALeaseOf40000Over48MonthsAt3Point7Percent_WhenPmt_ThenInstallmentIsCorrect;
var
  Pmt: Double;
begin
  // given

  // when
  Pmt := TFinancialCalculator.Pmt(48, 3.7 / 12, -40000, 0, 0);

  // then
  AssertEquals(897.8022814470006, Pmt, 1E-9);
end;

initialization
  RegisterTest(TFinancialCalculatorTest);

end.
