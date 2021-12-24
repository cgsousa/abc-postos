object dmStdConn: TdmStdConn
  OldCreateOrder = False
  Height = 275
  Width = 251
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 88
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\develop\projetos\delphi\fortes-tecnologia\bin\abc21p' +
        'osto.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 152
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvParamCreate]
    SQL.Strings = (
      
        'INSERT INTO pedido(data,id_bico,quantidate,valor_unitario,valor_' +
        'total,aliquota_imposto, valor_imposto )'
      
        'VALUES(:data,:id_bico,:quantidate,:valor_unitario,:valor_total,:' +
        'aliquota_imposto,:valor_imposto )')
    Left = 144
    Top = 192
    ParamData = <
      item
        Position = 1
        Name = 'DATA'
        DataType = ftDate
        ParamType = ptInput
        Value = 44527d
      end
      item
        Position = 2
        Name = 'ID_BICO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Position = 3
        Name = 'QUANTIDATE'
        DataType = ftString
        ParamType = ptInput
        Value = '15'
      end
      item
        Position = 4
        Name = 'VALOR_UNITARIO'
        DataType = ftString
        ParamType = ptInput
        Value = '6'
      end
      item
        Position = 5
        Name = 'VALOR_TOTAL'
        DataType = ftString
        ParamType = ptInput
        Value = '10'
      end
      item
        Position = 6
        Name = 'ALIQUOTA_IMPOSTO'
        DataType = ftString
        ParamType = ptInput
        Value = '5'
      end
      item
        Position = 7
        Name = 'VALOR_IMPOSTO'
        DataType = ftString
        ParamType = ptInput
        Value = '5'
      end>
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Error'
    Left = 45
    Top = 216
  end
end
