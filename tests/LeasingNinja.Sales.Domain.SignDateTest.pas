unit LeasingNinja.Sales.Domain.SignDateTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TSignDateTest = class(TTestCase)
  published
    procedure GivenTwoSignDatesOfTheSameDay_WhenEquals_ThenAreEqual;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.SignDate;

procedure TSignDateTest.GivenTwoSignDatesOfTheSameDay_WhenEquals_ThenAreEqual;
var
  SignDate1, SignDate2: TSignDate;
  AreEqual: Boolean;
begin
  // given
  SignDate1 := TSignDate.From(2018, 8, 4);
  SignDate2 := TSignDate.From(2018, 8, 4);

  // when
  AreEqual := SignDate1 = SignDate2;

  // then
  AssertTrue(AreEqual);
end;

initialization
  RegisterTest(TSignDateTest);

end.
