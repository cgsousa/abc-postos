unit drv.FireDac;

interface

uses
//  FireDAC.Comp.Client, FireDAC.Comp.Dataset, FireDAC.Stan.Param, FireDAC.DatS,
//  FireDAC.DApt.Intf, FireDAC.DApt;

  System.Classes, Data.DB,
  Generics.Collections,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  ORM.Intf;


type

  TFireDACResultSetAdapter = class(TInterfacedObject, IBaseResultSet)
  private
    fDataset: TFDQuery;
    fFetching: Boolean;
  protected
    property Dataset: TFDQuery read fDataset;
  public
    constructor Create(aDataset: TFDQuery);
    destructor Destroy; override;

    function next: Boolean;
    function getField(const aFieldIndex: Integer): TField; overload;
    function getField(const aFieldName: string): TField; overload;
  end;

  TFireDACStatementAdapter = class(TInterfacedObject, IBaseStatement, IBaseDatasetStatement)
  private
    fQuery: TFDQuery;
    function getDataset: TDataset;
  public
    constructor Create(aQuery: TFDQuery);
    destructor Destroy; override;

    procedure addCmd(const aCmd: string); overload;
    procedure addCmd(const aCmd: string; const args: array of const); overload;
    procedure setParams(aParams: TBaseColumnArray);

    function execute: Integer;
    function executeQuery: IBaseResultSet;
  end;

  TFireDACTransactionAdapter = class(TInterfacedObject, IBaseTransaction)
  private
    fFDConnection: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);
    procedure Commit;
    procedure Rollback;
  end;





implementation

uses System.SysUtils, System.Variants, System.TypInfo;

{ TFireDACResultSetAdapter }

constructor TFireDACResultSetAdapter.Create(aDataset: TFDQuery);
begin
  fDataset :=ADataset;
end;

destructor TFireDACResultSetAdapter.Destroy;
begin
  //FreeAndNil(fDataset);
  inherited;
end;

function TFireDACResultSetAdapter.getField(const aFieldIndex: Integer): TField;
begin
  Result :=fDataset.Fields[aFieldIndex] ;
end;

function TFireDACResultSetAdapter.getField(const aFieldName: string): TField;
begin
  Result :=fDataset.FieldByName(aFieldName);
end;

function TFireDACResultSetAdapter.next: Boolean;
begin
  if not fFetching then
    fFetching := True
  else
    fDataset.Next;

  Result := not fDataset.Eof;
end;


{ TFireDACStatementAdapter }

procedure TFireDACStatementAdapter.addCmd(const aCmd: string;
  const args: array of const);
begin
  Self.AddCmd(Format(aCmd, Args));
end;

procedure TFireDACStatementAdapter.addCmd(const aCmd: string);
begin
  if(fQuery.Active)then
  begin
    fQuery.Close;
    fQuery.SQL.Clear;
  end;
  fQuery.SQL.Add(aCmd) ;
end;

{
function TFireDACStatementAdapter.addParam(const aName: string;
  const aType: TFieldType): TParam;
begin

end;
}

constructor TFireDACStatementAdapter.Create(aQuery: TFDQuery);
begin
  fQuery :=aQuery;
end;

destructor TFireDACStatementAdapter.Destroy;
begin
  if Assigned(fQuery)then
    FreeAndNil(fQuery);
  inherited;
end;

function TFireDACStatementAdapter.execute: Integer;
begin
  if(fQuery = nil)then
    Exit(0);
  fQuery.ExecSQL;
  Result :=fQuery.RowsAffected;
end;

function TFireDACStatementAdapter.executeQuery: IBaseResultSet;
begin
  if(fQuery = nil)then
    Exit(nil);
  fQuery.OpenOrExecute;
  Result :=TFireDacResultSetAdapter.Create(fQuery);
end;

function TFireDACStatementAdapter.getDataset: TDataset;
begin
  Result :=fQuery;
end;

procedure TFireDACStatementAdapter.setParams(aParams: TBaseColumnArray);
var
  I: Integer;
  C: TBaseColumn;
  Parameter: TFDParam;
begin
  if(fQuery = nil)then
    Exit;

  with TStringList.Create do
  try

  for C in aParams do
  begin

    Parameter :=fQuery.FindParam(C.name) ;
    if(Parameter = nil)then
    begin
      Parameter :=fQuery.Params.Add(C.name, C.fldTyp, -1, ptInput);
    end;

    {Parameter.DataType :=P.pType;
    case Parameter.DataType of
      ftInteger,ftSmallint,ftWord: Parameter.FDDataType :=dtInt32;
      ftDate: Parameter.FDDataType :=dtDate;
      ftDateTime: Parameter.FDDataType :=dtDateTime;
      ftTimeStamp: Parameter.FDDataType :=dtDateTimeStamp;
      ftFloat: Parameter.FDDataType :=dtDouble;
      ftString: Parameter.FDDataType :=dtAnsiString;

      ftFixedChar, ftFixedWideChar:
      begin
        // On Oracle, from Delphi Tokyo, leaving Size with 0 value will cause
        // an error of Data Too Large (500). Let's force the size here then
        if VarIsStr(Parameter.Value) then
          Parameter.Size := Length(Parameter.Value);
      end;

//      begin
//        Parameter.DataType :=ftInteger;
//        Parameter.AsInteger :=Trunc(P.pValue);
//      end;
//    else
//      Parameter.Value := P.pValue;
    end;
    }

    //if(pos('BICO',P.pName)>0)then
    //Parameter.Value := 23
    //else
    Parameter.Value := C.value;

//      Add(
//        Format('Param: %s(%s/%s)',[
//        Parameter.Name,
//        GetEnumName(TypeInfo(TFieldType),Integer(Parameter.DataType)),
//        Parameter.Value
//        ])
//      );

  end;

  //SaveToFile('setParams.LOG');

  finally
    free;
  end;

end;

{ TFireDACTransactionAdapter }

procedure TFireDACTransactionAdapter.Commit;
begin
  if(fFDConnection = nil)then
    Exit;

  fFDConnection.Commit;
end;

constructor TFireDACTransactionAdapter.Create(aConnection: TFDConnection);
begin
  fFDConnection :=aConnection;
end;

procedure TFireDACTransactionAdapter.Rollback;
begin
  if(fFDConnection = nil)then
    Exit;

  fFDConnection.Rollback;
end;

end.
