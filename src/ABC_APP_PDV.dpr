program ABC_APP_PDV;

uses
  Vcl.Forms,
  Form.Princ00 in 'Form.Princ00.pas' {frmPrinc00},
  udatabase in 'infra\udatabase.pas',
  uStdCtrls in 'infra\uStdCtrls.pas',
  ORM.Attr in 'orm\ORM.Attr.pas',
  ORM.Intf in 'orm\ORM.Intf.pas',
  Frame.ToolBar in 'infra\dm\Frame.ToolBar.pas' {fraToolBar: TFrame},
  Form.Produto in 'visao\Form.Produto.pas' {frmProduto},
  Pedido in 'dominio\Pedido.pas',
  produto in 'dominio\produto.pas',
  drv.FireDac in 'orm\drv\drv.FireDac.pas',
  ORM.BaseDAO in 'orm\ORM.BaseDAO.pas',
  Form.PDV in 'visao\Form.PDV.pas' {frmPDV},
  Pedido.Negocio in 'negocio\Pedido.Negocio.pas',
  Cadastro.Negocio in 'negocio\Cadastro.Negocio.pas',
  Tanque in 'dominio\Tanque.pas',
  Bomba in 'dominio\Bomba.pas',
  Bico in 'dominio\Bico.pas',
  BaseItem in 'dto\BaseItem.pas',
  ORM.SQLAttr in 'orm\ORM.SQLAttr.pas',
  BaseRTTI in 'orm\BaseRTTI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrinc00, frmPrinc00);
  Application.Run;
end.
