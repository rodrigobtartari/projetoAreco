program ListaProdutos;

uses
  Vcl.Forms,
  pOperaProduto in '..\src\presentation\pOperaProduto.pas' {frmOperacoes},
  pProdutos in '..\src\presentation\pProdutos.pas' {frmProdutos},
  bProdutos in '..\src\business\bProdutos.pas',
  dmData in '..\src\data\dmData.pas' {mData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.CreateForm(TmData, mData);
  Application.Run;
end.
