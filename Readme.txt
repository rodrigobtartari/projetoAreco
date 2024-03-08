************** Desafio Delphi ***************

Projetos criados utilizando Delphi 12 Athens.

Há duas pastas, uma da API (API_Projeto) do BackEnd e do Front (Front_Projeto).

A API foi desenvolvida com DMVCFramework v3.4.1-sodium, por tanto deve ser baixado e instalado antes de compilar os projetos.

Link para download:
https://github.com/danieleteti/delphimvcframework/releases/tag/v3.4.1-sodium

Na pasta "..\API_Projeto\data" temos um backup do banco de dados utilizado para esse projeto, necessário restaurar o banco PRODUTOS 

e no arquivo "..\API_Projeto\src\Controller\Controller.Produto.pas" é necessário ajustar os parâmetros de conexão do componente FireDac conforme método mostrado abaixo:

constructor TControllerProduto.create;
begin
  inherited;
  FDConn := TFDConnection.Create(nil);
  FDConn.Params.Clear;
  FDConn.Params.DriverID := 'MSSQL';
  FDConn.Params.Database := 'PRODUTOS';
  FDConn.Params.UserName := 'SYSDBA';   <-- Aqui
  FDConn.Params.Password := '123456';   <-- Aqui
  FDConn.Params.Add('Server=Steve-PC'); <-- Aqui
  FDConn.Connected := True;
 
Para o projeto em "Front_Projeto" não é necessária nenhuma alteração para execução do mesmo.

*********************************************************************************************

Para utilizar é simples, basta compilar e executar o projeto da API, e posteriormente compilar e executar o projeto do Front,
a tela tem poucas informações e é bastante intuitiva. 

Em um grid na tela principal são exibidos os registros, e possuimos botões para atualizar os dados, Incluir, alterar e excluir produtos. Incluir e Alterar são utilizados 
em um formulário para digitação das informações a serem gravadas e a exclusão é feita na própria tela principal.

Qualquer dúvida ou problema estou à disposição

Para contato:
(19) 99406-9873
rodrigo.btartari@outlook.com