program LeasingNinjaTests;

{$MODE DELPHIUNICODE}

uses
  consoletestrunner,
  LeasingNinja.Sales.Domain.AmountTest,
  LeasingNinja.Sales.Domain.ContractTest,
  LeasingNinja.Sales.Domain.CurrencyTest,
  LeasingNinja.Sales.Domain.CustomerTest,
  LeasingNinja.Sales.Domain.FinancialCalculatorTest,
  LeasingNinja.Sales.Domain.InterestTest,
  LeasingNinja.Sales.Domain.LeaseTermTest,
  LeasingNinja.Sales.Domain.SignDateTest;

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
