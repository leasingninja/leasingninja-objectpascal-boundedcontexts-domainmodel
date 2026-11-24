unit LeasingNinja.Sales.Domain.LeaseTermTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TLeaseTermTest = class(TTestCase)
  published
    procedure Given_WhenALeaseTermIsCreatedFromYears_ThenNoOfMonthsIsCorrect;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.LeaseTerm;

procedure TLeaseTermTest.Given_WhenALeaseTermIsCreatedFromYears_ThenNoOfMonthsIsCorrect;
var
  LeaseTerm: TLeaseTerm;
begin
  // given

  // when
  LeaseTerm := TLeaseTerm.FromYears(4);

  // then
  AssertEquals(48, LeaseTerm.NoOfMonths);
end;

initialization
  RegisterTest(TLeaseTermTest);

end.
