unit BaseRTTI;

interface

uses
  ORM.Intf,
  System.Generics.Collections,
  System.RTTI,
  Data.DB,
  TypInfo,
  System.Classes,
  System.SysUtils,
  ORM.Attr;

type
  EBaseRTTI = Exception;

  // helpers
  TCustomAttributeClass = class of TCustomAttribute;

  TRttiPropertyHelper = class helper for TRttiProperty
  public
    function contains<T: TCustomAttribute>: Boolean;
    function getAttribute<T: TCustomAttribute>: T;
    function isNotNull: Boolean;
    function isIgnore: Boolean;
    function isAutoInc: Boolean;
    function isField: Boolean;
    function isPrimaryKey: Boolean;
    function isForeignKey: Boolean;
    function isOnlyNumber: Boolean;
    function isNull: Boolean;
    //function displayName: string;
    function fieldName: string;
  end;

  TRttiTypeHelper = class helper for TRttiType
  public
    function contains<T: TCustomAttribute>: Boolean;
    function getAttribute<T: TCustomAttribute>: T;
    function getPropertyFromAttribute<T: TCustomAttribute>: TRttiProperty; overload;
    function getPropertyFromAttribute<T: Column>(const aFieldName: string): TRttiProperty; overload;
    function getFieldPK: TRttiProperty;
    function isTable: Boolean;
  end;

  TRttiFieldHelper = class helper for TRttiField
  public
    function contains<T: TCustomAttribute>: Boolean;
    function getAttribute<T: TCustomAttribute>: T;
  end;

  TValueHelper = record helper for TValue
  public
    function asStringOnlyNumber: String;
  end;


  TBaseRTTI<T : class, constructor> = class(TInterfacedObject, IBaseRTTI<T>)
  private
    fInstance: T;
    function findRTTIField(const ctxRtti: TRttiContext; classe: TClass; const Field: String): TRttiField;
    function floatFormat(const aValue: String ): Currency;

    function getRTTIPropertyValue(aEntity: T; const aPropertyName: String): Variant;
    function getRTTIProperty(aEntity: T; const aPropertyName: String) : TRttiProperty;

  public
    constructor Create(aInstance: T);
    destructor Destroy; override;

    function tableName(var aTableName: String): IBaseRTTI<T>;
    function fields(var aFields: String): IBaseRTTI<T>;
    function fieldsInsert(var aFields: String): IBaseRTTI<T>;
    function param (var aParam: String): IBaseRTTI<T>;
    function where (var aWhere: String): IBaseRTTI<T>;
    function update(var aUpdate: String): IBaseRTTI<T>;

    function columnsInfo(out aColumns: TBaseColumnArray): IBaseRTTI<T>;

    function className (var aClassName : String) : IBaseRTTI<T>;
    function primaryKey(var aPK : String) : IBaseRTTI<T>;
  end;


implementation

uses System.variants;

{ TRttiPropertyHelper }

function TRttiPropertyHelper.contains<T>: Boolean;
begin
  Result :=GetAttribute<T> <> nil;
end;

function TRttiPropertyHelper.fieldName: string;
begin
  Result :=Name;
  if isField then
    Result := GetAttribute<Column>.name;
end;

function TRttiPropertyHelper.getAttribute<T>: T;
var
  attr: TCustomAttribute;
begin
  Result := nil;
  for attr in GetAttributes do
    if attr is T then
      Exit((attr as T));
end;

function TRttiPropertyHelper.isAutoInc: Boolean;
begin
  Result :=contains<AutoInc>
end;

function TRttiPropertyHelper.isField: Boolean;
begin
  Result :=contains<Column>;
end;

function TRttiPropertyHelper.isForeignKey: Boolean;
begin
  Result :=contains<FK>;
end;

function TRttiPropertyHelper.isIgnore: Boolean;
begin
  Result :=contains<Ignore>;
end;

function TRttiPropertyHelper.isNotNull: Boolean;
begin
  Result :=contains<NotNull>;
end;

