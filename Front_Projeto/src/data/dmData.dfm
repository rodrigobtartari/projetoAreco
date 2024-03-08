object mData: TmData
  OnCreate = DataModuleCreate
  Height = 103
  Width = 187
  object dsProdutos: TDataSource
    DataSet = mtProdutos
    Left = 104
    Top = 16
  end
  object mtProdutos: TFDMemTable
    AfterOpen = mtProdutosAfterOpen
    BeforePost = mtProdutosBeforePost
    BeforeDelete = mtProdutosBeforeDelete
    BeforeRefresh = mtProdutosBeforeRefresh
    FieldDefs = <>
    IndexDefs = <>
    BeforeRowRequest = mtProdutosBeforeRowRequest
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 24
    Top = 16
    object mtProdutosID: TIntegerField
      FieldName = 'id'
    end
    object mtProdutosNOME: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object mtProdutosDESCRICAO: TStringField
      FieldName = 'descricao'
      Size = 150
    end
    object mtProdutosPRECO: TFloatField
      FieldName = 'preco'
      DisplayFormat = '###,#00.00'
      EditFormat = '###,#000.00;0;_'
    end
  end
end
