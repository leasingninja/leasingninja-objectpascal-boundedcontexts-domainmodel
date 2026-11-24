unit LeasingNinja.Sales.Infrastructure.InMemoryContracts;

{$IFDEF FPC}{$MODE DELPHIUNICODE}{$ENDIF}

interface

uses
  Generics.Collections,
  LeasingNinja.Sales.Domain.Contract,
  LeasingNinja.Sales.Domain.ContractNumber,
  LeasingNinja.Sales.Domain.Contracts;

type
  TInMemoryContracts = class(TInterfacedObject, IContracts)
  private
    FContracts: TObjectDictionary<TContractNumber, TContract>;
  public
    constructor Create;
    destructor Destroy; override;

    function WithNumber(const ANumber: TContractNumber): TContract;
    procedure Save(AContract: TContract);
  end;

implementation

uses
  Generics.Defaults;

// The default comparer of the dictionary would compare the bytes of the record,
// i.e. the pointer to the string instead of the text. Hence our own comparer.
// Free Pascal 3.2.2 declares the comparer functions slightly differently than Delphi.

function ContractNumbersAreEqual({$IFDEF FPC}constref{$ELSE}const{$ENDIF} ALeft, ARight: TContractNumber): Boolean;
begin
  Result := ALeft = ARight;
end;

function HashOfContractNumber({$IFDEF FPC}constref{$ELSE}const{$ENDIF} AValue: TContractNumber): {$IFDEF FPC}UInt32{$ELSE}Integer{$ENDIF};
begin
  Result := TEqualityComparer<string>.Default.GetHashCode(AValue.Value);
end;

constructor TInMemoryContracts.Create;
begin
  inherited Create;

  FContracts := TObjectDictionary<TContractNumber, TContract>.Create([doOwnsValues],
    TEqualityComparer<TContractNumber>.Construct(ContractNumbersAreEqual, HashOfContractNumber));
end;

destructor TInMemoryContracts.Destroy;
begin
  FContracts.Free;

  inherited Destroy;
end;

function TInMemoryContracts.WithNumber(const ANumber: TContractNumber): TContract;
begin
  Result := FContracts[ANumber];
end;

procedure TInMemoryContracts.Save(AContract: TContract);
var
  SavedContract: TContract;
begin
  // Saving an already saved contract again must not replace it, since the
  // dictionary would free the "old" value, which is the very same object
  if FContracts.TryGetValue(AContract.Number, SavedContract) and (SavedContract = AContract) then
    Exit;

  FContracts.AddOrSetValue(AContract.Number, AContract);
end;

end.
