object fraToolBar: TfraToolBar
  Left = 0
  Top = 0
  Width = 121
  Height = 480
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentCtl3D = False
  ParentFont = False
  TabOrder = 0
  object pnlToolBar: TStackPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Button1
        HorizontalPositioning = sphpCenter
      end
      item
        Control = Button2
        HorizontalPositioning = sphpCenter
      end
      item
        Control = Button3
        HorizontalPositioning = sphpCenter
      end
      item
        Control = Button4
        HorizontalPositioning = sphpCenter
      end
      item
        Control = Button5
        HorizontalPositioning = sphpCenter
      end>
    Padding.Top = 5
    Spacing = 5
    TabOrder = 0
    ExplicitWidth = 150
    object Button1: TButton
      Left = 9
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Button1'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 9
      Top = 40
      Width = 100
      Height = 30
      Caption = 'Button2'
      TabOrder = 1
    end
    object Button3: TButton
      Left = 9
      Top = 75
      Width = 100
      Height = 30
      Caption = 'Button3'
      TabOrder = 2
    end
    object Button4: TButton
      Left = 9
      Top = 110
      Width = 100
      Height = 30
      Caption = 'Button4'
      TabOrder = 3
    end
    object Button5: TButton
      Left = 9
      Top = 145
      Width = 100
      Height = 30
      Caption = 'Button5'
      TabOrder = 4
    end
  end
end
