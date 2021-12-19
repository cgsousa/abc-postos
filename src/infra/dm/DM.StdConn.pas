unit DM.StdConn;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TdmStdConn = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
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


{ TdmStdConn }

procedure TdmStdConn.DoCreate;
begin
  inherited;
  RemoveDataModule(Self);
end;

end.
