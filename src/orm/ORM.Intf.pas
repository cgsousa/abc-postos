unit ORM.Intf;

interface

uses
  System.Classes, System.Generics.Collections, System.TypInfo,
  Data.DB,
  System.SysUtils;

type
  IBaseDAOSQLAttr<T : class> = interface;

  IBaseDAO<T : class> = interface
    function insert(aValue : T): IBaseDAO<T>; overload;
    function update(aValue : T): IBaseDAO<T>; overload;
    function delete(aValue : T): IBaseDAO<T>; overload;
    function delete(const aField, aValue: String): IBaseDAO<T>; overload;

    function lastID : IBaseDAO<T>;
    function lastRecord: IBaseDAO<T>;

    function find(const aBindList: Boolean = True): IBaseDAO<T>; overload;
    function find(var aList: TObjectList<T>): IBaseDAO<T>; overload;
    function find(const aId: Integer): T; overload;
    function find(const aKey: String; aValue : Variant): IBaseDAO<T>; overload;
    function sql: IBaseDAOSQLAttr<T>;
  end;

  IBaseDAOSQLAttr<T : class> = interface
    function fields(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function Fields: String; overload;
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
  end;

  IBaseRTTI<T : class> = interface
    function tableName(var aTableName: String): IBaseRTTI<T>;
    function className(var aClassName: String): IBaseRTTI<T>;
    function dictionaryFields(var aDictionary: TDictionary<string, variant>): IBaseRTTI<T>;
    function listFields(var aList: TList<String>): IBaseRTTI<T>;
    function update(var aUpdate: String): IBaseRTTI<T>;
    function where(var aWhere: String): IBaseRTTI<T>;
    function fields(var aFields: String): IBaseRTTI<T>;
    function fieldsInsert(var aFields: String): IBaseRTTI<T>;
    function param (var aParam : String): IBaseRTTI<T>;
    function primaryKey(var aPK: String): IBaseRTTI<T>;
  end;

  IBaseSQL<T> = interface
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

  IBaseQuery = interface
    function sql: TStrings;
    function params: TParams;
    function execSQL: IBaseQuery;
    function open(const aSQL : String): IBaseQuery; overload;
    function open: IBaseQuery; overload;
  end;

  IBaseResultSet = interface
    function Next: Boolean;
    function getField(const aFieldIndex: Integer): TField; overload;
    function getField(const aFieldName: string): TField; overload;
  end;

  IBaseStatement = interface
    procedure addCmd(const aCmd: string); overload;
    procedure addCmd(const aCmd: string; const args: array of const); overload;
    function addParam(const aName: string; const aType: TFieldType): TParam;
    function execute: Integer;
    function executeQuery: IBaseResultSet;
  end;

//  IBaseDatasetStatement = interface(IBaseStatement)
//    function getDataset: TDataset;
//  end;

  IBaseNegocio<T> = Interface(IInterface)
    procedure inserirOrAtualizar(dominio: T);
  end;


implementation


end.
