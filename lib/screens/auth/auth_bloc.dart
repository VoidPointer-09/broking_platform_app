import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String broker;
  final String username;
  final String password;

  LoginRequested(
      {required this.broker, required this.username, required this.password});

  @override
  List<Object> get props => [broker, username, password];
}

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Dependency injection for Dio (useful for testing)
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Simulate network request delay
        await Future.delayed(Duration(seconds: 2));

        final response =
            await mockServerResponse(event.username, event.password);

        if (response['status'] == 200) {
          emit(AuthSuccess());
        } else if (response['status'] == 400) {
          emit(AuthFailure("Invalid Credentials"));
        } else {
          emit(AuthFailure("Server Error, Please try again later"));
        }
      } catch (e) {
        emit(AuthFailure(
            "An unexpected error occurred. Please try again later."));
      }
    });
  }

  // Simulating a mock server response with a delay
  Future<Map<String, dynamic>> mockServerResponse(
      String username, String password) async {
    // Simulate server delay
    await Future.delayed(Duration(seconds: 2));

    const mockUsers = [
      {'username': '8378819787', 'password': 'abcd1234'},
      {'username': '8378819788', 'password': 'xyz12345'},
    ];

    // Check for valid username and password
    final user = mockUsers.firstWhere(
      (user) => user['username'] == username && user['password'] == password,
      orElse: () => {},
    );

    // Return response mock based on whether credentials are correct
    if (user.isNotEmpty) {
      return {'status': 200}; // Successful login
    } else {
      return {'status': 400}; // Invalid credentials
    }
  }
}
