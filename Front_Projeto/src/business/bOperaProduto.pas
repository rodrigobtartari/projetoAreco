unit bOperaProduto;

interface

uses
  Vcl.StdCtrls,
  Vcl.Dialogs,
  System.StrUtils,
  System.SysUtils,
  pOperaProduto;

type
  TOperaProduto = class(TObject)
  mproduto : TfrmOperacoes;
  private

  public
    // Cria o formulário para cadastro ou edição do Produto
    procedure criaCadOuEditaProd(funcao : TObject);
  end;

implementation

{ TOperaProduto }


end.
