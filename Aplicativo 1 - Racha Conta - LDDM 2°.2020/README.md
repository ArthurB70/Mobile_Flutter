# Racha Conta
Aplicativo para calcular a divisão de contas de restaurantes e bares.
# Vídeo demonstrativo
https://www.youtube.com/watch?v=oU7h2rif2RM
# Funcionalidade
O aplicativo recebe do usuário o valor da conta, o número de pessoas envolvidas, uma porcentagem referente à gorjeta e um valor relativo a um consumo pessoal, este último tem como entrada padrão o valor (1). Após a entrada de todos os dados, se o consumo pessoal manter o seu valor padrão (1), o aplicativo retorna o valor final da conta, o valor da gorjeta oferecida aos garçons e o valor da conta dividido igualmente a todos os participantes. Já se o consumo pessoal for > 1, o aplicativo retorna o valor final da conta, o valor da gorjeta e a divisão da conta referente aquele usuário que teve o consumo > 1.
# Procedimento dos cálculos 
  ```
  void _calculaValores(){
    setState(() {
      double valorConta = double.parse(_totalConta.text); // VALOR DA CONTA INFORMADO PELO USUÁRIO
      double valorPessoas = double.parse(_totalPessoas.text); // NUMERO DE PESSOAS ENVOLVIDAS
      double valorGorjeta = valorConta *double.parse(_totalGorjeta.text)/100; // VALOR DA GORJETA
      double finalConta = valorConta + valorGorjeta; // VALOR FINAL DA CONTA: CONTA + GORJETA
      double rachaConta = finalConta/valorPessoas;  // DIVISÃO DA CONTA PELO NUMERO DE PESSOAS ENVOLVIDAS
      double consPessoal = double.parse(_consumoPessoal.text); // PERSONALIZAÇÃO DA DIVISÃO DA CONTA TOMANDO COMO PARÂMETRO UM CONSUMO PESSOAL
      
      if(valorGorjeta <= 0){ // SE A % DA GORJETA FOR < 0 
        finalConta = double.parse(_totalConta.text); // VALOR FINAL DA CONTA = O VALOR INFORMADO PELU USUÁRIO
        valorGorjeta = 0; 
      }
      if(consPessoal > 1){ // SE O CONSUMO PESSOAL INFORMADO PELO USUÁRIO FOR > 1
        double porcentagem = consPessoal / valorPessoas; 
        rachaConta = finalConta * porcentagem;
        _infoText = ("Total da Conta: $finalConta R\$\ \nValor da Gorjeta: $valorGorjeta R\$ \nSua parte deu $rachaConta R\$\ ");
      }
      else{ // SE O CONSUMO PESSOAL FOR IGUAL A 1
        _infoText = ("Total da Conta: $finalConta R\$\ \nValor da Gorjeta: $valorGorjeta R\$ \nDeu $rachaConta R\$\ para cada bêbado!");
      }
    });
  }
  ```
