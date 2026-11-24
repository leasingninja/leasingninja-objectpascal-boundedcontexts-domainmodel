unit LeasingNinja.Sales.Domain.InterestTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TInterestTest = class(TTestCase)
  published
    procedure GivenAnInterest_WhenPerMonth_ThenCorrectValue;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.Interest;

procedure TInterestTest.GivenAnInterest_WhenPerMonth_ThenCorrectValue;
var
  Interest: TInterest;
  PerMonth: Double;
begin
  // given
  Interest := TInterest.From(3.6);

  // when
  PerMonth := Interest.PerMonth;

  // then
  AssertEquals(0.3, PerMonth, 1E-10);
end;

initialization
  RegisterTest(TInterestTest);

end.
