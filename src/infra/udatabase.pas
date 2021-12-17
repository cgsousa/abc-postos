{
    Direitos autorais (C) 2021 por ABC Postos de Combustiveis, Insc.
    Todos os direitos reservados
    Autor: Carlos Gonzaga

    utilidades para manipulação do banco de dados

}
unit udatabase;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  Data.DB;


type

  TFDCustomQuery = class helper for FireDAC.Comp.Client.TFDCustomQuery
  public
    function sqlStr(const aValue: string): string;
    function addCmd(const aCmd: string): Integer ; overload ;
    function addCmd(const aCmd: string; Args: array of const): Integer ; overload ;
    function field(const aFieldName: string): TField; //overload;
    //function field(const aFieldIndex: Integer): TField; overload;
  end;


  ConnectionManager = object
  private
    fConnection: TFDCustomConnection;
  public
     function createInstance(const aFileName: TFileName): TFDCustomConnection;
     procedure destroyInstance();
     function getConnection(): TFDConnection;
     function newQuery: TFDQuery;

  end;


var
  dbConnection: ConnectionManager;


implementation

{ TFDCustomQuery }

function TFDCustomQuery.addCmd(const aCmd: string): Integer;
begin
    if Self.Active then
    begin
      Self.Close ;
      Self.SQL.Clear;
    end;
    Result :=Self.SQL.Add(ACmd)
end;

function TFDCustomQuery.addCmd(const aCmd: string;
  Args: array of const): Integer;
begin
  Result :=Self.AddCmd(Format(ACmd,Args)) ;
end;

function TFDCustomQuery.field(const aFieldName: string): TField;
begin
  Result :=Self.FieldByName(Trim(aFieldName));
end;

function TFDCustomQuery.sqlStr(const aValue: string): string;
begin
  Result :=QuotedStr(aValue) ;
end;


{ ConnectionManager }

function ConnectionManager.createInstance(const aFileName: TFileName): TFDCustomConnection;
begin
  if(not Assigned(fConnection))then
  begin
    fConnection :=TFDCustomConnection.Create(nil);
    fConnection.ConnectionString :=Format('DriverID=SQLite;Database=%s',[aFileName]);
  end;
  Result :=fConnection;
end;

procedure ConnectionManager.destroyInstance;
begin
  if Assigned(fConnection)then
  begin
    FreeAndNil(fConnection);
  end;
end;


function ConnectionManager.getConnection: TFDConnection;
begin
  Result :=TFDConnection(fConnection) ;
end;

function ConnectionManager.newQuery: TFDQuery;
begin
  Result :=TFDQuery.Create(nil);
  Result.Connection :=fConnection ;

end;


end.
