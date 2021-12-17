unit Pedido.Negocio;

interface

uses System.Classes, System.Generics.Collections,
  Pedido,
  ORM.Intf;

type
  TPedidoNegocio = class(TInterfacedObject, IBaseNegocio<TPedido>)
  private
  public
    procedure inserirOrAtualizar(aPedido: TPedido);
    //function buscar(const aData: TDate): TObjectList<TPedido>;
  end;

implementation

uses udatabase;

{ TPedidoNegocio }

procedure TPedidoNegocio.inserirOrAtualizar(aPedido: TPedido);
begin

end;

end.
