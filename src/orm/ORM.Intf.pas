unit ORM.Intf;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Data.DB;

type
  IBaseDAOSQLAttr<T : class> = interface;

  IBaseDAO<T : class> = interface
    function insert(aValue : T): IBaseDAO<T>;
    function update(aValue : T): IBaseDAO<T>;
    function delete(aValue : T): IBaseDAO<T>;

    function find(var aList: TObjectList<T>): IBaseDAO<T>; overload;
    function find(const aId: Integer): T; overload;
    function sql: IBaseDAOSQLAttr<T>;
  end;

  IBaseDAOSQLAttr<T : class> = interface
    function columns(const aSQL: String): IBaseDAOSQLAttr<T>; overload;
    function columns: String; overload;
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

//  IBaseColumn = interface
//    function getName(): string ;
//    procedure setName(const aValue: string);
//    property name: string read getName write setName;
//    fpType: TFieldType;
//    fpValue: Variant;
//  end;

  TBaseColumn = class;
  TBaseColumnArray = array of TBaseColumn;

  IBaseRTTI<T : class> = interface
    function tableName(var aTableName: String): IBaseRTTI<T>;
    function className(var aClassName: String): IBaseRTTI<T>;

    function columnsInfo(out aColumns: TBaseColumnArray): IBaseRTTI<T>;

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
    function join(const aSQL: String): IBaseSQL<T>;
    function groupBy(const aSQL: String): IBaseSQL<T>;
    function where(const aSQL: String): IBaseSQL<T>;
    function orderBy(const aSQL: String): IBaseSQL<T>;

    function getColumns(): TBaseColumnArray;
    property columns: TBaseColumnArray read getColumns;
  end;

  IBaseResultSet = interface
    function next: Boolean;
    function getField(const aFieldIndex: Integer): TField; overload;
    function getField(const aFieldName: string): TField; overload;
  end;

  IBaseStatement = interface
    procedure addCmd(const aCmd: string); overload;
    procedure addCmd(const aCmd: string; const args: array of const); overload;
    //function addParam(const aName: string; const aType: TFieldType): TParam;
    procedure setParams(aParams: TBaseColumnArray);
    function execute: Integer;
    function executeQuery: IBaseResultSet;
  end;

  IBaseDatasetStatement = interface(IBaseStatement)
    function getDataset: TDataset;
  end;

  IBaseTransaction = interface
    procedure Commit;
    procedure Rollback;
  end;

  IBaseNegocio<T> = Interface(IInterface)
    procedure inserirOrAtualizar(dominio: T);
  end;

  IBaseRepository = interface
  end;

  TTBaseColumnFlag = (cfNormal, cfPrimaryKey, cfForeignKey);
  TBaseColumn = class
  private
    fName: string;
    fFldTyp: TFieldType;
    fValue: Variant;
    fFlag: TTBaseColumnFlag;
  public
    constructor Create(const aName: string; const aType: TFieldType; aValue: Variant);
    function toString: string; override;
    property name: string read fName write fName;
    property fldTyp: TFieldType read fFldTyp write fFldTyp;
    property value: Variant read fValue write fValue;
    property flag: TTBaseColumnFlag read fFlag write fFlag;
  end;


implementation

uses
  System.Variants, System.TypInfo;


{ TBaseColumn }

constructor TBaseColumn.Create(const aName: string; const aType: TFieldType;
  aValue: Variant);
begin
  fName :=aName;
  fFldTyp :=aType;
  fValue  :=aValue;
  fFlag :=cfNormal;
end;

function TBaseColumn.toString: string;
var
  valueAsString: string;
begin
  if fValue = System.Variants.Null then
    valueAsString := 'NULL'
  else
  if fFldTyp = ftDateTime then
    valueAsString := '"' + DateTimeToStr(fValue) + '"'
  else
  if fFldTyp = ftDate then
    valueAsString := '"' + DateToStr(fValue) + '"'
  else
    valueAsString := '"' + VarToStr(fValue) + '"';

  Result :=fName + ' = ' + valueAsString + ' (' +
    GetEnumName(TypeInfo(TFieldType), Ord(fldTyp)) + ')';
end;


end.
