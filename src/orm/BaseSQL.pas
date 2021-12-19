unit BaseSQL;

interface

uses
  ORM.Intf;

type
  TBaseSQL<T : class, constructor> = class(TInterfacedObject, IBaseSQL<T>)
  private
    fInstance : T;
    fFields : String;
    fJoin : String;
    fGroupBy : String;
    fWhere : String;
    fOrderBy : String;

  public
    constructor Create(aInstance: T);
    destructor Destroy; override;

//    class function New(aInstance : T) : IBaseSQL<T>;

    function insert(var aSQL: String): IBaseSQL<T>;
    function update(var aSQL: String): IBaseSQL<T>;
    function delete(var aSQL: String): IBaseSQL<T>;
    function select(var aSQL: String): IBaseSQL<T>;
    function selectId(var aSQL: String): IBaseSQL<T>;
    function fields(const aSQL: String): IBaseSQL<T>;
    function where(const aSQL: String): IBaseSQL<T>;
    function orderBy(const aSQL: String): IBaseSQL<T>;
    function groupBy(const aSQL: String): IBaseSQL<T>;
    function join(const aSQL: String): IBaseSQL<T>;
    function lastID(var aSQL: String): IBaseSQL<T>;
    function lastRecord(var aSQL: String): IBaseSQL<T>;
  end;

implementation

uses
  BaseRTTI,
  System.Generics.Collections, System.SysUtils;

{ TBaseSQL<T> }

constructor TBaseSQL<T>.Create(aInstance: T);
begin
  fInstance :=aInstance;
end;

function TBaseSQL<T>.delete(var aSQL: String): IBaseSQL<T>;
var
  baseRTTI: IBaseRTTI<T>;
  className, where: String;
begin
  Result :=Self;
  baseRTTI :=TBaseRTTI<T>.Create(fInstance);
  baseRTTI.tableName(className);
  baseRTTI.where(where);

  aSQL :=Format('DELETE FROM %s WHERE %s',[className,where]);
end;

destructor TBaseSQL<T>.Destroy;
begin

  inherited;
end;

function TBaseSQL<T>.fields(const aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.groupBy(const aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.insert(var aSQL: String): IBaseSQL<T>;
var
  baseRTTI: IBaseRTTI<T>;
  className, columns, params : String;
begin
  Result :=Self;
  baseRTTI :=TBaseRTTI<T>.Create(fInstance);
  BaseRTTI.tableName(className);
  BaseRTTI.fieldsInsert(columns);
  BaseRTTI.param(params);

  aSQL :=Format('INSERT INTO %s(%s) VALUES(%s)',[className,columns,params]);
end;

function TBaseSQL<T>.join(const aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.lastID(var aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.lastRecord(var aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.orderBy(const aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.select(var aSQL: String): IBaseSQL<T>;
var
  baseRTTI: IBaseRTTI<T>;
  className, columns: String;
begin
  Result :=Self;
  baseRTTI :=TBaseRTTI<T>.Create(fInstance);
  BaseRTTI.fields(columns);
  BaseRTTI.tableName(className);

  if Trim(FFields) <> '' then
    aSQL := aSQL + ' SELECT ' +fFields
  else
    aSQL := aSQL + ' SELECT ' +columns;

  aSQL := aSQL + ' FROM ' + className;

  if Trim(fJoin) <> '' then
    aSQL := aSQL + ' ' + fJoin + ' ';
  if Trim(fWhere) <> '' then
    aSQL := aSQL + ' WHERE ' + fWhere;
  if Trim(fGroupBy) <> '' then
    aSQL := aSQL + ' GROUP BY ' + fGroupBy;
  if Trim(fOrderBy) <> '' then
    aSQL := aSQL + ' ORDER BY ' + fOrderBy;

end;

function TBaseSQL<T>.selectId(var aSQL: String): IBaseSQL<T>;
begin

end;

function TBaseSQL<T>.update(var aSQL: String): IBaseSQL<T>;
var
  baseRTTI: IBaseRTTI<T>;
  className, columns, where: String;
begin
  Result :=Self;
  baseRTTI :=TBaseRTTI<T>.Create(fInstance);
  BaseRTTI.tableName(className);
  BaseRTTI.update(columns);
  BaseRTTI.where(where);

  aSQL :=Format('UPDATE %s SET %s WHERE %s',[className,columns,where]);
end;

function TBaseSQL<T>.where(const aSQL: String): IBaseSQL<T>;
begin

end;

end.
