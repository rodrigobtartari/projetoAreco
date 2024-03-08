unit bProdutos;

interface

uses
  System.SysUtils,
  System.Types,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  pOperaProduto,
  Data.DB;

type
  TProdutos = Class(TObject)
  private
    pOpProduto : TfrmOperacoes;
  public
    procedure atualizaRegistros;
    procedure ExcluiProduto;
    procedure criaCadOuEditaProd(funcao: TObject);
  End;

implementation

uses
  dmData;

{ TProdutos }

procedure TProdutos.atualizaRegistros;
begin
  mData.mtProdutos.Close;
  mData.mtProdutos.Open;
end;

Procedure TProdutos.ExcluiProduto;
begin
  try
    mData.mtProdutos.Delete;
    ShowMessage('Produto Excluido com Sucesso.');
  except
    on e : EDatabaseError do
    raise Exception.Create('Erro ao excluir produto.' + e.Message);
  end;
end;

procedure TProdutos.criaCadOuEditaProd(funcao: TObject);

var id,qtde : Integer;
    nome : string;
    valor : double;
    IDRect, NomeRect, lbIDRect, lbNomeRect : TRect;

begin
  try
    try
      // Cria o Objeto
      pOpProduto := TfrmOperacoes.Create(Nil);
      lbIDRect := pOpProduto.lbID.BoundsRect;
      IDRect := pOpProduto.edID.BoundsRect;
      lbNomeRect := pOpProduto.lbNome.BoundsRect;
      NomeRect := pOpProduto.edNome.BoundsRect;
      // De acordo com o Botão inicializa o form de operar produto de forma diferente
      if (funcao as TButton).Name = 'btCadastro' then begin
        pOpProduto.Caption     := 'Cadastrar Produto';
        pOpProduto.edNome.Left := IDRect.Left;
        pOpProduto.lbNome.Left := lbIDRect.Left;
        pOpProduto.lbID.Visible := False;
        pOpProduto.edID.Visible := False;
      end else if (funcao as TButton).Name = 'btEditar' then begin
        // Não deixo alterar a ID do Produto
        pOpProduto.lbID.Enabled := False;
        pOpProduto.Caption := 'Editar Produto';
        pOpProduto.edID.Text := mData.mtProdutosID.AsString;
        pOpProduto.edNome.Text := mData.mtProdutosNOME.AsString;
        pOpProduto.edDescricao.Text := mData.mtProdutosDESCRICAO.AsString;
        pOpProduto.edValor.Text := mData.mtProdutosPRECO.AsString;
      end;

      pOpProduto.ShowModal;

      if pOpProduto.ModalResult = 0 then begin
        exit;
      end else if pOpProduto.ModalResult = 8 then
        ShowMessage('Cancelado pelo usuário.')
      else
      begin
        try
          if (funcao as TButton).Name = 'btCadastro' then begin
            mData.mtProdutos.Append;
            mData.mtProdutosNOME.AsString := pOpProduto.edNome.Text;
            mData.mtProdutosDESCRICAO.AsString := pOpProduto.edDescricao.Text;
            mData.mtProdutosPRECO.AsFloat := StrToFloat(pOpProduto.edValor.Text);
            mData.mtProdutos.Post;
          end else if (funcao as TButton).Name = 'btEditar' then begin
            mData.mtProdutos.Edit;
            mData.mtProdutosID.AsInteger := StrToInt(pOpProduto.edID.Text);
            mData.mtProdutosNOME.AsString := pOpProduto.edNome.Text;
            mData.mtProdutosDESCRICAO.AsString := pOpProduto.edDescricao.Text;
            mData.mtProdutosPRECO.AsFloat := StrToFloat(pOpProduto.edValor.Text);
            mData.mtProdutos.Post;
          end;
        finally
          ShowMessage('Gravado/Alterado com Sucesso.');
        end;
      end;
    except
      on e : EDatabaseError do
      raise Exception.Create('Erro ao Criar/Alterar produto.');
    end;
  finally
    // libera o objeto
    pOpProduto.Free;
  end;
end;

end.
