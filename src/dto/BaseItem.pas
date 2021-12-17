unit BaseItem;

interface

uses
  System.Generics.Collections;

type
  TBaseItem = class
  private
    fParent: TBaseItem;
    fItems: TObjectList<TBaseItem>;

  public
    // geral info
    id: Integer;
    descricao: string;

    // info do tanque
    capacidade: Double;

    //info do produto
    pro_descr, pro_unid: string;
    pro_imposto: Single;
    pro_preco: Currency;

  public
    constructor Create;
    destructor Destroy; override;
    property items: TObjectList<TBaseItem> read fItems;
    function addItem(aItem: TBaseItem = nil): TBaseItem ;
  end;

implementation

{ TBaseItem }

function TBaseItem.addItem(aItem: TBaseItem): TBaseItem;
begin
  if(fItems = nil)then
  begin
    fItems :=TObjectList<TBaseItem>.Create();
  end;

  if(aItem = nil)then
    Result :=TBaseItem.Create;

  Result.fParent :=Self;
  fItems.Add(Result) ;
end;

constructor TBaseItem.Create;
begin
  fParent :=nil;
  fItems :=nil;
end;

destructor TBaseItem.Destroy;
begin
  if Assigned(fItems)then
    fItems.Destroy;
  inherited;
end;


end.
