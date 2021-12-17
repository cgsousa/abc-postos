unit Form.Princ00;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.WinXPanels, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  uStdCtrls,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Vcl.ComCtrls;

type
  TfrmPrinc00 = class(TBaseForm)
    pnlFooter: TStackPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ActionList1: TActionList;
    actFilter: TAction;
    actNew: TAction;
    actReport: TAction;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    actClose: TAction;
    pnlFilter: TStackPanel;
    Label1: TLabel;
    lvPedidos: TListView;
    procedure actNewExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoCreate; override;
  public
    { Public declarations }
  end;

var
  frmPrinc00: TfrmPrinc00;

implementation

{$R *.dfm}

uses udatabase,
  Form.PDV;


{ TfrmPrinc00 }

procedure TfrmPrinc00.actCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmPrinc00.actFilterExecute(Sender: TObject);
begin
  pnlFilter.Visible :=not pnlFilter.Visible;
end;

procedure TfrmPrinc00.actNewExecute(Sender: TObject);
begin
  TfrmPDV.createAndShow();
end;

procedure TfrmPrinc00.DoCreate;
begin
  inherited;
  dbConnection.createInstance(
    ExtractFilePath(Application.ExeName) +'abc21posto.db'
  );
end;

end.
