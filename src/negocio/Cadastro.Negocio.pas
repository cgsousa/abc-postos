unit Cadastro.Negocio;

interface

uses System.Generics.Collections,
  Produto, Tanque, Bomba, Bico,
  BaseItem,
  ORM.Intf ;

type

  ICadastroNegocio = Interface(IBaseRepository)
    function buscarBicosPorTanque(const id_tanque: Integer =0): IBaseItem;
  End;

  TCadastroNegocio = class //(TInterfacedObject, ICadastroNegocio)
  public
    function buscarBicosPorTanque(const id_tanque: Integer =0): IBaseItem;
  end;

implementation

uses System.SysUtils,
  Data.DB,
  uConnectionMgr ;



{ TCadastroNegocio }

function TCadastroNegocio.buscarBicosPorTanque(
  const id_tanque: Integer): IBaseItem;
var
  Q: IBaseStatement;
  R: IBaseResultSet;
  fid_tanque,fid_bomba: TField;
var
  mapTanque: TDictionary<Integer, IBaseItem>;
  mapBomba: TDictionary<Integer, IBaseItem>;

  tanque: IBaseItem;
  bomba: IBaseItem;
  bico: IBaseItem;
begin
  Result :=TBaseItem.Create(nil);

  Q :=dbConnection.createStatement() ;

  Q.addCmd('select                                                              ');
  Q.addCmd('      bc.id as bico_id,bc.descricao as bico_descr,                  ');
  Q.addCmd('      bm.id as bomba_id,bm.numero_serie,bm.modelo,                  ');
  Q.addCmd('      tq.id as tanque_id,tq.descricao as tanque_descr,tq.capacidade,');
  Q.addCmd('      pr.id as prod_id,pr.descricao as prod_descr,pr.unidade,pr.imposto,pr.preco');
  Q.addCmd('from bico bc                                                        ');
  Q.addCmd('inner join bomba bm on bm.id = bc.id_bomba                          ');
  Q.addCmd('inner join tanque tq on tq.id = bm.id_tanque                        ');
  Q.addCmd('inner join produto pr on pr.id = tq.id_produto                      ');
  if(id_tanque > 0)then
  Q.addCmd('where tq.id = %d                                                    ',[id_tanque]);
  Q.addCmd('order by tq.id,bm.id,bc.id                                          ');

  R :=Q.executeQuery();

  if(R.next)then
  begin
    fid_tanque:=R.getField('tanque_id');
    fid_bomba :=R.getField('bomba_id');

    mapTanque :=TDictionary<Integer, IBaseItem>.Create;
    mapBomba :=TDictionary<Integer, IBaseItem>.Create;
    try
      repeat
        if mapTanque.ContainsKey(fid_tanque.AsInteger)then
          tanque :=mapTanque.Items[fid_tanque.AsInteger]
        else
          tanque :=nil;

        if(tanque = nil)then
        begin
          tanque :=Result.addItem();
          tanque.id :=fid_tanque.AsInteger ;
          tanque.descricao :=Format('%s/%s', [
            R.getField('tanque_descr').AsString,
            R.getField('prod_descr').AsString]);
          tanque.capacidade:=R.getField('capacidade').AsFloat ;
          tanque.unidade :=R.getField('unidade').AsString;

          mapTanque.Add(tanque.id, tanque);
          //Result.addItem(tanque) ;
        end;

        if mapBomba.ContainsKey(fid_bomba.AsInteger)then
          bomba :=mapBomba.Items[fid_bomba.AsInteger]
        else
          bomba :=nil;

        if(bomba = nil)then
        begin
          bomba :=tanque.addItem() ;
          bomba.id :=fid_bomba.AsInteger;
          bomba.descricao :=R.getField('prod_descr').AsString;

          mapBomba.Add(bomba.id, bomba);
        end;

        //
        //add bico
        bico :=bomba.addItem();
        bico.id       :=R.getField('bico_id').AsInteger;
        bico.descricao:=R.getField('bico_descr').AsString;
        //bico.pro_descr:=R.getField('prod_descr').AsString;
        bico.unidade :=R.getField('unidade').AsString;
        bico.imposto :=R.getField('imposto').AsFloat;
        bico.preco   :=R.getField('preco').AsCurrency;

      until not(R.Next);

    finally
      mapBomba.Free;
      mapTanque.Free;
    end;

  end;

end;


end.
