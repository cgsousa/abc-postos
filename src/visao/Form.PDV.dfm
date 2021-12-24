object frmPDV: TfrmPDV
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ponto de Venda'
  ClientHeight = 422
  ClientWidth = 594
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object StackPanel1: TStackPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 350
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Panel1
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = tvBomba
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = lvBicos
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = pnlQtde
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = lvPedido
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end>
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    Spacing = 3
    TabOrder = 0
    object Panel1: TPanel
      Left = 3
      Top = 3
      Width = 586
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '.:Selecione a Bomba/Bico:.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object tvBomba: TTreeView
      Left = 3
      Top = 36
      Width = 586
      Height = 125
      Indent = 19
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ToolTips = False
      OnChange = tvBombaChange
    end
    object lvBicos: TListView
      Left = 3
      Top = 164
      Width = 586
      Height = 70
      Columns = <
        item
          Caption = 'Bico'
        end
        item
          Caption = 'Combust'#237'vel'
          Width = 150
        end
        item
          Alignment = taRightJustify
          Caption = 'R$ Pre'#231'o'
          Width = 121
        end>
      HotTrack = True
      Items.ItemData = {
        053C0000000200000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
        00024200310000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000242
        003200}
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      TabStop = False
      ViewStyle = vsReport
    end
    object pnlQtde: TPanel
      Left = 3
      Top = 237
      Width = 586
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 78
        Height = 30
        Align = alLeft
        Caption = 'Quantidate:  '
        ExplicitHeight = 18
      end
      object edtQtd: TMaskEdit
        Left = 78
        Top = 0
        Width = 121
        Height = 30
        Align = alLeft
        Alignment = taRightJustify
        TabOrder = 0
        Text = ''
        ExplicitHeight = 24
      end
      object Button1: TButton
        Left = 486
        Top = 0
        Width = 100
        Height = 30
        Action = actAdd
        Align = alRight
        TabOrder = 1
        ExplicitLeft = 372
      end
    end
    object lvPedido: TListView
      Left = 3
      Top = 270
      Width = 586
      Height = 50
      Columns = <
        item
          Caption = '# Descri'#231#227'o'
          Width = 250
        end
        item
          Alignment = taRightJustify
          Caption = 'Qtd'
          Width = 75
        end
        item
          Alignment = taCenter
          Caption = 'UND'
        end
        item
          Alignment = taRightJustify
          Caption = 'V.Unit'#225'rio'
          Width = 75
        end
        item
          Alignment = taRightJustify
          Caption = 'V.Total'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 4
      ViewStyle = vsReport
    end
  end
  object pnlFooter: TStackPanel
    Left = 0
    Top = 382
    Width = 594
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Button2
      end
      item
        Control = Button3
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    Orientation = spoHorizontal
    Padding.Left = 5
    ParentFont = False
    Spacing = 3
    TabOrder = 1
    ExplicitTop = 572
    ExplicitWidth = 474
    object Button2: TButton
      Left = 5
      Top = 4
      Width = 100
      Height = 30
      Action = actConfirm
      TabOrder = 0
    end
    object Button3: TButton
      Left = 108
      Top = 4
      Width = 100
      Height = 30
      Action = actCancel
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 408
    Top = 24
    object actConfirm: TAction
      Caption = 'Comfirmar'
      OnExecute = actConfirmExecute
    end
    object actCancel: TAction
      Caption = 'Cancelar'
      OnExecute = actCancelExecute
    end
    object actAdd: TAction
      Caption = 'Adicionar'
      OnExecute = actAddExecute
    end
  end
end
