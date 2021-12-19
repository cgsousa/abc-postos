unit Cadastro.Negocio;

interface

uses System.Generics.Collections,
  Produto, Tanque, Bomba, Bico,
  BaseItem;

type

  TCadastroNegocio = class
  private
  public
    function buscarBicosPorTanque(const id_tanque: Integer =0): TBaseItem;
  end;

implementation

uses System.SysUtils, FireDAC.Comp.Client, Data.DB,
  udatabase;


{ TCadastroNegocio }

function TCadastroNegocio.buscarBicosPorTanque(
  const id_tanque: Integer): TBaseItem;
var
  Q: TFDQuery;
  fid_tanque,fid_bomba: TField;
var
  mapTanque: TDictionary<Integer, TBaseItem>;
  mapBomba: TDictionary<Integer, TBaseItem>;

  tanque: TBaseItem;
  bomba: TBaseItem;
  bico: TBaseItem;
begin
  Result :=TBaseItem.Create();

  Q :=dbConnection.newQuery ;
  try

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

    Q.Open();
    if(not Q.IsEmpty)then
    begin
      fid_tanque:=Q.field('tanque_id');
      fid_bomba :=Q.field('bomba_id');

      mapTanque :=TDictionary<Integer, TBaseItem>.Create;
      mapBomba :=TDictionary<Integer, TBaseItem>.Create;

      while not Q.Eof do
      begin

        if mapTanque.ContainsKey(fid_tanque.AsInteger)then
          tanque :=mapTanque.Items[fid_tanque.AsInteger]
        else
          tanque :=nil;

        if(tanque = nil)then
        begin
          tanque :=TBaseItem.Create();
          tanque.id :=fid_tanque.AsInteger ;
          tanque.descricao :=Format('%s/%s', [
            Q.field('tanque_descr').AsString,
            Q.field('prod_descr').AsString]);
          tanque.capacidade:=Q.field('capacidade').AsFloat ;
          tanque.pro_unid :=Q.field('unidade').AsString;

          mapTanque.Add(tanque.id, tanque);
          Result.addItem(tanque) ;
        end;

        if mapBomba.ContainsKey(fid_bomba.AsInteger)then
          bomba :=mapBomba.Items[fid_bomba.AsInteger]
        else
          bomba :=nil;

        if(bomba = nil)then
        begin
          bomba :=tanque.addItem() ;
          bomba.id :=fid_bomba.AsInteger;
          bomba.descricao :=Format('NS:%s, Mod:%s',[
            Q.field('numero_serie').AsString ,
            Q.field('modelo').AsString]);
        end;

        //
        //add bico
        bico :=bomba.addItem();
        bico.id       :=Q.field('bico_id').AsInteger;
        bico.descricao:=Q.field('bico_descr').AsString;
        bico.pro_descr:=Q.field('prod_descr').AsString;
        bico.pro_unid :=Q.field('unidade').AsString;
        bico.pro_imposto  :=Q.field('imposto').AsFloat;
        bico.pro_preco    :=Q.field('preco').AsCurrency;

        Q.Next ;
      end;

    end;

  finally
    if Assigned(mapBomba)then
      mapBomba.Free;
    if Assigned(mapTanque)then
      mapTanque.Free;
    Q.Free;
  end;



end;


end.
