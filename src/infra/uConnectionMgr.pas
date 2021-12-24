{
    Direitos autorais (C) 2021 por ABC Postos de Combustiveis, Insc.
    Todos os direitos reservados
    Autor: Carlos Gonzaga

    utilidades para manipulação do banco de dados

}
unit uConnectionMgr;

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  ORM.Intf;


type

  //TConnectionManager = class(TInterfacedObject, )
  ConnectionManager = object
  private
    fConnection: TFDConnection;
  public
    procedure setConnection(aConnection: TFDConnection;
      const aDatabaseName: string);
    function getConnection(): TFDConnection;

    function createStatement(const aParamCheck: Boolean = False;
      const aUniDirectional: Boolean = True): IBaseStatement;

    function beginTransaction: IBaseTransaction;

  end;


var
  dbConnection: ConnectionManager;


implementation

uses DRV.FireDAC;

{ ConnectionManager }

function ConnectionManager.beginTransaction: IBaseTransaction;
begin
  if fConnection = nil then
    Exit(nil);

  fConnection.Connected := true;

  if not fConnection.InTransaction then
  begin
    fConnection.StartTransaction;
    Result := TFireDACTransactionAdapter.Create(fConnection);
  end else
    Result := TFireDACTransactionAdapter.Create(nil);
end;

function ConnectionManager.createStatement(const aParamCheck,
  aUniDirectional: Boolean): IBaseStatement;
var
  Statement: TFDQuery;
begin
  if fConnection = nil then
    Exit(nil);

  Statement :=TFDQuery.Create(nil);
  try
    Statement.Connection :=fConnection;
    Statement.FetchOptions.Unidirectional :=aUniDirectional;
    Statement.ResourceOptions.ParamCreate :=aParamCheck;
    Statement.UpdateOptions.AutoCommitUpdates :=True;
  except
    FreeAndNil(Statement);
    raise;
  end;
  Result :=TFireDacStatementAdapter.Create(Statement);
end;

function ConnectionManager.getConnection: TFDConnection;
begin
  Result :=fConnection ;
end;

procedure ConnectionManager.setConnection(aConnection: TFDConnection;
  const aDatabaseName: string);
begin
  if(aConnection <> nil)then
  begin
    fConnection :=aConnection;
    fConnection.ConnectionString :=Format('DriverID=SQLite;Database=$(RUN)\%s;OpenMode=ReadWrite',[aDatabaseName]);
  end;
end;

end.