function TRttiPropertyHelper.isNull: Boolean;
begin
  Result :=not isNotNull;
end;

function TRttiPropertyHelper.isOnlyNumber: Boolean;
begin
  Result :=contains<OnlyNumber>;
end;

function TRttiPropertyHelper.isPrimaryKey: Boolean;
begin
  Result :=contains<PK>;
end;


{ TRttiTypeHelper }

function TRttiTypeHelper.contains<T>: Boolean;
begin
  Result :=getAttribute<T> <> nil;
end;

function TRttiTypeHelper.getAttribute<T>: T;
var
  attr: TCustomAttribute;
begin
  Result :=nil;
  for attr in GetAttributes do
    if attr is T then
      Exit((attr as T));
end;

function TRttiTypeHelper.getFieldPK: TRttiProperty;
begin
  Result :=getPropertyFromAttribute<PK>;
end;

function TRttiTypeHelper.getPropertyFromAttribute<T>: TRttiProperty;
var
  RttiProp: TRttiProperty;
begin
  Result :=nil;
  for RttiProp in GetProperties do
    if(RttiProp.GetAttribute<T> <> nil)then
      Exit(RttiProp);
end;

function TRttiTypeHelper.getPropertyFromAttribute<T>(
  const aFieldName: string): TRttiProperty;
var
  RttiProp: TRttiProperty;
begin
  Result := nil;
  for RttiProp in GetProperties do
  begin
    if(RttiProp.GetAttribute<T> = nil)then
      Continue;

    if(RttiProp.GetAttribute<Column>.name = aFieldName)then
      Exit(RttiProp);
  end;
end;

function TRttiTypeHelper.isTable: Boolean;
begin
  Result :=contains<Table>;
end;

{ TRttiFieldHelper }

function TRttiFieldHelper.contains<T>: Boolean;
begin
  Result :=getAttribute<T> <> nil;
end;

function TRttiFieldHelper.getAttribute<T>: T;
var
  attr: TCustomAttribute;
begin
  Result :=nil;
  for attr in GetAttributes do
    if attr is T then
      Exit((attr as T));
end;

{ TValueHelper }

function TValueHelper.asStringOnlyNumber: String;
var
  content: string;
  index: Integer;
begin
  Result := '';
  content := Trim(AsString);

  for index := 1 to Length(content) do
    if CharInSet(content[index], ['0'..'9']) then
      Result :=Result + content[index];
end;


{ TBaseRTTI<T> }

function TBaseRTTI<T>.className(var aClassName: String): IBaseRTTI<T>;
var
  Info      : PTypeInfo;
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    aClassName := Copy(typRtti.Name, 2, Length(typRtti.Name));
  finally
    ctxRtti.Free;
  end;
end;

function TBaseRTTI<T>.columnsInfo(out aColumns: TBaseColumnArray): IBaseRTTI<T>;
var
  ctxRtti: TRttiContext;
  typRtti: TRttiType;
  prpRtti: TRttiProperty;
  info: PTypeInfo;
  value: TValue;
var
  I: Integer;
