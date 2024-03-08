unit dmData;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  MVCFramework.RESTClient.Intf,
  MVCFramework.RESTClient,
  MVCFramework.DataSet.Utils,
  Vcl.Dialogs;

type
  TmData = class(TDataModule)
    dsProdutos: TDataSource;
    mtProdutos: TFDMemTable;
    mtProdutosID: TIntegerField;
    mtProdutosNOME: TStringField;
    mtProdutosDESCRICAO: TStringField;
    mtProdutosPRECO: TFloatField;
    procedure mtProdutosAfterOpen(DataSet: TDataSet);
    procedure mtProdutosBeforeDelete(DataSet: TDataSet);
    procedure mtProdutosBeforePost(DataSet: TDataSet);
    procedure mtProdutosBeforeRefresh(DataSet: TDataSet);
    procedure mtProdutosBeforeRowRequest(DataSet: TFDDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fFilter: string;
    fLoading: Boolean;
    fRESTClient: IMVCRESTClient;
    procedure showError(const AResponse: IMVCRESTResponse);
  public
    { Public declarations }
  end;

var
  mData: TmData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TmData.DataModuleCreate(Sender: TObject);
begin
  fRESTClient := TMVCRESTClient.New.BaseURL('localhost', 8080);
end;

procedure TmData.mtProdutosAfterOpen(DataSet: TDataSet);
var
  Res: IMVCRESTResponse;
begin
  // this a simple sychronous request...
  Res := fRESTClient.Get('/api/produtos');

  if not Res.Success then
  begin
    ShowError(Res);
    Exit;
  end;

  DataSet.DisableControls;
  try
    fLoading := true;
    mtProdutos.LoadJSONArrayFromJSONObjectProperty('data', '{"data":' + Res.Content + '}');
    fLoading := false;
    mtProdutos.First;
  finally
    DataSet.EnableControls;
  end;
end;

procedure TmData.mtProdutosBeforeDelete(DataSet: TDataSet);
var
  Res: IMVCRESTResponse;
begin
  if mtProdutos.State = dsBrowse then
    Res := fRESTClient.DataSetDelete('/api/produtos', mtProdutosid.AsString);
  if not(Res.StatusCode in [204]) then
  begin
    ShowError(Res);
    Abort;
  end;
end;

procedure TmData.mtProdutosBeforePost(DataSet: TDataSet);
var
  Res: IMVCRESTResponse;
begin
  if not fLoading then
  begin
    if mtProdutos.State = dsInsert then
      Res := fRESTClient.DataSetInsert('/api/produtos', mtProdutos)
    else
      Res := fRESTClient.DataSetUpdate('/api/produtos', mtProdutosid.AsString, mtProdutos);
    if not(Res.StatusCode in [200, 201]) then
    begin
      ShowError(Res);
      Abort;
    end
    else
    begin
      DataSet.Refresh;
    end;
  end;
end;

procedure TmData.mtProdutosBeforeRefresh(DataSet: TDataSet);
begin
  DataSet.Close;
  DataSet.Open;
end;

procedure TmData.mtProdutosBeforeRowRequest(DataSet: TFDDataSet);
var
  Res: IMVCRESTResponse;
begin
  Res := fRESTClient
    .AddPathParam('param1', DataSet.FieldByName('id').AsString)
    .Get('/produtos/{param1}');
  fLoading := true;
  DataSet.LoadJSONObjectFromJSONObjectProperty('data', Res.Content);
  fLoading := false;
end;

procedure TmData.showError(const AResponse: IMVCRESTResponse);
begin
  if not AResponse.Success then
    MessageDlg(
      AResponse.StatusCode.ToString + ': ' + AResponse.StatusText + sLineBreak +
      '[' + AResponse.Content + ']',
      mtError, [mbOK], 0)
  else
    MessageDlg(
      AResponse.StatusCode.ToString + ': ' + AResponse.StatusText + sLineBreak +
      AResponse.Content,
      mtError, [mbOK], 0);
end;

end.
