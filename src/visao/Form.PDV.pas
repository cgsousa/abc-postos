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
    fCadastroNegocio: TCadastroNegocio;
    fTanques: TBaseItem;
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
  item: TListItem;
  bico: TBaseItem;
begin
  TryStrToFloat(Trim(edtQtd.Text), qtd);
  if(qtd <= 0)then
  begin
    dlg.alert('O campo quantidade DEVE ser informado!');
    edtQtd.SetFocus;
    exit;
  end;

  item :=lvBicos.Items[lvBicos.ItemIndex];
  bico :=TBaseItem(item.Data);

  if not Assigned(fPedido)then
  begin
    fPedido :=TPedido.Create ;
    fPedido.data :=Date;
    fPedido.idBico :=bico.id;
    fPedido.quantidate :=qtd;
    fPedido.valorUnitario :=bico.pro_preco;
    fPedido.valorTotal :=qtd *bico.pro_preco;
    fPedido.valorImposto :=(qtd *bico.pro_preco) *(bico.pro_imposto/100);

    lvPedido.Items.BeginUpdate;
    try
      lvPedido.Items.Clear;

      item :=lvPedido.Items.Add;
      item.Caption :=Format('%d %s',[bico.id,bico.pro_descr]);
      item.SubItems.Add(Format('%7.3f',[fPedido.quantidate]));
      item.SubItems.Add(bico.pro_unid);
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
  negocio: TPedidoNegocio;
begin
  if dlg.comfirm('Confirmar venda?')then
  begin
    negocio :=TPedidoNegocio.Create;
    //negocio.inserirOrAtualizar();
  end;
end;

class function TfrmPDV.createAndShow: Boolean;
var
  view: TfrmPDV;
begin
  view :=TfrmPDV.Create(Application);
  try
    Result :=view.ShowModal() = mrOk;
  finally
    FreeAndNil(view);
  end;
end;

procedure TfrmPDV.DoCreate;
begin
  inherited;
  fCadastroNegocio :=TCadastroNegocio.Create;
  fTanques :=TBaseItem.Create;
  fPedido :=nil;
  inicialize;
end;

procedure TfrmPDV.DoDestroy;
begin
  inherited;
  fTanques.Free ;
end;

procedure TfrmPDV.doRefreshBicos(aNode: TTreeNode);
var
  tanque,
  bomba,
  bico: TBaseItem;
  item: TListItem;
begin
  lvBicos.Items.BeginUpdate;
  try
    lvBicos.Items.Clear;

    if aNode = nil then
      Exit;

    if(aNode.Data <> nil)then
    begin
      bomba :=TBaseItem(aNode.Data);
      bico :=bomba.items[0];

      item :=lvBicos.Items.Add;
      item.Caption :=bico.descricao;
      item.SubItems.Add('-');
      item.SubItems.Add(Format('%12.3m',[bico.pro_preco]));
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
  bico: TBaseItem;
  //n0,n1: TTreeNode;
begin

  fTanques :=fCadastroNegocio.buscarBicosPorTanque() ;

  tvBomba.Items.BeginUpdate;
  try
    tvBomba.Items.Clear;
    for tanque in fTanques.items do
    begin
      for bomba in tanque.items do
      begin
        //
        // tanque/bomba
        tvBomba.Items.AddNode(nil, nil,
                              Format('BOMBA%d %s /%s Capacidade:%8.2f%s',[
                                                            bomba.id,
                                                            bomba.descricao,
                                                            tanque.descricao,
                                                            tanque.capacidade,
                                                            tanque.pro_unid
                                                            ]
                                    ),
                                    bomba,
                                    naAdd
        );
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
