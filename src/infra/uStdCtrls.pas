unit uStdCtrls;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls,	Vcl.Forms, Vcl.StdCtrls,
  Vcl.Dialogs ;

type
  MsgDlg = object
    function comfirm(const aMsg: string): Boolean;
    procedure info(const aMsg: string);
    procedure alert(const aMsg: string);
  end;

type

  TCustomEditHlp = class helper for TCustomEdit
    procedure DoClear;
    procedure DoFormat(const AFormat: string;	const Args: array of const);
    function IsEmpty(const AMsg: string = ''): Boolean ;
  end;

  TCustomComboHlp = class helper for TCustomCombo
  public
    procedure AddText(const AText: string; const AItemIndex: Integer =0);
  end;

  TBaseForm = class (TForm)
  private
    procedure controlNext;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
  public
    procedure inicialize; virtual;
  end;


var
  dlg: MsgDlg;

implementation


{ MsgDlg }

procedure MsgDlg.alert(const aMsg: string);
begin
  TaskMessageDlg('Advertência', aMsg, mtWarning, [mbOK], 0);
end;

function MsgDlg.comfirm(const aMsg: string): Boolean;
begin
  Result :=TaskMessageDlg('Confirmação', aMsg, mtConfirmation, mbOKCancel, 0) = mrOk;
end;

procedure MsgDlg.info(const aMsg: string);
begin
  TaskMessageDlg('Informação', aMsg, mtInformation, [mbOK], 0);
end;

{ TCustomEditHlp }

procedure TCustomEditHlp.DoClear;
begin

end;

procedure TCustomEditHlp.DoFormat(const AFormat: string;
  const Args: array of const);
begin

end;

function TCustomEditHlp.IsEmpty(const AMsg: string): Boolean;
begin

end;

{ TCustomComboHlp }

procedure TCustomComboHlp.AddText(const AText: string;
  const AItemIndex: Integer);
begin

end;

{ TBaseForm }

procedure TBaseForm.controlNext;
begin
	if Assigned(ActiveControl) then
		SelectNext(ActiveControl, True, True);
end;

procedure TBaseForm.inicialize;
begin

end;

procedure TBaseForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
    if not ((ActiveControl is TComboBox) and TComboBox(ActiveControl).DroppedDown) then
    begin
      ModalResult := mrCancel;
    end;
    VK_RETURN:
    if Assigned(ActiveControl) then
    begin
      controlNext ;
    end;
  else
    inherited;
  end;
end;

procedure TBaseForm.Loaded;
begin
  inherited;
	KeyPreview:=True;
	Position  :=poScreenCenter;
end;


end.