begin
  Result :=Self;
  Info :=System.TypeInfo(T);
  ctxRtti :=TRttiContext.Create;
  I :=0;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if(prpRtti.IsIgnore)then
      begin
        Continue;
      end;

      SetLength(aColumns, I+1);
      aColumns[I] :=TBaseColumn.Create(UpperCase(prpRtti.FieldName), ftUnknown, Null);

      value :=prpRtti.GetValue(Pointer(fInstance));

      case prpRtti.PropertyType.TypeKind of
        tkInteger,tkInt64:
        begin
          aColumns[I].fldTyp:=ftInteger;
          aColumns[I].value :=value.AsInteger;

          if prpRtti.isPrimaryKey then
            aColumns[I].flag :=cfPrimaryKey
          else if prpRtti.isForeignKey then
          begin
            aColumns[I].flag :=cfForeignKey;
            if(aColumns[I].value = 0)then
              aColumns[I].value :=Null;
          end;
        end;

        tkFloat:
        begin
          aColumns[I].value :=value.AsVariant;
          if(value.TypeInfo = TypeInfo(TDateTime))then
            aColumns[I].fldTyp :=ftDateTime
          else if(value.TypeInfo = TypeInfo(TDate))then
            aColumns[I].fldTyp :=ftDate
          else if(value.TypeInfo = TypeInfo(TTime))then
            aColumns[I].fldTyp :=ftTime
          else
            aColumns[I].fldTyp :=ftFloat;
        end;
        tkWChar,
        tkLString,
        tkWString,
        tkUString,
        tkString:
        begin
          aColumns[I].fldTyp :=ftString;
          if(value.AsString <> '')then
            aColumns[I].value :=value.AsVariant
          else
            aColumns[I].value :=Null;
        end;
        tkVariant:
        begin
          aColumns[I].fldTyp :=ftVariant;
          aColumns[I].value :=value.AsVariant;
        end
      else
        aColumns[I].value :=value.AsVariant;
      end;

      Inc(I);
    end;

  finally
    ctxRtti.Free;
  end;
end;

constructor TBaseRTTI<T>.Create(aInstance: T);
begin
  fInstance :=aInstance;

end;

destructor TBaseRTTI<T>.Destroy;
begin

  inherited;
end;

function TBaseRTTI<T>.fields(var aFields: String): IBaseRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if not prpRtti.IsIgnore then
        aFields := aFields + prpRtti.FieldName + ', ';
    end;
  finally
    aFields := Copy(aFields, 0, Length(aFields) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TBaseRTTI<T>.fieldsInsert(var aFields: String): IBaseRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsAutoInc then
        Continue;

      if prpRtti.IsIgnore then
        Continue;

      aFields := aFields + prpRtti.FieldName + ', ';
    end;
  finally
    aFields := Copy(aFields, 0, Length(aFields) - 2) + ' ';
    ctxRtti.Free;
  end;
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
var
  S: string;
begin
  S :=Trim(avalue);
  while Pos('.', S) > 0 do
    delete(S,Pos('.', S),1);
  Result := StrToCurr(S);
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
      Result := typRttiEntity.getPropertyFromAttribute<Column>(aPropertyName);

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

function TBaseRTTI<T>.param(var aParam: String): IBaseRTTI<T>;
var
  ctxRtti: TRttiContext;
  typRtti: TRttiType;
  prpRtti: TRttiProperty;
  info: PTypeInfo;
begin
  Result :=Self;
  Info :=System.TypeInfo(T);
  ctxRtti :=TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if(prpRtti.IsIgnore)or(prpRtti.IsAutoInc) then
      begin
        Continue;
      end;

      aParam :=aParam + ':' +prpRtti.FieldName +', ';

    end;
  finally
    aParam := Copy(aParam, 0, Length(aParam) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TBaseRTTI<T>.primaryKey(var aPK: String): IBaseRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);

    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.isPrimaryKey then
        aPK := prpRtti.FieldName;
    end;
  finally
    ctxRtti.Free;
  end;

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
    if vTypRtti.contains<Table> then
      aTableName := vTypRtti.GetAttribute<Table>.Name;
  finally
    vCtxRtti.Free;
  end;
end;

function TBaseRTTI<T>.update(var aUpdate: String): IBaseRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsIgnore then
        Continue;

      if prpRtti.IsAutoInc then
        Continue;

      aUpdate := aUpdate + prpRtti.FieldName + ' = :' + prpRtti.FieldName + ', ';
    end;
  finally
    aUpdate := Copy(aUpdate, 0, Length(aUpdate) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TBaseRTTI<T>.where(var aWhere: String): IBaseRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.isPrimaryKey then
        aWhere := aWhere + prpRtti.FieldName + ' = :' + prpRtti.FieldName + ' AND ';
    end;
  finally
    aWhere := Copy(aWhere, 0, Length(aWhere) - 4) + ' ';
    ctxRtti.Free;
  end;
end;




end.
