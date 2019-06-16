import 'dart:async';

class SignupValidators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      }else {
        sink.addError("Insira um email válido");
      }
    }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 8){
        sink.add(password);
      }else {
        sink.addError("A senha necessita ter no mínimo 8 caracteres");
      }
    }
  );
  final validateCPF = StreamTransformer<String, String>.fromHandlers(
    handleData: (cpf, sink){
      if(cpf.length >= 14){
        sink.add(cpf);
      }else {
        sink.addError("CPF inválido");
      }
    }
  );
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){
      if(name.length >= 2){
        sink.add(name);
      }else {
        sink.addError("Nome inválido");
      }
    }
  );
  final validateLastName = StreamTransformer<String, String>.fromHandlers(
    handleData: (lastName, sink){
      if(lastName.length >= 2){
        sink.add(lastName);
      }else {
        sink.addError("Sobrenome inválido");
      }
    }
  );

}