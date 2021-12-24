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
    fQuery: IBaseStatement;
    fSQLAttr: IBaseDAOSQLAttr<T>;
    fList: TObjectList<T>;

    fErrCod: Integer;
    fErrMsg: string;

  public
    constructor Create(aQuery: IBaseStatement);
    destructor Destroy; override;

    function insert(aValue: T): IBaseDAO<T>;
    function update(aValue: T): IBaseDAO<T>;
    function delete(aValue: T): IBaseDAO<T>;

    function find(var aList: TObjectList<T>): IBaseDAO<T>; overload;
    function find(const aId: Integer): T; overload;
    function sql: IBaseDAOSQLAttr<T>;

  end;


implementation

uses System.SysUtils, System.TypInfo,
  ORM.Attr,
  BaseRTTI,
  BaseSQL;


{ TBaseDAO<T> }

constructor TBaseDAO<T>.Create(aQuery: IBaseStatement);
begin
  fQuery :=aQuery;
  fSQLAttr :=TBaseDAOSQLAttr<T>.Create(Self);
  fList :=TObjectList<T>.Create;
  fErrCod :=0;
  fErrMsg :='';
end;

function TBaseDAO<T>.delete(aValue: T): IBaseDAO<T>;
begin

end;

destructor TBaseDAO<T>.Destroy;
begin
  fList.Free;
  inherited;
end;

function TBaseDAO<T>.find(const aId: Integer): T;
begin

end;

function TBaseDAO<T>.find(var aList: TObjectList<T>): IBaseDAO<T>;
var
  sql: TBaseSQL<T>;
  aSQL: String;
begin
  Result :=Self;
//  sql :=TBaseSQL<T>.Create(nil);
//  sql.columns(fSQLAttr.columns()).join(fSQLAttr.join())
//    .where(fSQLAttr.where())
//    .groupBy(fSQLAttr.groupBy())
//    .orderBy(fSQLAttr.orderBy()).select(aSQL) ;

//  FQuery.Open(aSQL);
//  if aBindList then
//      TSimpleRTTI<T>.New(nil).DataSetToEntityList(FQuery.DataSet, FList);
//  FSQLAttribute.Clear;
//  FQuery.DataSet.EnableControls;
end;

function TBaseDAO<T>.insert(aValue: T): IBaseDAO<T>;
var
  cmd: string ;
  sql: TBaseSQL<T>;
begin
  Result :=Self;
  sql :=TBaseSQL<T>.Create(aValue);
  sql.insert(cmd) ;
  fQuery.addCmd(cmd);

  fQuery.setParams(sql.columns);
  fQuery.execute;

end;

function TBaseDAO<T>.sql: IBaseDAOSQLAttr<T>;
begin
  Result :=fSQLAttr;
end;

function TBaseDAO<T>.update(aValue: T): IBaseDAO<T>;
begin

end;

end.
