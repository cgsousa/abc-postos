object frmPrinc00: TfrmPrinc00
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'ABC Controle de Abastecimentos e tanques de combust'#237'veis '
  ClientHeight = 452
  ClientWidth = 794
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object pnlFooter: TStackPanel
    Left = 0
    Top = 412
    Width = 794
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Button1
      end
      item
        Control = Button2
      end
      item
        Control = Button3
      end
      item
        Control = Button4
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    Orientation = spoHorizontal
    Padding.Left = 5
    ParentFont = False
    Spacing = 3
    TabOrder = 0
    object Button1: TButton
      Left = 5
      Top = 4
      Width = 100
      Height = 30
      Action = actFilter
      TabOrder = 0
    end
    object Button2: TButton
      Left = 108
      Top = 4
      Width = 100
      Height = 30
      Action = actNew
      TabOrder = 1
    end
    object Button3: TButton
      Left = 211
      Top = 4
      Width = 100
      Height = 30
      Action = actReport
      TabOrder = 2
    end
    object Button4: TButton
      Left = 314
      Top = 4
      Width = 100
      Height = 30
      Action = actClose
      TabOrder = 3
    end
  end
  object pnlFilter: TStackPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 412
    Align = alLeft
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Label1
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = Label2
      end
      item
        Control = dpData1
      end
      item
        Control = dpData2
      end
      item
        Control = btnExec
      end>
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 159
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = 'Filtro'
      Color = clGradientInactiveCaption
      ParentColor = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 0
      Top = 20
      Width = 47
      Height = 18
      Caption = 'Periodo:'
    end
    object dpData1: TDatePicker
      AlignWithMargins = True
      Left = 3
      Top = 43
      Date = 44553.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 0
    end
    object dpData2: TDatePicker
      AlignWithMargins = True
      Left = 3
      Top = 83
      Date = 44553.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 1
    end
    object btnExec: TButton
      AlignWithMargins = True
      Left = 3
      Top = 123
      Width = 100
      Height = 30
      Caption = 'Executar'
      TabOrder = 2
      OnClick = btnExecClick
    end
  end
  object StackPanel1: TStackPanel
    Left = 161
    Top = 0
    Width = 633
    Height = 412
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = HeaderControl1
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = tvData
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = lvPedidos
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpFill
      end>
    TabOrder = 2
    DesignSize = (
      631
      410)
    object HeaderControl1: THeaderControl
      Left = 0
      Top = 0
      Width = 631
      Height = 21
      Align = alNone
      Anchors = [akLeft, akTop, akRight]
      Sections = <
        item
          ImageIndex = -1
          Text = 'Dia /Tanque /Bomba'
          Width = 200
        end
        item
          ImageIndex = -1
          Text = 'TOTAL'
          Width = 121
        end>
    end
    object tvData: TTreeView
      Left = 0
      Top = 23
      Width = 631
      Height = 178
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Indent = 19
      ParentFont = False
      TabOrder = 0
      OnChange = tvDataChange
    end
    object lvPedidos: TListView
      Left = 0
      Top = 203
      Width = 631
      Height = 208
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'ID'
          Width = 40
        end
        item
          Caption = 'Descri'#231#227'o'
          Width = 200
        end
        item
          Alignment = taRightJustify
          Caption = 'Qtde'
          Width = 75
        end
        item
          Alignment = taRightJustify
          Caption = 'R$ V.Unit'#225'rio'
          Width = 90
        end
        item
          Alignment = taRightJustify
          Caption = 'R$ V.Total'
          Width = 100
        end
        item
          Alignment = taRightJustify
          Caption = 'R$ V.Imposto'
          Width = 85
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object ActionList1: TActionList
    Left = 536
    Top = 16
    object actFilter: TAction
      Caption = 'Filtro'
      OnExecute = actFilterExecute
    end
    object actNew: TAction
      Caption = 'PDV'
      OnExecute = actNewExecute
    end
    object actReport: TAction
      Caption = 'Relat'#243'rio'
    end
    object actClose: TAction
      Caption = 'Terminar'
      OnExecute = actCloseExecute
    end
  end
end
