unit drv.FireDac;

interface

uses
  ORM.Intf,
  FireDAC.Comp.Client, System.Classes, Data.DB, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt;

type
//  TQueryFiredac = class(TInterfacedObject, IBaseQuery)
//  private
//    fConnection : TFDConnection;
//    fQuery : TFDQuery;
//    fParams : TParams;
//  public
//    constructor Create(aConnection : TFDConnection);
//    destructor Destroy; override;
//
//    function SQL : TStrings;
//    function Params : TParams;
//    function ExecSQL : iSimpleQuery;
//    function DataSet : TDataSet;
//    function Open(aSQL : String) : iSimpleQuery; overload;
//    function Open : iSimpleQuery; overload;
//  public
//    class function newQueryFiredac(aConnection: TFDConnection): IBaseQuery;
//  end;


  TStatementFireDac = class(TInterfacedObject, IBaseStatement) //, IBaseDatasetStatement)
  private
    //fConnection: TFDConnection;
    fQuery: TFDCustomQuery; //TDataset;
    //function getDataset: TDataset;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    procedure addCmd(const aCmd: string); overload;
    procedure addCmd(const aCmd: string; const args: array of const); overload;
    function addParam(const aName: string; const aType: TFieldType): TParam;
    function execute: Integer;
    function executeQuery: IBaseResultSet;

    //class function newFireDacStatementAdapter(aConnection: TFDConnection): IBaseStatement;
  end;


implementation


{ TStatementFireDac }

procedure TStatementFireDac.addCmd(const aCmd: string;
  const args: array of const);
begin

end;

procedure TStatementFireDac.addCmd(const aCmd: string);
begin

end;

function TStatementFireDac.addParam(const aName: string;
  const aType: TFieldType): TParam;
begin

end;

constructor TStatementFireDac.Create(aConnection: TFDConnection);
begin
  fQuery :=TFDCustomQuery.Create(nil);
  fQuery.Connection :=aConnection ;
end;

destructor TStatementFireDac.Destroy;
begin

  inherited;
end;

function TStatementFireDac.execute: Integer;
begin

end;

function TStatementFireDac.executeQuery: IBaseResultSet;
begin

end;


end.
