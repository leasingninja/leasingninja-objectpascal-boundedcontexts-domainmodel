program LeasingNinjaTests;

{$MODE DELPHIUNICODE}

uses
  consoletestrunner,
  LeasingNinja.Sales.Domain.AmountTest,
  LeasingNinja.Sales.Domain.CurrencyTest;

var
  App: TTestRunner;

begin
  DefaultRunAllTests := True;
  DefaultFormat := fPlain;

  App := TTestRunner.Create(nil);
  try
    App.Initialize;
    App.Title := 'LeasingNinja Tests';
    App.Run;
  finally
    App.Free;
  end;
end.
