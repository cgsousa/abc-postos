unit Tanque;

interface

uses
  ORM.Attr;

type
  [Table('tanque')]
  TTanque = class
  private
    fId: Integer;
    fDescricao: string;
    fCapacidade: Double;
    fIdProduto: Integer;
  published
    [Column('id'), PK, AutoInc]
    property iD: Integer read fId write fId;
    [Column('descricao')]
    property descricao: String read fDescricao write fDescricao;
    [Column('capacidade')]
    property capacidade: Double read fCapacidade write fCapacidade;
    [Column('id_produto')]
    property idProduto: Integer read fIdProduto write fIdProduto;
  end;

implementation


end.
