import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihc_g2/validator/signup_validators.dart';
import 'package:rxdart/rxdart.dart';

enum SignUpState {IDLE, LOADING, SUCCESS, FAIL}

class SignUpBloc extends BlocBase with SignupValidators{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<SignUpState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<String> get outCpf => _cpfController.stream.transform(validateCPF);
  Stream<String> get outlastName => _lastNameController.stream.transform(validateLastName);
  Stream<String> get outName => _nameController.stream.transform(validateName);
  Stream<SignUpState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest5(
    outEmail, outPassword, outCpf, outName, outlastName, (a, b, c, d, e) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;

  void submit(){
    final email = _emailController.value;
    final password = _passwordController.value;
    final cpf = _cpfController.value;
    final name = _nameController.value;
    final lastName = _lastNameController.value;

    _stateController.add(SignUpState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).catchError((e){
      _stateController.add(SignUpState.FAIL);
    });
  }

  @override
  void dispose(){
    _emailController.close();
    _passwordController.close();
    _cpfController.close();
    _nameController.close();
    _lastNameController.close();
  }
}