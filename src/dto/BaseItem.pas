unit BaseItem;

interface

uses
  System.Generics.Collections,
  produto;

type
  //IBaseItem
  IBaseItem = interface
    function getId: Integer;
    procedure setId(const aValue: Integer) ;
    property iD: Integer read getId write setId;

    function getDescricao: string;
    procedure setDescricao(const aValue: string) ;
    property descricao: string read getDescricao write setDescricao;

    function getCapacidade: Double;
    procedure setCapacidade(const aValue: Double) ;
    property capacidade: Double read getCapacidade write setCapacidade;

    function getUnidade: string;
    procedure setUnidade(const aValue: string) ;
    property unidade: string read getUnidade write setUnidade;

    function getImposto: Single;
    procedure setImposto(const aValue: Single) ;
    property imposto: Single read getImposto write setImposto;

    function getPreco: Currency;
    procedure setPreco(const aValue: Currency) ;
    property preco: Currency read getPreco write setPreco;

    function addItem(): IBaseItem ;
    function getItems(): TList<IBaseItem>;
    property items: TList<IBaseItem> read getItems;

    function getParent(): IBaseItem;
    property parent: IBaseItem read getParent;

  end;

  TBaseItem = class(TInterfacedObject, IBaseItem)
  private
    fParent: IBaseItem;
    fItems: TList<IBaseItem>;

    // geral info
    fId: Integer;
    fDescricao: string;

    // info do tanque
    fCapacidade: Double;

    //info do produto
    fProduto, fUnidade: string;
    fImposto: Single;
    fPreco: Currency;

    function getParent(): IBaseItem;

    function getItems(): TList<IBaseItem>;

    function getId: Integer;
    procedure setId(const aValue: Integer) ;

    procedure setDescricao(const aValue: string) ;
    function getDescricao: string;

    function getCapacidade: Double;
    procedure setCapacidade(const aValue: Double) ;

    function getUnidade: string;
    procedure setUnidade(const aValue: string) ;

    function getImposto: Single;
    procedure setImposto(const aValue: Single) ;

    function getPreco: Currency;
    procedure setPreco(const aValue: Currency) ;

  public
    constructor Create(aParent: IBaseItem);
    destructor Destroy; override;

    property iD: Integer read getId write setId;
    property descricao: string read getDescricao write setDescricao;
    property capacidade: Double read getCapacidade write setCapacidade;
    property unidade: string read getUnidade write setUnidade;
    property imposto: Single read getImposto write setImposto;
    property preco: Currency read getPreco write setPreco;

    property items: TList<IBaseItem> read getItems;
    function addItem(): IBaseItem ;

    property parent: IBaseItem read getParent;
  end;

implementation

{ TBaseItem }

function TBaseItem.addItem(): IBaseItem;
begin
  if(fItems = nil)then
  begin
    fItems :=TList<IBaseItem>.Create();
  end;

  Result :=TBaseItem.Create(Self);
  fItems.Add(Result) ;
end;

constructor TBaseItem.Create(aParent: IBaseItem);
begin
  fParent :=aParent;
  fItems :=nil;
end;

destructor TBaseItem.Destroy;
begin
  if Assigned(fItems)then
    fItems.Destroy;
  inherited;
end;

function TBaseItem.getCapacidade: Double;
begin
  Result :=fCapacidade;
end;

function TBaseItem.getDescricao: string;
begin
  Result :=fDescricao;
end;

function TBaseItem.getId: Integer;
begin
  Result :=fId;
end;

function TBaseItem.getImposto: Single;
begin
  Result :=fImposto;
end;

function TBaseItem.getItems: TList<IBaseItem>;
begin
  Result :=fItems;
end;


function TBaseItem.getParent: IBaseItem;
begin
  Result :=fParent;
end;

function TBaseItem.getPreco: Currency;
begin
  Result :=fPreco;
end;

function TBaseItem.getUnidade: string;
begin
  Result :=fUnidade;
end;

procedure TBaseItem.setCapacidade(const aValue: Double);
begin
  fCapacidade :=aValue;
end;

procedure TBaseItem.setDescricao(const aValue: string);
begin
  fDescricao :=aValue;
end;

procedure TBaseItem.setId(const aValue: Integer);
begin
  fId :=aValue;
end;

procedure TBaseItem.setImposto(const aValue: Single);
begin
  fImposto :=aValue;
end;

procedure TBaseItem.setPreco(const aValue: Currency);
begin
  fPreco :=aValue
end;

procedure TBaseItem.setUnidade(const aValue: string);
begin
  fUnidade :=aValue
end;

end.
