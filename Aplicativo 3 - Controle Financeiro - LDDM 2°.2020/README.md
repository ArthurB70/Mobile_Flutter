# Controle Financeiro
Aplicativo para organizar o controle financeiro do usuário.
# Vídeo demonstrativo
https://www.youtube.com/watch?v=-p7njaJyqCQ
# Funcionalidade
O aplicativo recebe do usuário uma escolha de um mês dentre uma lista de meses e retorna uma segunda página com uma lista de itens lançados no mês, uma soma dos lançamentos do mês e um botão o qual possibilita a adição de um novo lançamento.
# Documentação
1. AppControleFinanceiro.List_view.view.dart - Partição que define a visualização do aplicativo ao usuário.. 

    * class HomePage - Classe que constrói o Widget da página principal;
    * class printMes - Classe que constrói o Widget da página secundária;
    * _editText(String field, TextEditingController controller) - Recebe o título de um campo do formulário e retorna o campo configurado;
    * _displayDialog(context, int numeroMes) - Recebe um id de um mês e retorna o pop-up do formulário;
    * double retornaSoma(int numeroMes) - Recebe um id de um mês e retorna a soma dos lançamentos desse mês;
    * _popupMenuButton() - Retorna o pop-up do SharedPreference do tema da aplicação;
    * _loadTheme() - Lê o SharedPreference;
    * _setTheme(theme) - Salva o SharedPreference.
    

2. AppControleFinanceiro.models.dart - Partição que define o modelo de dados utilizado no aplicativo
3. AppControleFinanceiro.controller.dart - Partição que controla os dados utilizados no aplicativo
4. AppControleFinanceiro.repository.dart - Partição que armazena e recupera os dados no aplicativo 
5. main.dart - Ponto de partida do aplicativo 
