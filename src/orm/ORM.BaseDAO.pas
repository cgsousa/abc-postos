unit ORM.BaseDAO;

interface

uses
  ORM.Intf,
  System.RTTI,
  System.Generics.Collections,
  System.Classes,
  Data.DB,
  ORM.SQLAttr,
  System.Threading;

type
  TBaseDAO<T: class, constructor> = class(TInterfacedObject, IBaseDAO<T>)
  private
    fQuery: IBaseStatement; //IBaseQuery;
    fSQLAttr: IBaseDAOSQLAttr<T>;
    fList: TObjectList<T>;
    function fillParameter(aInstance: T): IBaseDAO<T>; overload;
    function fillParameter(aInstance: T; aId: Variant): IBaseDAO<T>; overload;

  public
    constructor Create(aQuery: IBaseStatement);
    destructor Destroy; override;

//    class function New(aQuery: iSimpleQuery): IBaseDAO<T>; overload;

    function insert(aValue: T): IBaseDAO<T>; overload;
    function update(aValue: T): IBaseDAO<T>; overload;
    function delete(aValue: T): IBaseDAO<T>; overload;
    function delete(const aField, aValue: String): IBaseDAO<T>; overload;

    function lastID: IBaseDAO<T>;
    function lastRecord: IBaseDAO<T>;

    function find(const aBindList: Boolean = True): IBaseDAO<T>; overload;
    function find(var aList: TObjectList<T>): IBaseDAO<T>; overload;
    function find(const aId: Integer): T; overload;
    function find(const aKey: String; aValue: Variant): IBaseDAO<T>; overload;
    function sql: IBaseDAOSQLAttr<T>;

  end;


implementation

{ TBaseDAO<T> }

constructor TBaseDAO<T>.Create(aQuery: IBaseStatement);
begin
  fQuery :=aQuery;
  fSQLAttr :=TBaseDAOSQLAttr<T>.Create(Self);
  fList :=TObjectList<T>.Create;
end;

function TBaseDAO<T>.delete(const aField, aValue: String): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.delete(aValue: T): IBaseDAO<T>;
begin

end;

destructor TBaseDAO<T>.Destroy;
begin
  fList.Free;
  inherited;
end;

function TBaseDAO<T>.fillParameter(aInstance: T): IBaseDAO<T>;
var
  key: String;
  dictionaryFields: TDictionary<String, Variant>;
  P: TParams;
begin
  dictionaryFields := TDictionary<String, Variant>.Create;
  TBaseRTTI<T>.New(aInstance).DictionaryFields(DictionaryFields);
  try
    for Key in DictionaryFields.Keys do
    begin
      if FQuery.Params.FindParam(Key) <> nil then
        FQuery.Params.ParamByName(Key).Value :=
          DictionaryFields.Items[Key];
    end;
  finally
    FreeAndNil(DictionaryFields);
  end;
end;

function TBaseDAO<T>.fillParameter(aInstance: T; aId: Variant): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.find(const aKey: String; aValue: Variant): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.find(const aId: Integer): T;
begin

end;

function TBaseDAO<T>.find(const aBindList: Boolean): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.find(var aList: TObjectList<T>): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.insert(aValue: T): IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.lastID: IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.lastRecord: IBaseDAO<T>;
begin

end;

function TBaseDAO<T>.sql: IBaseDAOSQLAttr<T>;
begin

end;

function TBaseDAO<T>.update(aValue: T): IBaseDAO<T>;
begin

end;

end.
