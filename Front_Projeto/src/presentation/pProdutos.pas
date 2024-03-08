unit pProdutos;

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
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  bProdutos,
  dmData;

type
  TfrmProdutos = class(TForm)
    dbGradeProdutos: TDBGrid;
    btAtualizar: TButton;
    lbListagem: TLabel;
    GroupBox1: TGroupBox;
    btCadastro: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    procedure btAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCadastroClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    bProd : TProdutos;

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.btAtualizarClick(Sender: TObject);
begin
  bProd.atualizaRegistros;
end;

procedure TfrmProdutos.btCadastroClick(Sender: TObject);
begin
  bProd.criaCadOuEditaProd(Sender);
end;

procedure TfrmProdutos.btEditarClick(Sender: TObject);
begin
  bProd.criaCadOuEditaProd(Sender);
end;

procedure TfrmProdutos.btExcluirClick(Sender: TObject);
begin
  bProd.ExcluiProduto
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  bProd := TProdutos.Create;
end;

procedure TfrmProdutos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(bProd);
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  btAtualizarClick(Sender);
end;

end.
