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
    // Cria o formul�rio para cadastro ou edi��o do Produto
    procedure criaCadOuEditaProd(funcao : TObject);
  end;

implementation

{ TOperaProduto }


end.
