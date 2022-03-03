import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({Key? key}) : super(key: key);

  final TextEditingController emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailControler,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    fontSize: 20
                  ),
                  hintText: "exemplo@exeplo.com",
                  border: OutlineInputBorder(),
                  prefixText: 'Prefixo: ',
                  suffixText: ' :Sufixo',
                  //errorText: "Campo Obrigatório",
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 18,
                ),
                //obscureText: true, //escrita oculta
                //obscuringCharacter: '*', //customizar o caractere oculto
              ),
              ElevatedButton(onPressed: login, child: Text("Entrar"),),
            ],
          ),
        ),
      ),
    );
  }

  void login(){
    String textEmail = emailControler.text;
    print(textEmail);
    emailControler.clear();
    emailControler.text = "Exemplo de texto mudado";
  }

  //é chamada em qualquer alteração do meu campo
  void onChanged(String text){
    print(text);
  }

  // Só e chamada quando aperto enter no teclado
  void onSubmitted(String text){
    print(text);
  }
}

