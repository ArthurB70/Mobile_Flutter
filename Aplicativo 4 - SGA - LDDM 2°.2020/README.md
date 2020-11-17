# SGA - Sistema de Gestão Acadêmica
Aplicativo para organizar o controle financeiro do usuário.
# Vídeo demonstrativo
https://www.youtube.com/watch?v=84d288ZscFc
# Funcionalidade
O aplicativo recebe do usuário uma matrícula e uma senha e retorna as informações do usuário. Caso o cadastro não exista ele pode ser feito escolhendo a opção "CADASTRO" na página de Login.
# Documentação
1. Aluno.view.dart - Partição que define a visualização do aplicativo ao usuário.

    * class LoginPage - Classe que constrói o Widget da página de Login;
    * class Cadastro  - Classe que constrói o Widget da página de Cadastro;
    * class PrintAluno - Classe que constrói o Widget da página de informações do usuário;
    * _fieldSenha(String nomeCampo, TextEditingController controller)_- Recebe o título de um campo do formulário e retorna o campo da senha configurado;
    * _fieldGeral(String nomeCampo, TextEditingController controller)_- Recebe o título de um campo do formulário e retorna o campo da senha configurado.
    
2. Aluno.model.dart - Partição que define o modelo de dados utilizado no aplicativo
3. Aluno.controller.dart e Aluno.controller.g.dart- Partição que controla os dados utilizados no aplicativo
5. Aluno.repository.dart, Aluno.dao.dart, Aluno.database.dart e Aluno.database.g.dart - Partição que armazena e recupera os dados no aplicativo 
5. main.dart - Ponto de partida do aplicativo 

