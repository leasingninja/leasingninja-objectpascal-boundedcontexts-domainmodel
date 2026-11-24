unit LeasingNinja.Sales.Domain.Contracts;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  LeasingNinja.Sales.Domain.Contract,
  LeasingNinja.Sales.Domain.ContractNumber;

type
  {
    The repository owns the contracts saved in it: callers must not free them.
    @Repository
  }
  IContracts = interface
    ['{877CA3C3-9ED7-4AEF-9173-A95D8810FCC8}']
    function WithNumber(const ANumber: TContractNumber): TContract;
    procedure Save(AContract: TContract);
  end;

implementation

end.
