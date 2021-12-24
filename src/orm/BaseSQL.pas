unit BaseSQL;

interface

uses
  ORM.Intf;

type
  TBaseSQL<T : class, constructor> = class(TInterfacedObject, IBaseSQL<T>)
  private
    fInstance: T;
    fJoin: String;
    fGroupBy: String;
    fWhere: String;
    fOrderBy: String;

    fColumns: TBaseColumnArray;
    function getColumns(): TBaseColumnArray;

  public
    constructor Create(aInstance: T);
    destructor Destroy; override;

    function insert(var aSQL: String): IBaseSQL<T>;
    function update(var aSQL: String): IBaseSQL<T>;
    function delete(var aSQL: String): IBaseSQL<T>;
    function select(var aSQL: String): IBaseSQL<T>;
    function join(const aSQL: String): IBaseSQL<T>;
    function groupBy(const aSQL: String): IBaseSQL<T>;
    function where(const aSQL: String): IBaseSQL<T>;
    function orderBy(const aSQL: String): IBaseSQL<T>;

    property columns: TBaseColumnArray read getColumns;

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
  bsRTTI: IBaseRTTI<T>;
  className, where: String;
begin
  Result :=Self;
  bsRTTI :=TBaseRTTI<T>.Create(fInstance);
  bsRTTI.tableName(className);
  bsRTTI.where(where);

  aSQL :=Format('DELETE FROM %s WHERE %s',[className,where]);
end;

destructor TBaseSQL<T>.Destroy;
var
  C: TBaseColumn;
begin
  for C in fColumns do
  begin
    C.Free;
  end;
  inherited;
end;

function TBaseSQL<T>.getColumns: TBaseColumnArray;
begin
  Result :=fColumns ;
end;

function TBaseSQL<T>.groupBy(const aSQL: String): IBaseSQL<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fGroupBy := aSQL;
end;

function TBaseSQL<T>.insert(var aSQL: String): IBaseSQL<T>;
var
  rtti: IBaseRTTI<T>;
  className, columns, params: String;
  C: TBaseColumn ;
begin
  Result :=Self;
  rtti :=TBaseRTTI<T>.Create(fInstance);
  rtti.tableName(className);
  rtti.columnsInfo(fColumns);

//  rtti.fieldsInsert(columns);
//  rtti.getParams(paramsStr, fParams);

  //
  // cmd insert
  for C in fColumns do
  begin
    if(C.flag <> cfPrimaryKey)then
    begin
      columns:=columns +Format('%s,',[C.name]);
      params :=params  +Format(':%s,',[C.name]);
    end;
  end;

  SetLength(columns, length(columns) -1);
  SetLength(params, length(params) -1);

  aSQL :=Format('INSERT INTO %s(%s) VALUES(%s)',[className,columns,params]);
end;

function TBaseSQL<T>.join(const aSQL: String): IBaseSQL<T>;
begin
  Result := Self;
  fJoin := aSQL;
end;

function TBaseSQL<T>.orderBy(const aSQL: String): IBaseSQL<T>;
begin
  Result := Self;
  fOrderBy := aSQL;
end;

function TBaseSQL<T>.select(var aSQL: String): IBaseSQL<T>;
var
  rtti: IBaseRTTI<T>;
  className, columns, params: String;
  C: TBaseColumn;
//
//  bsRTTI: IBaseRTTI<T>;
//  className, columns: String;
begin
  Result :=Self;
  rtti :=TBaseRTTI<T>.Create(fInstance);
  rtti.fields(columns);
  rtti.tableName(className);

//  if Trim(fColumns) <> '' then
//    aSQL := aSQL + ' SELECT ' +fColumns
//  else
//    aSQL := aSQL + ' SELECT ' +columns;
//
//  aSQL := aSQL + ' FROM ' + className;
//
//  if Trim(fJoin) <> '' then
//    aSQL := aSQL + ' ' + fJoin + ' ';
//  if Trim(fWhere) <> '' then
//    aSQL := aSQL + ' WHERE ' + fWhere;
//  if Trim(fGroupBy) <> '' then
//    aSQL := aSQL + ' GROUP BY ' + fGroupBy;
//  if Trim(fOrderBy) <> '' then
//    aSQL := aSQL + ' ORDER BY ' + fOrderBy;
//
end;

function TBaseSQL<T>.update(var aSQL: String): IBaseSQL<T>;
var
  bsRTTI: IBaseRTTI<T>;
  className, columns, where: String;
begin
  Result :=Self;
  bsRTTI :=TBaseRTTI<T>.Create(fInstance);
  bsRTTI.tableName(className);
  bsRTTI.update(columns);
  bsRTTI.where(where);

  aSQL :=Format('UPDATE %s SET %s WHERE %s',[className,columns,where]);
end;

function TBaseSQL<T>.where(const aSQL: String): IBaseSQL<T>;
begin
  Result := Self;
  fWhere := aSQL;
end;

end.
