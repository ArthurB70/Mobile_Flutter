# Lista de Viagem
Aplicativo para listar itens necessários para uma viagem.
# Vídeo demonstrativo
https://www.youtube.com/watch?v=gGcZ-kXxQIU
# Funcionalidade
O aplicativo recebe do usuário uma escolha de qual lista prévia(roupas femininas ou masculinas) o usuário deseja utilizar. Após a escolha, uma segunda tela apresenta a lista de itens além de opções para aumentar e diminuir a quantidade de itens, excluir o item, assinalar o item(✔️) e adicionar novos itens.
# Documentação
1. Item.List_view.view.dart - Partição que define a visualização do aplicativo ao usuário.. 

    * _displayDialog(context); - Constrói o PopUp que adiciona itens à Lista
    * _telaLista(); - Escreve na tela a Lista e opções para manipular a Lista  
    * _telaListaVazia(); - Tela de selação de uma pré Lista
    * _buttonEnviar(); - Constroí o botão 'ENVIAR' da _telaListaVazia();
    * _preListas(); - Processa a seleção da pré Lista

2. Item.models.dart - Partição que define o modelo de dados utilizado no aplicativo
3. item.controller.dart - Partição que controla os dados utilizados no aplicativo
4. item.repository.dart - Partição que armazena e recupera os dados no aplicativo 
5. main.dart - Ponto de partida do aplicativo 
