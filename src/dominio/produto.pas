unit produto;

interface

uses
  ORM.Attr;

type

  [Table('produto')]
  TProduto = class
  private
    fId: Integer;
    fDescricao: string;
    fUnidade: string;
    fCodigoANP: string;
    fIdProduto: Integer;
    fImposto: Single;
    fPreco: Currency;
  public
    constructor Create;
    destructor Destroy; override;
  published
    [Column('id'), PK, AutoInc]
    property iD: Integer read fId write fId;
    [Column('descricao')]
    property descricao: String read fDescricao write fDescricao;
    [Column('unidade')]
    property unidade: String read fUnidade write fUnidade;
    [Column('id_produto')]
    property IdProduto: Integer read fIdProduto write fIdProduto;
    [Column('imposto')]
    property imposto: Single read fImposto write fImposto;
    [Column('preco')]
    property preco: Currency read fPreco write fPreco;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

end.
