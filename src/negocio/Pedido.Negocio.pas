unit Pedido.Negocio;

interface

uses System.Classes, System.Generics.Collections,
  ORM.Intf, Pedido, PedidoDTO;

type

  IPedidoNegocio = interface(IBaseRepository)
    procedure inserir(aPedido: TPedido);
    procedure atualizar(aPedido: TPedido);
    procedure deletar(aPedido: TPedido);
    function buscarPorPeriodo(const aData1, aData2: Integer): TPedidoDTO;
  end;

  TPedidoNegocio = class(TInterfacedObject, IPedidoNegocio)
  public
    procedure inserir(aPedido: TPedido);
    procedure atualizar(aPedido: TPedido);
    procedure deletar(aPedido: TPedido);
    function buscarPorPeriodo(const aData1, aData2: Integer): TPedidoDTO;
  end;

implementation

uses System.SysUtils, Data.DB,
  ORM.BaseDAO, uConnectionMgr;


{ TPedidoNegocio }

procedure TPedidoNegocio.atualizar(aPedido: TPedido);
begin

end;

function TPedidoNegocio.buscarPorPeriodo(const aData1, aData2: Integer): TPedidoDTO;
var
  Q: IBaseStatement;
  R: IBaseResultSet;
  fdata_pedido,fid_tanque,fid_bomba: TField;
  fvalor_total,fvalor_imposto: TField;
var
  mapData: TDictionary<Integer, TPedidoDTO>;
  mapTanque: TDictionary<Integer, TPedidoDTO>;
  mapBomba: TDictionary<Integer, TPedidoDTO>;

  data: TPedidoDTO;
  tanque: TPedidoDTO;
  bomba: TPedidoDTO;
  pedido: TPedidoDTO;
begin
  Result :=TPedidoDTO.Create(nil);

  Q :=dbConnection.createStatement() ;

  Q.addCmd('select                                               ');
  Q.addCmd('      p.id as pedido_id,p.data as pedido_data,       ');
  Q.addCmd('      p.descricao as pedido_descr,                   ');
  Q.addCmd('      p.quantidate,p.valor_unitario,                 ');
  Q.addCmd('      p.valor_total,p.valor_imposto,                 ');
  Q.addCmd('      bc.id as bico_id,bc.descricao as bico_descr,   ');
  Q.addCmd('      bm.id as bomba_id,bm.numero_serie,bm.modelo,   ');
  Q.addCmd('      tq.id as tanque_id,tq.descricao as tanque_descr,tq.capacidade,');
  Q.addCmd('      pr.descricao as prod_descr,pr.unidade,pr.imposto,pr.preco     ');
  Q.addCmd('from pedido p                                        ');
  Q.addCmd('left join bico bc on bc.id = p.id_bico               ');
  Q.addCmd('inner join bomba bm on bm.id = bc.id_bomba           ');
  Q.addCmd('inner join tanque tq on tq.id = bm.id_tanque         ');
  Q.addCmd('inner join produto pr on pr.id = tq.id_produto       ');
  Q.addCmd('where p.data between %d and %d                       ',[aData1,aData2]);
  Q.addCmd('order by p.data desc,tq.id,bm.id                     ');

  R :=Q.executeQuery();

  if(R.next)then
  begin
    fdata_pedido:=R.getField('pedido_data');
    fid_tanque:=R.getField('tanque_id');
    fid_bomba :=R.getField('bomba_id');
    fvalor_total  :=R.getField('valor_total');
    fvalor_imposto:=R.getField('valor_imposto');

    mapData :=TDictionary<Integer, TPedidoDTO>.Create;
    mapTanque :=TDictionary<Integer, TPedidoDTO>.Create;
    mapBomba :=TDictionary<Integer, TPedidoDTO>.Create;

    try
      repeat
        if mapData.ContainsKey(fdata_pedido.AsInteger)then
          data :=mapData.Items[fdata_pedido.AsInteger]
        else
          data :=nil;
        if(data = nil)then
        begin
          data :=Result.addItem();
          data.data :=fdata_pedido.AsInteger;
          data.valorTotal :=fvalor_total.AsCurrency;
          data.valorImposto :=fvalor_imposto.AsCurrency;
          mapData.Add(data.data, data);
        end
        else begin
          data.valorTotal :=data.valorTotal +fvalor_total.AsCurrency;
          data.valorImposto :=data.valorImposto +fvalor_imposto.AsCurrency;
        end;

        if mapTanque.ContainsKey(fid_tanque.AsInteger)then
          tanque :=mapTanque.Items[fid_tanque.AsInteger]
        else
          tanque :=nil;
        if(tanque = nil)then
        begin
          tanque :=data.addItem();
          tanque.id :=fid_tanque.AsInteger ;
          tanque.descricao :=Format('%s/%s', [
            R.getField('tanque_descr').AsString,
            R.getField('prod_descr').AsString]);
          tanque.capacidade:=R.getField('capacidade').AsFloat ;
          tanque.unidade :=R.getField('unidade').AsString;
          tanque.valorTotal :=fvalor_total.AsCurrency;
          tanque.valorImposto :=fvalor_imposto.AsCurrency;
          mapTanque.Add(tanque.id, tanque);
        end
        else begin
          tanque.valorTotal :=tanque.valorTotal +fvalor_total.AsCurrency;
          tanque.valorImposto :=tanque.valorImposto +fvalor_imposto.AsCurrency;
        end;

        if mapBomba.ContainsKey(fid_bomba.AsInteger)then
          bomba :=mapBomba.Items[fid_bomba.AsInteger]
        else
          bomba :=nil;
        if(bomba = nil)then
        begin
          bomba :=tanque.addItem() ;
          bomba.id :=fid_bomba.AsInteger;
          bomba.descricao :=Format('BOMBA:%.2d /%s', [bomba.id,R.getField('prod_descr').AsString]);
          bomba.valorTotal :=fvalor_total.AsCurrency;
          bomba.valorImposto :=fvalor_imposto.AsCurrency;
          mapBomba.Add(bomba.id, bomba);
        end
        else begin
          bomba.valorTotal :=bomba.valorTotal +fvalor_total.AsCurrency;
          bomba.valorImposto :=bomba.valorImposto +fvalor_imposto.AsCurrency;
        end;

        //
        //add bico
        pedido :=bomba.addItem();
        pedido.id       :=R.getField('pedido_id').AsInteger;
        pedido.descricao:=R.getField('pedido_descr').AsString;
        pedido.quantidate:=R.getField('quantidate').AsFloat;
        pedido.valorUnitario   :=R.getField('valor_unitario').AsCurrency;
        pedido.valorTotal   :=fvalor_total.AsCurrency;
        pedido.valorImposto :=fvalor_imposto.AsCurrency;

      until not(R.Next);

    finally
      mapBomba.Free;
      mapTanque.Free;
      mapData.Free;
    end;

  end;

end;

procedure TPedidoNegocio.deletar(aPedido: TPedido);
begin

end;

procedure TPedidoNegocio.inserir(aPedido: TPedido);
var
  cmd: IBaseStatement;
  dao: IBaseDAO<TPedido>;
  trans: IBaseTransaction;
begin
  cmd :=dbConnection.createStatement(True) ;
  dao :=TBaseDAO<TPedido>.Create(cmd);

  trans :=dbConnection.beginTransaction();
  try
    dao.Insert(aPedido);
    trans.Commit;
  except
    trans.Rollback;
    raise ;
  end;
end;



end.
