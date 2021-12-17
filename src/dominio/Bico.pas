unit Bico;

interface

uses
  ORM.Attr;

type
  [Table('bico')]
  TBico = class
  private
    fId: Integer;
    fDescricao: string;
    fIdBomba: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    [Column('id'), PK, AutoInc]
    property iD: Integer read fId write fId;
    [Column('descricao')]
    property descricao: String read fDescricao write fDescricao;
    [Column('id_bomba')]
    property idBomba: Integer read fIdBomba write fIdBomba;
  end;


implementation

{ TBico }

constructor TBico.Create;
begin

end;

destructor TBico.Destroy;
begin

  inherited;
end;

end.
