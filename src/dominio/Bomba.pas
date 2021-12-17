unit Bomba;

interface

uses
  ORM.Attr;

type
  [Table('bomba')]
  TBomba = class
  private
    fId: Integer;
    fNumeroSerie: string;
    fModelo: string;
    fIdTanque: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    [Column('id'), PK, AutoInc]
    property iD: Integer read fId write fId;
    [Column('numero_serie')]
    property numeroSerie: String read fNumeroSerie write fNumeroSerie;
    [Column('modelo')]
    property modelo: String read fModelo write fModelo;
    [Column('id_tanque')]
    property idTanque: Integer read fIdTanque write fIdTanque;
  end;


implementation

{ TBomba }

constructor TBomba.Create;
begin

end;

destructor TBomba.Destroy;
begin

  inherited;
end;

end.
