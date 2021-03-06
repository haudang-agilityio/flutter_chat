import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/blocs/authentication/bloc.dart';
import 'package:flutter_chat/presentation/screens/home/home.dart';
import 'package:flutter_chat/presentation/screens/login/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case AuthenticationStatus.unauthenticated:
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.unknown) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(const AuthenticationStatusCheckRequested());
              }
              return state.status == AuthenticationStatus.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
