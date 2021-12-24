unit PedidoDTO;

interface

uses
  System.Generics.Collections,
  Tanque, Bomba, Pedido;

type

  TPedidoDTO = class
  private
    fParent: TPedidoDTO;
    fItems: TObjectList<TPedidoDTO>;
  public
    // geral info
    data: Integer;
    id: Integer;
    descricao: string;
    quantidate: Double;
    valorUnitario: Currency;
    valorTotal: Currency;
    valorImposto: Currency;
    capacidade: Double;
    unidade: string;

    constructor Create(aParent: TPedidoDTO);
    destructor Destroy; override;

    function addItem(): TPedidoDTO ;
    property items: TObjectList<TPedidoDTO> read fItems;

    function grandTotal(): Currency;

  end;


implementation


{ TPedidoDTO }

function TPedidoDTO.addItem(): TPedidoDTO;
begin
  if(fItems = nil)then
  begin
    fItems :=TObjectList<TPedidoDTO>.Create();
  end;

  Result :=TPedidoDTO.Create(Self);
  fItems.Add(Result) ;
end;

constructor TPedidoDTO.Create(aParent: TPedidoDTO);
begin
  fParent :=aParent;
  fItems :=nil;
end;

destructor TPedidoDTO.Destroy;
begin
  if Assigned(fItems)then
    fItems.Destroy;
  inherited;
end;

function TPedidoDTO.grandTotal: Currency;
var
  p: TPedidoDTO;
begin
  Result :=0;
  for p in items do
  begin
    Result :=Result +p.valorTotal;
  end;
end;

end.
