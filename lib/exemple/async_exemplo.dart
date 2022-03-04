import 'dart:io';

void main() async {
  print("Início");
  bool suc = await auxiliar();
  print("Fim $suc");
}

Future<bool> auxiliar() async {
  String usuario = await reqUsuario();
  print("Encontrou $usuario");
  try {
    bool sucesso = await autenticar(usuario);
    return sucesso;
  } catch (e){
    return false;
  }
}

Future<String> reqUsuario() async{
  await Future.delayed(Duration(seconds: 2));
  String nome = "Daniel";
  print("Usuário $nome encontrado");
  return nome;
}

Future<bool> autenticar(String usuario) async{
  await Future.delayed(Duration(seconds: 3));
  if(usuario == "Daniel") return true;
  throw UsuarioInvalido();
}

class UsuarioInvalido implements Exception{}