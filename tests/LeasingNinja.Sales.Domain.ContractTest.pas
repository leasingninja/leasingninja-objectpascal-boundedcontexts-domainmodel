unit LeasingNinja.Sales.Domain.ContractTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TContractTest = class(TTestCase)
  published
    procedure GivenAFilledOutContract_WhenCalculate_ThenInstallmentIsX;
    procedure GivenAFilledOutContractWith0Interest_WhenCalculate_ThenInstallmentIsX;
    procedure GivenACalculatedContract_WhenSign_ThenContractIsSigned;
    procedure GivenTwoContractsWithSameIdButDifferentFields_WhenEquals_ThenShouldReturnTrue;
    procedure GivenTwoContractsWithDifferentIdButSameFields_WhenEquals_ThenShouldReturnFalse;
  end;

implementation

uses
  LeasingNinja.Sales.Domain.Amount,
  LeasingNinja.Sales.Domain.Car,
  LeasingNinja.Sales.Domain.Contract,
  LeasingNinja.Sales.Domain.ContractNumber,
  LeasingNinja.Sales.Domain.Currency,
  LeasingNinja.Sales.Domain.Customer,
  LeasingNinja.Sales.Domain.Interest,
  LeasingNinja.Sales.Domain.LeaseTerm,
  LeasingNinja.Sales.Domain.SignDate;

procedure TContractTest.GivenAFilledOutContract_WhenCalculate_ThenInstallmentIsX;
var
  Contract: TContract;
begin
  // given
  Contract := TContract.Create(TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Volkswagen ID.3'),
    TAmount.From(40000, TCurrency.EUR));
  try
    // when
    Contract.CalculateInstallmentFor(TLeaseTerm.FromMonths(48), TInterest.From(3.7));

    // then
    AssertTrue(Contract.IsCalculated);
    AssertTrue(Contract.LeaseTerm = TLeaseTerm.FromMonths(48));
    AssertTrue(Contract.Interest = TInterest.From(3.7));
    AssertTrue(Contract.Installment = TAmount.From(897.80, TCurrency.EUR));
  finally
    Contract.Free;
  end;
end;

procedure TContractTest.GivenAFilledOutContractWith0Interest_WhenCalculate_ThenInstallmentIsX;
var
  Contract: TContract;
begin
  // given
  Contract := TContract.Create(TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Volkswagen ID.3'),
    TAmount.From(40000, TCurrency.EUR));
  try
    // when
    Contract.CalculateInstallmentFor(TLeaseTerm.FromMonths(48), TInterest.From(0));

    // then
    AssertTrue(Contract.IsCalculated);
    AssertTrue(Contract.Installment = TAmount.From(833.33, TCurrency.EUR));
  finally
    Contract.Free;
  end;
end;

procedure TContractTest.GivenACalculatedContract_WhenSign_ThenContractIsSigned;
var
  Contract: TContract;
begin
  // given
  Contract := TContract.Create(TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Mercedes Benz C-Class'),
    TAmount.From(20000, TCurrency.EUR));
  try
    Contract.CalculateInstallmentFor(TLeaseTerm.FromMonths(48), TInterest.From(3.7));

    // when
    Contract.Sign(TSignDate.From(2018, 12, 24));

    // then
    AssertTrue(Contract.IsSigned);
    AssertTrue(Contract.SignDate = TSignDate.From(2018, 12, 24));
    // check that event ContractSigned is fired
  finally
    Contract.Free;
  end;
end;

procedure TContractTest.GivenTwoContractsWithSameIdButDifferentFields_WhenEquals_ThenShouldReturnTrue;
var
  Contract1, Contract2: TContract;
  Equal: Boolean;
begin
  // given
  Contract1 := nil;
  Contract2 := nil;
  try
    Contract1 := TContract.Create(TContractNumber.From('4711'),
      TCustomer.From('John Buyer'),
      TCar.From('Mercedes Benz C-Class'),
      TAmount.From(40000, TCurrency.EUR));
    Contract2 := TContract.Create(TContractNumber.From('4711'),
      TCustomer.From('Bob Myers'),
      TCar.From('Volkswagen ID.3'),
      TAmount.From(30000, TCurrency.EUR));

    // when
    Equal := Contract1.Equals(Contract2);

    // then
    AssertTrue(Equal);
  finally
    Contract2.Free;
    Contract1.Free;
  end;
end;

procedure TContractTest.GivenTwoContractsWithDifferentIdButSameFields_WhenEquals_ThenShouldReturnFalse;
var
  Contract1, Contract2: TContract;
  Equal: Boolean;
begin
  // given
  Contract1 := nil;
  Contract2 := nil;
  try
    Contract1 := TContract.Create(TContractNumber.From('4711'),
      TCustomer.From('John Buyer'),
      TCar.From('Mercedes Benz C-Class'),
      TAmount.From(40000, TCurrency.EUR));
    Contract2 := TContract.Create(TContractNumber.From('4712'),
      TCustomer.From('John Buyer'),
      TCar.From('Mercedes Benz C-Class'),
      TAmount.From(40000, TCurrency.EUR));

    // when
    Equal := Contract1.Equals(Contract2);

    // then
    AssertFalse(Equal);
  finally
    Contract2.Free;
    Contract1.Free;
  end;
end;

initialization
  RegisterTest(TContractTest);

end.
