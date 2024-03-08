unit Controller.Produto;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  Entity.Produto,
  FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL,
  MVCFramework.SQLGenerators.MSSQL,
  MVCFramework.ActiveRecord;

  type
  [MVCPath('/api')]
  TControllerProduto = class(TMVCController)
  private
    FDConn : TFDConnection;
  public
    [MVCPath('/produtos')]
    [MVCHTTPMethod([httpGET])]
    procedure GetProdutos;

    [MVCPath('/produtos')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddProduto;

    [MVCPath('/produtos/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetProduto(id: Integer);

    [MVCPath('/produtos/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateProduto(id: Integer);

    [MVCPath('/produtos/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteProduto(id: Integer);

    constructor create; override;
    procedure fechaConexao;
  end;

implementation

uses
  MVCFramework.Serializer.Intf,
  System.SysUtils,
  MVCFramework.DataSet.Utils,
  MVCFramework.Logger,
  JsonDataObjects;

{ TControllerProduto }

procedure TControllerProduto.AddProduto;
var
  LProduto : TProduto;
begin
  try
    LProduto := Context.Request.BodyAs<TProduto>;
    LProduto.Insert;
    Render(201, 'Produto adicionado com sucesso.');
  Finally
    fechaConexao;
  End;
end;

constructor TControllerProduto.create;
begin
  inherited;
  FDConn := TFDConnection.Create(nil);
  FDConn.Params.Clear;
  FDConn.Params.DriverID := 'MSSQL';
  FDConn.Params.Database := 'PRODUTOS';
  FDConn.Params.UserName := 'SYSDBA';
  FDConn.Params.Password := '123456';
  FDConn.Params.Add('Server=Steve-PC');
  FDConn.Connected := True;

  ActiveRecordConnectionsRegistry.AddDefaultConnection(FDConn);
end;

procedure TControllerProduto.DeleteProduto(id: Integer);
var
  LProduto: TProduto;
begin
  LProduto := TMVCActiveRecord.GetByPK<TProduto>(id);
  Try
    if Assigned(LProduto) then
    begin
      LProduto.Delete;
      Render(204, 'Produto excluído com sucesso.');
    end
    else
      Render(404, 'Produto não encontrado.');
  Finally
    fechaConexao;
  End;
end;

procedure TControllerProduto.fechaConexao;
begin
  ActiveRecordConnectionsRegistry.RemoveDefaultConnection;
  FDConn.Free;   
end;

procedure TControllerProduto.GetProduto(id: Integer);
var
  LProduto: TProduto;
begin
  LProduto := TMVCActiveRecord.GetByPK<TProduto>(id);
  try
    if Assigned(LProduto) then
      Render(LProduto)
    else
      Render(404, 'Produto não encontrado.');
  Finally
    fechaConexao;
  End;
end;

procedure TControllerProduto.GetProdutos;
var
  LProduto : TObjectList<TProduto>;
begin
  LProduto := TMVCActiveRecord.SelectRQL<TProduto>('',-1);
  try
    if LProduto.Count > 0 then
      Render<TProduto>(LProduto)
    else
      Render(404, 'Produtos não encontrados.');
  Finally
    fechaConexao;
  End;
end;

procedure TControllerProduto.UpdateProduto(id: Integer);
var
  LProduto : TProduto;
begin
  LProduto := Context.Request.BodyAs<TProduto>;
  LProduto.id := id;
  try
    if Assigned(LProduto) then
    begin
      LProduto.Update;
      Render(200, 'Produto atualizado com sucesso.');
    end
    else
      Render(404, 'Produto não encontrado.');
  Finally
    fechaConexao;
  End;  
end;

end.
