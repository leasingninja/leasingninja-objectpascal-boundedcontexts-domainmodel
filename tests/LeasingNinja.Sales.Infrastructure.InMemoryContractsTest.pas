unit LeasingNinja.Sales.Infrastructure.InMemoryContractsTest;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  fpcunit, testregistry;

type
  TInMemoryContractsTest = class(TTestCase)
  published
    procedure GivenASavedContract_WhenWithNumber_ThenContractIsReturned;
    procedure GivenASavedContract_WhenSaveAgain_ThenContractIsStillThere;
    procedure GivenASavedContract_WhenWithNumberFromAnotherString_ThenContractIsReturned;
  end;

implementation

uses
  SysUtils,
  LeasingNinja.Sales.Domain.Amount,
  LeasingNinja.Sales.Domain.Car,
  LeasingNinja.Sales.Domain.Contract,
  LeasingNinja.Sales.Domain.ContractNumber,
  LeasingNinja.Sales.Domain.Contracts,
  LeasingNinja.Sales.Domain.Currency,
  LeasingNinja.Sales.Domain.Customer,
  LeasingNinja.Sales.Infrastructure.InMemoryContracts;

procedure TInMemoryContractsTest.GivenASavedContract_WhenWithNumber_ThenContractIsReturned;
var
  RepoUnderTest: IContracts;
  Contract: TContract;
begin
  // given
  RepoUnderTest := TInMemoryContracts.Create;
  RepoUnderTest.Save(TContract.Create(
    TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Mercedes Benz C class'),
    TAmount.From(20000, TCurrency.EUR)));

  // when
  Contract := RepoUnderTest.WithNumber(TContractNumber.From('4711'));

  // then
  AssertTrue(Contract.Number = TContractNumber.From('4711'));
  AssertTrue(Contract.Lessee = TCustomer.From('John Buyer'));
  AssertTrue(Contract.Car = TCar.From('Mercedes Benz C class'));
  AssertTrue(Contract.Price = TAmount.From(20000, TCurrency.EUR));
end;

procedure TInMemoryContractsTest.GivenASavedContract_WhenSaveAgain_ThenContractIsStillThere;
var
  RepoUnderTest: IContracts;
  Contract: TContract;
begin
  // given
  RepoUnderTest := TInMemoryContracts.Create;
  Contract := TContract.Create(
    TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Mercedes Benz C class'),
    TAmount.From(20000, TCurrency.EUR));
  RepoUnderTest.Save(Contract);

  // when
  RepoUnderTest.Save(Contract);

  // then
  AssertSame(Contract, RepoUnderTest.WithNumber(TContractNumber.From('4711')));
  AssertTrue(Contract.Lessee = TCustomer.From('John Buyer'));
end;

procedure TInMemoryContractsTest.GivenASavedContract_WhenWithNumberFromAnotherString_ThenContractIsReturned;
var
  RepoUnderTest: IContracts;
  Contract: TContract;
  NumberString: string;
begin
  // given
  RepoUnderTest := TInMemoryContracts.Create;
  Contract := TContract.Create(
    TContractNumber.From('4711'),
    TCustomer.From('John Buyer'),
    TCar.From('Mercedes Benz C class'),
    TAmount.From(20000, TCurrency.EUR));
  RepoUnderTest.Save(Contract);
  // a string with the same text, but built at runtime, so it is a different string in memory
  NumberString := IntToStr(4711);

  // when / then
  AssertSame(Contract, RepoUnderTest.WithNumber(TContractNumber.From(NumberString)));
end;

initialization
  RegisterTest(TInMemoryContractsTest);

end.
