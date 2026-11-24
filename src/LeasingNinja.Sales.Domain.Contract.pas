unit LeasingNinja.Sales.Domain.Contract;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}
{$ASSERTIONS ON}

interface

uses
  LeasingNinja.Sales.Domain.Amount,
  LeasingNinja.Sales.Domain.Car,
  LeasingNinja.Sales.Domain.ContractNumber,
  LeasingNinja.Sales.Domain.Customer,
  LeasingNinja.Sales.Domain.Interest,
  LeasingNinja.Sales.Domain.LeaseTerm,
  LeasingNinja.Sales.Domain.SignDate;

type
  { @Entity }
  TContract = class
  private type
    TCalculation = record
      LeaseTerm: TLeaseTerm;
      Interest: TInterest;
      Installment: TAmount;
    end;
  private
    { @Identity }
    FNumber: TContractNumber;
    FLessee: TCustomer;
    FCar: TCar;
    FPrice: TAmount;
    FIsCalculated: Boolean;
    FCalculation: TCalculation;
    FIsSigned: Boolean;
    FSignDate: TSignDate;
    function GetLeaseTerm: TLeaseTerm;
    function GetInterest: TInterest;
    function GetInstallment: TAmount;
    function GetSignDate: TSignDate;
  public
    constructor Create(const ANumber: TContractNumber; const ALessee: TCustomer;
      const ACar: TCar; const APrice: TAmount);

    procedure CalculateInstallmentFor(const ALeaseTerm: TLeaseTerm; const AInterest: TInterest);
    procedure Sign(const ADate: TSignDate);

    function Equals(Obj: TObject): Boolean; override;

    { @Identity }
    property Number: TContractNumber read FNumber;
    property Lessee: TCustomer read FLessee;
    property Car: TCar read FCar;
    property Price: TAmount read FPrice;

    property IsCalculated: Boolean read FIsCalculated;
    property LeaseTerm: TLeaseTerm read GetLeaseTerm;
    property Interest: TInterest read GetInterest;
    property Installment: TAmount read GetInstallment;

    property IsSigned: Boolean read FIsSigned;
    property SignDate: TSignDate read GetSignDate;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.FinancialCalculator;

constructor TContract.Create(const ANumber: TContractNumber; const ALessee: TCustomer;
  const ACar: TCar; const APrice: TAmount);
begin
  inherited Create;

  FNumber := ANumber;
  FLessee := ALessee;
  FCar := ACar;
  FPrice := APrice;
  FIsCalculated := False;
  FIsSigned := False;
end;

procedure TContract.CalculateInstallmentFor(const ALeaseTerm: TLeaseTerm; const AInterest: TInterest);
const
  InAdvance = 0;
  ResidualValue = 0;
var
  Pmt: Double;
begin
  Assert(not IsSigned);

  Pmt := TFinancialCalculator.Pmt(
    ALeaseTerm.NoOfMonths,
    AInterest.PerMonth,
    -1 * FPrice.Value,
    ResidualValue,
    InAdvance);

  FCalculation.LeaseTerm := ALeaseTerm;
  FCalculation.Interest := AInterest;
  FCalculation.Installment := TAmount.From(Pmt, FPrice.Currency);
  FIsCalculated := True;

  Assert(IsCalculated);
end;

function TContract.GetLeaseTerm: TLeaseTerm;
begin
  Assert(IsCalculated);

  Result := FCalculation.LeaseTerm;
end;

function TContract.GetInterest: TInterest;
begin
  Assert(IsCalculated);

  Result := FCalculation.Interest;
end;

function TContract.GetInstallment: TAmount;
begin
  Assert(IsCalculated);

  Result := FCalculation.Installment;
end;

procedure TContract.Sign(const ADate: TSignDate);
begin
  Assert(IsCalculated);
  Assert(not IsSigned);

  FSignDate := ADate;
  FIsSigned := True;

  Assert(IsSigned);
end;

function TContract.GetSignDate: TSignDate;
begin
  Assert(IsSigned);

  Result := FSignDate;
end;

function TContract.Equals(Obj: TObject): Boolean;
begin
  if Obj = Self then
    Exit(True);

  Result := (Obj <> nil) and (Obj.ClassType = ClassType) and (TContract(Obj).FNumber = FNumber);
end;

end.
