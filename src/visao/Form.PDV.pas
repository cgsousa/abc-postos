unit Form.PDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.WinXPanels,
  Vcl.StdCtrls, Vcl.Mask, System.Actions, Vcl.ActnList,
  uStdCtrls,
  Cadastro.Negocio, BaseItem, Pedido;

type
  TfrmPDV = class(TBaseForm)
    StackPanel1: TStackPanel;
    Panel1: TPanel;
    tvBomba: TTreeView;
    lvBicos: TListView;
    pnlQtde: TPanel;
    Label1: TLabel;
    edtQtd: TMaskEdit;
    lvPedido: TListView;
    Button1: TButton;
    ActionList1: TActionList;
    actConfirm: TAction;
    actCancel: TAction;
    actAdd: TAction;
    pnlFooter: TStackPanel;
    Button2: TButton;
    Button3: TButton;
    procedure tvBombaChange(Sender: TObject; Node: TTreeNode);
    procedure actAddExecute(Sender: TObject);
    procedure actConfirmExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
    fCadastroNegocio: TCadastroNegocio; //ICadastroNegocio;
    fTanques: IBaseItem;
    fPedido: TPedido;
    procedure doRefreshBicos(aNode: TTreeNode);
  protected
    procedure DoCreate; override;
    procedure DoDestroy; override;
  public
    { Public declarations }
    class function createAndShow(): Boolean;
    procedure inicialize(); override;
  end;


implementation

{$R *.dfm}

uses Pedido.Negocio;

{ TfrmPDV }

procedure TfrmPDV.actAddExecute(Sender: TObject);
var
  qtd: Double;
//  tanque:
  item: TListItem;
  bomba, bico: IBaseItem;
begin
  TryStrToFloat(Trim(edtQtd.Text), qtd);
  if(qtd <= 0)then
  begin
    dlg.alert('O campo quantidade DEVE ser informado!');
    edtQtd.SetFocus;
    exit;
  end;

  item :=lvBicos.Items[lvBicos.ItemIndex];
  if(item.Data = nil)then
    exit;

  bico :=IBaseItem(item.Data);
  bomba :=bico.parent;

  if not Assigned(fPedido)then
  begin
    fPedido :=TPedido.Create ;
    fPedido.data :=Trunc(Date);
    fPedido.idBico :=bico.id;
    fPedido.descricao :=Format('BOMBA:%.2d %s/BICO:%.2d',[bomba.iD,bomba.descricao,bico.iD]);
    fPedido.quantidate :=qtd;
    fPedido.valorUnitario :=bico.preco;
    fPedido.valorTotal :=fPedido.quantidate *fPedido.valorUnitario;
    fPedido.aliquotaImposto :=bico.imposto;
    fPedido.valorImposto :=fPedido.valorTotal *(fPedido.aliquotaImposto/100);

    lvPedido.Items.BeginUpdate;
    try
      lvPedido.Items.Clear;

      item :=lvPedido.Items.Add;
      item.Caption :=Format('%d %s',[bico.id,fPedido.descricao]);
      item.SubItems.Add(Format('%7.3f',[fPedido.quantidate]));
      item.SubItems.Add(bico.unidade);
      item.SubItems.Add(Format('%7.3m',[fPedido.valorUnitario]));
      item.SubItems.Add(Format('%7.3m',[fPedido.valorTotal]));
      item.Data :=bico;

    finally
      lvPedido.Items.EndUpdate;
    end;

    tvBomba.Enabled :=false;
    pnlQtde.Enabled :=false;
    actConfirm.Enabled :=true;

  end;
end;

procedure TfrmPDV.actCancelExecute(Sender: TObject);
begin
  ModalResult :=mrCancel;
end;

procedure TfrmPDV.actConfirmExecute(Sender: TObject);
var
  negocio: IPedidoNegocio;
begin
  if dlg.comfirm('Deseja confirmar a venda?')then
  begin
    negocio :=TPedidoNegocio.Create;
    try
      negocio.inserir(fPedido);
      ModalResult :=mrOk;
    except
      raise;
//      on E:Exception do
//        dlg.alert('Deseja confirmar a venda?');
    end;
  end;
end;

class function TfrmPDV.createAndShow: Boolean;
var
  view: TfrmPDV;
begin
  view :=TfrmPDV.Create(Application);
  try
    view.inicialize();
    Result :=view.ShowModal() = mrOk;
  finally
    FreeAndNil(view);
  end;
end;

procedure TfrmPDV.DoCreate;
begin
  inherited;
  fCadastroNegocio :=TCadastroNegocio.Create;
  fTanques :=fCadastroNegocio.buscarBicosPorTanque() ;
  fPedido :=nil;
end;

procedure TfrmPDV.DoDestroy;
begin
  fCadastroNegocio.Free;
  if Assigned(fPedido)then
    fPedido.Free;
  inherited;
end;

procedure TfrmPDV.doRefreshBicos(aNode: TTreeNode);
var
  tanque,
  bomba,
  bico: IBaseItem;
  item: TListItem;
begin
  lvBicos.Items.BeginUpdate;
  try
    lvBicos.Items.Clear;

    if aNode = nil then
      Exit;

    if(aNode.Data <> nil)then
    begin
      bomba :=IBaseItem(aNode.Data);
      bico :=bomba.items[0];

      item :=lvBicos.Items.Add;
      item.Caption :=bico.descricao;
      item.SubItems.Add(bomba.descricao);
      item.SubItems.Add(Format('%12.3m',[bico.preco]));
      item.Data :=bico;
      lvBicos.ItemIndex :=0;
    end;

  finally
    lvBicos.Items.EndUpdate;
  end;
end;

procedure TfrmPDV.inicialize;
var
  tanque,
  bomba,
  bico: IBaseItem;
begin

  tvBomba.Items.BeginUpdate;
  try
    tvBomba.Items.Clear;
    for tanque in fTanques.items do
    begin
      for bomba in tanque.items do
      begin
        //
        // tanque/bomba
        tvBomba.Items.AddNode(nil, nil, Format('BOMBA:%.2d /%s',[bomba.iD,bomba.descricao]), bomba, naAdd);

      end;
    end;

  finally
    tvBomba.Items.EndUpdate;
  end;

  actConfirm.Enabled :=false;

end;


procedure TfrmPDV.tvBombaChange(Sender: TObject; Node: TTreeNode);
begin
  if Node = nil then
    doRefreshBicos(nil)
  else
    doRefreshBicos(Node);
end;

end.
