unit pOperaProduto;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask;

type
  TfrmOperacoes = class(TForm)
    lbNome: TLabel;
    edNome: TEdit;
    lbValor: TLabel;
    btConfirma: TButton;
    btCancela: TButton;
    edID: TEdit;
    lbID: TLabel;
    edDescricao: TEdit;
    lbDescricao: TLabel;
    edValor: TMaskEdit;
    procedure btCancelaClick(Sender: TObject);
    procedure btConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edValorKeyPress(Sender: TObject; var Key: Char);
    procedure edValorExit(Sender: TObject);
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

procedure TfrmOperacoes.edValorExit(Sender: TObject);
begin
  edValor.Text := FormatFloat('#,##0.00', StrToFloat(edValor.Text));
end;

procedure TfrmOperacoes.edValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',']) then
  begin
    // Impede que a tecla seja processada
    Key := #0;
  end;
end;

procedure TfrmOperacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mResult;
end;

procedure TfrmOperacoes.FormCreate(Sender: TObject);
begin
  mResult := 0;
end;

end.
