unit pOperaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmOperacoes = class(TForm)
    lbNome: TLabel;
    edNome: TEdit;
    lbQuantidade: TLabel;
    edQuantidade: TEdit;
    edValor: TEdit;
    lbValor: TLabel;
    btConfirma: TButton;
    btCancela: TButton;
    edID: TEdit;
    lbID: TLabel;
    procedure btCancelaClick(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    mResult : integer;
  end;

var
  frmOperacoes: TfrmOperacoes;

implementation

{$R *.dfm}

procedure TfrmOperacoes.btCancelaClick(Sender: TObject);
begin
  mResult := 8;
  Close;
end;

procedure TfrmOperacoes.btConfirmaClick(Sender: TObject);

var id, qtde : Integer;
    nome : string;
    valor : Double;

begin
   // teste
  mResult := 1;
  Close;
end;

procedure TfrmOperacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mResult;
end;

end.
