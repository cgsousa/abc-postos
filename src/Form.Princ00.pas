unit Form.Princ00;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.WinXPanels, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.WinXPickers,
  uStdCtrls,
  Pedido.Negocio, PedidoDTO;

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
    actClose: TAction;
    pnlFilter: TStackPanel;
    Label1: TLabel;
    StackPanel1: TStackPanel;
    lvPedidos: TListView;
    tvData: TTreeView;
    HeaderControl1: THeaderControl;
    Label2: TLabel;
    dpData1: TDatePicker;
    dpData2: TDatePicker;
    btnExec: TButton;
    procedure actNewExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure tvDataChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
  private
    { Private declarations }
    fPedidoNegocio: IPedidoNegocio;
    fPedidoDTOList: TPedidoDTO;

    procedure doCargaTree();
    procedure doCargaPedido(aNode: TTreeNode);
  protected
    procedure DoCreate; override;
    procedure DoDestroy; override;
  public
    { Public declarations }
    procedure inicialize(); override;
  end;

var
  frmPrinc00: TfrmPrinc00;

implementation

{$R *.dfm}

uses //System.DateUtils,
  Form.PDV;


{ TfrmPrinc00 }

procedure TfrmPrinc00.actCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmPrinc00.actFilterExecute(Sender: TObject);
begin
  pnlFilter.Visible :=not pnlFilter.Visible

end;

procedure TfrmPrinc00.actNewExecute(Sender: TObject);
begin
  if TfrmPDV.createAndShow() then
  begin
    btnExecClick(nil);
  end;
end;

procedure TfrmPrinc00.btnExecClick(Sender: TObject);
var
  d1,d2: Integer;
begin
  if pnlFilter.Visible then
  begin
    d1 :=Trunc(dpData1.Date);
    d2 :=Trunc(dpData2.Date);

    if Assigned(fPedidoDTOList.items)then
      fPedidoDTOList.items.Clear;
    fPedidoDTOList :=fPedidoNegocio.buscarPorPeriodo(d1, d2);

    if(fPedidoDTOList.items.Count > 0)then
    begin
      doCargaTree();
      ActiveControl :=tvData;
    end
    else begin
      dlg.info('Não foram encontrados dados para este filtro!');
      ActiveControl :=dpData2;
    end;
  end;
end;

procedure TfrmPrinc00.doCargaPedido(aNode: TTreeNode);
var
  bomba, pedido: TPedidoDTO;
  item: TListItem;
begin

  lvPedidos.Items.BeginUpdate;
  try

    lvPedidos.Items.Clear;

    if aNode = nil then
      Exit;

    if(aNode.Data <> nil)then
    begin
      bomba :=TPedidoDTO(aNode.Data);
      for pedido in bomba.items do
      begin
        item :=lvPedidos.Items.Add;
        item.Caption :=pedido.id.ToString ;
        item.SubItems.Add(pedido.descricao);
        item.SubItems.Add(Format('%7.3f',[pedido.quantidate]));
        item.SubItems.Add(Format('%7.2f',[pedido.valorUnitario]));
        item.SubItems.Add(Format('%9.2f',[pedido.valorTotal]));
        item.SubItems.Add(Format('%7.2f',[pedido.valorImposto]));
        item.Data :=pedido;
      end;

      lvPedidos.ItemIndex :=0;
    end;

  finally
    lvPedidos.Items.EndUpdate;
  end;

end;

procedure TfrmPrinc00.doCargaTree;
var
  data,
  tanque,
  bomba,
  bico: TPedidoDTO;
  n0,n1,n2: TTreeNode;
  dd,mm,yy: Word;
begin

  tvData.Items.BeginUpdate;
  try
    tvData.Items.Clear;

    //
    // grande total
    n0 :=tvData.Items.AddNode(nil, nil,
                              Format('TOTAL GERAL  %15.2m',[fPedidoDTOList.grandTotal]),
                              nil,
                              naAdd
    );

    for data in fPedidoDTOList.items do
    begin

      DecodeDate(TDate(data.data), yy, mm, dd) ;
      n1 :=tvData.Items.AddChild(n0, Format('%.2d  %15.2m',[dd,data.valorTotal])
      );

      for tanque in data.items do
      begin
        n2 :=tvData.Items.AddChild(n1,
                      Format('%s  %15.2m',[tanque.descricao,tanque.valorTotal])
        );

        for bomba in tanque.items do
        begin
          tvData.Items.AddChildObject(n2,
                        Format('%s  %15.2m',[bomba.descricao,bomba.valorTotal]),
                        bomba
          );
        end;
        n2.Expanded :=True;

      end;
      n1.Expanded :=True;

    end;
    n0.Expanded :=True;

  finally
    tvData.Items.EndUpdate;
  end;

  //actConfirm.Enabled :=false;

end;

procedure TfrmPrinc00.DoCreate;
begin
  inherited;
  ReportMemoryLeaksOnShutdown := true;
end;

procedure TfrmPrinc00.DoDestroy;
begin
  FreeAndNil(fPedidoDTOList);
  inherited;
end;

procedure TfrmPrinc00.FormShow(Sender: TObject);
begin
  fPedidoNegocio :=TPedidoNegocio.Create;
  inicialize;
end;

procedure TfrmPrinc00.inicialize;
var
  hj: Integer;
begin
    hj :=Trunc(Date);
    fPedidoDTOList :=fPedidoNegocio.buscarPorPeriodo(hj, hj);

    if Assigned(fPedidoDTOList.items)and(fPedidoDTOList.items.Count > 0)then
    begin
      doCargaTree();
      ActiveControl :=tvData;
    end
end;

procedure TfrmPrinc00.tvDataChange(Sender: TObject; Node: TTreeNode);
begin
  if(Node = nil)then
    doCargaPedido(nil)
  else
    doCargaPedido(Node);
end;

end.
