unit BaseRTTI;

interface

uses
  ORM.Intf,
  System.Generics.Collections,
  System.RTTI,
  Data.DB,
  TypInfo,
  System.Classes,
  System.SysUtils;

type
  EBaseRTTI = Exception;

  TBaseRTTI<T : class, constructor> = class(TInterfacedObject, IBaseRTTI<T>)
  private
    fInstance : T;
    function findRTTIField(const ctxRtti: TRttiContext; classe: TClass; const Field: String): TRttiField;
    function floatFormat(const aValue: String ): Currency;
//    function bindValueToProperty( aEntity : T; aProperty : TRttiProperty; aValue : TValue) : IBaseRTTI<T>;

    function getRTTIPropertyValue(aEntity: T; const aPropertyName: String): Variant;
    function getRTTIProperty(aEntity: T; const aPropertyName: String) : TRttiProperty;
  public
    constructor Create(aInstance: T);
    destructor Destroy; override;

//    class function New( aInstance : T ) : IBaseRTTI<T>;

    function tableName(var aTableName: String): IBaseRTTI<T>;
    function fields (var aFields : String) : IBaseRTTI<T>;
    function fieldsInsert (var aFields : String) : IBaseRTTI<T>;
    function param (var aParam : String) : IBaseRTTI<T>;
    function where (var aWhere : String) : IBaseRTTI<T>;
    function update(var aUpdate : String) : IBaseRTTI<T>;
    function dictionaryFields(var aDictionary : TDictionary<string, variant>) : IBaseRTTI<T>;
    function listFields (var List : TList<String>) : IBaseRTTI<T>;
    function className (var aClassName : String) : IBaseRTTI<T>;
    function primaryKey(var aPK : String) : IBaseRTTI<T>;
  end;


implementation

//uses StrUtils;

{ TBaseRTTI<T> }

function TBaseRTTI<T>.className(var aClassName: String): IBaseRTTI<T>;
begin

end;

constructor TBaseRTTI<T>.Create(aInstance: T);
begin
  fInstance :=aInstance;
end;

destructor TBaseRTTI<T>.Destroy;
begin

  inherited;
end;

function TBaseRTTI<T>.dictionaryFields(
  var aDictionary: TDictionary<string, variant>): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.fields(var aFields: String): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.fieldsInsert(var aFields: String): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.findRTTIField(const ctxRtti: TRttiContext; classe: TClass;
  const Field: String): TRttiField;
var
  typRtti : TRttiType;
begin
  typRtti :=ctxRtti.GetType(classe.ClassInfo);
  Result  :=typRtti.GetField(Field);
end;

function TBaseRTTI<T>.floatFormat(const aValue: String): Currency;
begin
  Result :=Trim(avalue);
  while Pos('.', Result) > 0 do
    delete(aValue,Pos('.', Result),1);
  //Result := StrToCurr(aValue);
end;

function TBaseRTTI<T>.getRTTIProperty(aEntity: T;
  const aPropertyName: String): TRttiProperty;
var
  ctxRttiEntity : TRttiContext;
  typRttiEntity : TRttiType;
begin
  ctxRttiEntity := TRttiContext.Create;
  try
    typRttiEntity := ctxRttiEntity.GetType(aEntity.ClassInfo);
    Result := typRttiEntity.GetProperty(aPropertyName);
    if not Assigned(Result) then
      Result := typRttiEntity.GetPropertyFromAttribute<Campo>(aPropertyName);

    if not Assigned(Result) then
      raise EBaseRTTI.Create('Property ' + aPropertyName + ' not found!');
  finally
    ctxRttiEntity.Free;
  end;
end;

function TBaseRTTI<T>.getRTTIPropertyValue(aEntity: T;
  const aPropertyName: String): Variant;
begin
  Result :=getRTTIProperty(aEntity, aPropertyName).GetValue(Pointer(aEntity)).AsVariant;
end;

function TBaseRTTI<T>.listFields(var List: TList<String>): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.param(var aParam: String): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.primaryKey(var aPK: String): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.tableName(var aTableName: String): IBaseRTTI<T>;
var
  vInfo   : PTypeInfo;
  vCtxRtti: TRttiContext;
  vTypRtti: TRttiType;
begin
  Result := Self;
  vInfo := System.TypeInfo(T);
  vCtxRtti := TRttiContext.Create;
  try
    vTypRtti := vCtxRtti.GetType(vInfo);
    if vTypRtti.Tem<Table> then
      aTableName := vTypRtti.GetAttribute<Table>.Name;
  finally
    vCtxRtti.Free;
  end;
end;

function TBaseRTTI<T>.update(var aUpdate: String): IBaseRTTI<T>;
begin

end;

function TBaseRTTI<T>.where(var aWhere: String): IBaseRTTI<T>;
begin

end;

end.
