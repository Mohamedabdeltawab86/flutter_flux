
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthBloc() : super(AuthInitial()) {

    on<LoginButtonPressed>((event, emit) async{
      emit(LoginLoading());
      try{
        final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
        if (googleSignInAccount !=null){
          final String email = googleSignInAccount.email;
          final String name = googleSignInAccount.displayName ?? ""; 
          final String photoUrl = googleSignInAccount.photoUrl ?? ""; 

          emit(LoginSuccess(email: email, name: name, photoUrl: photoUrl));
        }
        else{emit(LoginFailure(message: "Error"));}
      }
      catch(e){
        emit(LoginFailure(message: e.toString()));
      }
    
    });
  }
}
