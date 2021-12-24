unit DM.StdConn;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.VCLUI.Error;

type
  TdmStdConn = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
  private
    { Private declarations }
  protected
    procedure DoCreate; override;
  public
    { Public declarations }
  end;

var
  dmStdConn: TdmStdConn;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses uConnectionMgr;


{ TdmStdConn }

procedure TdmStdConn.DoCreate;
begin
  inherited;
  RemoveDataModule(Self);
  dbConnection.setConnection(FDConnection1, 'abc21posto.db');
end;

end.
