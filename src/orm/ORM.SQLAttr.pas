unit ORM.SQLAttr;

interface

uses
  ORM.Intf;

type
  TBaseDAOSQLAttr<T: class> = class(TInterfacedObject, IBaseDAOSQLAttr<T>)
  private
    [weak]
    fParent: IBaseDAO<T>;
    fFields: String;
    fJoin: String;
    fGroupBy: String;
    fWhere: String;
    fOrderBy: String;
  public
    constructor Create(parent: IBaseDAO<T>);
    destructor Destroy; override;

    function fields(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function fields: String; overload;
    function join(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function join: String; overload;
    function groupBy(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function groupBy: String; overload;
    function where(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function where: String; overload;
    function orderBy(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function orderBy: String; overload;

    function clear: IBaseDAOSQLAttr<T>;

    function &end: IBaseDAO<T>;

    //class function New(Parent: iSimpleDAO<T>): iSimpleDAOSQLAttribute<T>;
  end;


implementation

uses System.SysUtils;

{ TBaseDAOSQLAttr<T> }

function TBaseDAOSQLAttr<T>.clear: IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  fFields := '';
  fWhere := '';
  fOrderBy := '';
  fGroupBy := '';
  fJoin := '';
end;

constructor TBaseDAOSQLAttr<T>.Create(parent: IBaseDAO<T>);
begin
  fParent :=Parent;
end;

destructor TBaseDAOSQLAttr<T>.Destroy;
begin

  inherited;
end;

function TBaseDAOSQLAttr<T>.&end: IBaseDAO<T>;
begin
  Result :=fParent;
end;

function TBaseDAOSQLAttr<T>.fields: String;
begin
  Result :=fFields;
end;

function TBaseDAOSQLAttr<T>.fields(const aSQL: String): IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fFields := fFields + ' ' + aSQL;
end;

function TBaseDAOSQLAttr<T>.groupBy: String;
begin
  Result :=fGroupBy;
end;

function TBaseDAOSQLAttr<T>.groupBy(const aSQL: String): IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fGroupBy :=fGroupBy + ' ' + aSQL;
end;

function TBaseDAOSQLAttr<T>.join: String;
begin
  Result :=fJoin;
end;

function TBaseDAOSQLAttr<T>.join(const aSQL: String): IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fJoin :=fJoin + ' ' + aSQL;
end;

function TBaseDAOSQLAttr<T>.orderBy: String;
begin
  Result :=fOrderBy;
end;

function TBaseDAOSQLAttr<T>.orderBy(const aSQL: String): IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fOrderBy :=fOrderBy + ' ' + aSQL;
end;

function TBaseDAOSQLAttr<T>.where(const aSQL: String): IBaseDAOSQLAttr<T>;
begin
  Result := Self;
  if Trim(aSQL) <> '' then
    fWhere :=fWhere + ' ' + aSQL;
end;

function TBaseDAOSQLAttr<T>.where: String;
begin
  Result :=fWhere;
end;

end.
