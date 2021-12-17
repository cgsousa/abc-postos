unit Pedido;

interface

uses
  ORM.Attr;

type
  [Table('pedido')]
  TPedido = class
  private
    fId: Integer;
    fData: TDate;
    fIdBico: Integer;
    fQuantidate: Double;
    fValorUnitario: Currency;
    fValorTotal: Currency;
    fAliquotaImposto: Single;
    fValorImposto: Currency;

  published
    [Column('id'), PK, AutoInc]
    property iD: Integer read fId write fId;
    [Column('data')]
    property data: TDate read fData write fData;
    [Column('id_bico')]
    property idBico: Integer read fIdBico write fIdBico;
    [Column('quantidate')]
    property quantidate: Double read fQuantidate write fQuantidate;
    [Column('valor_unitario')]
    property valorUnitario: Currency read fValorUnitario write fValorUnitario;
    [Column('valor_total')]
    property valorTotal: Currency read fValorTotal write fValorTotal;
    [Column('aliquota_imposto')]
    property aliquotaImposto: Single read fAliquotaImposto write fAliquotaImposto;
    [Column('valor_imposto')]
    property valorImposto: Currency read fValorImposto write fValorImposto;
  end;

implementation

end.
