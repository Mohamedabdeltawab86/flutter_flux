import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flux/bloc/auth/bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Flux',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Authenication App"),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoginSuccess) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: Image.network(state.photoUrl).image,
                    radius: 50,
                  ),
                  Text(state.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(state.email, style: const TextStyle(fontSize: 18)),
                ],
              );
            }
            if (state is LoginFailure) {
              return Text(state.message);
            }
            return const Text("No Data yet fetched");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => BlocProvider.of<AuthBloc>(context).add(
          LoginButtonPressed(),
        ),
        label: const Text("Login with Google"),
        icon: const Icon(Icons.login),
      ),
    );
  }
}
