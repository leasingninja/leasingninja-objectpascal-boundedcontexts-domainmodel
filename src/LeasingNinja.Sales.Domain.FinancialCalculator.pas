unit LeasingNinja.Sales.Domain.FinancialCalculator;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

type
  {
    Simulates the infamous HP12c calculator that is widely used in the leasing industry.
    The parameters are named after the keys of the HP12c.

    Delphi and Free Pascal already have a similar function, Math.Payment. We don't
    use it, because it only knows payment at the start or the end of a period
    (TPaymentTime) and whole numbers of periods, while the HP12c formula below also
    interpolates the annuity timing S.

    @Service
  }
  TFinancialCalculator = record
  private
    {
      N: number of periods
      I: decimal interest rate per period
      PV: present value
      FV: future value
      S: annuity timing: 0 = ordinary annuity (payment in arrears), 1 = annuity due
        (payment in advance); fractional values interpolate between the two
      Result: payment per period
    }
    class function PmtWithDecimalInterestRate(N, I, PV, FV, S: Double): Double; static;
  public
    {
      N: number of periods
      IInPercent: percentage interest rate per period
      PV: present value
      FV: future value
      S: annuity timing: 0 = ordinary annuity (payment in arrears), 1 = annuity due
        (payment in advance); fractional values interpolate between the two
      Result: payment per period
    }
    class function Pmt(N, IInPercent, PV, FV, S: Double): Double; static;
  end;

implementation

uses
  Math;

class function TFinancialCalculator.Pmt(N, IInPercent, PV, FV, S: Double): Double;
begin
  Result := PmtWithDecimalInterestRate(N, IInPercent / 100, PV, FV, S);
end;

class function TFinancialCalculator.PmtWithDecimalInterestRate(N, I, PV, FV, S: Double): Double;
begin
  if I = 0 then
    Exit((-PV - FV) / N);

  Result := (I * (FV + PV * Power(1 + I, N))) / ((1 + I * S) * (1 - Power(1 + I, N)));
end;

end.
