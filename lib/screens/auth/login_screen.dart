// ignore_for_file: prefer_const_constructors

import 'package:broking_platform_app/screens/auth/auth_bloc.dart';
import 'package:broking_platform_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final brokers = [
    {'name': 'Interactive Brokers', 'logo': 'assets/brokers/ib.jpeg'},
    {'name': 'Angel One', 'logo': 'assets/brokers/angel.png'},
    {'name': 'Zerodha', 'logo': 'assets/brokers/zerodha.png'},
    {'name': 'Upstox', 'logo': 'assets/brokers/upstox.jpeg'},
  ];

  int selectedBrokerIndex = 0;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/liquide.png', // Path to your app logo
              height: 30, // Set to desired height
            ),
            SizedBox(width: 10), // Spacing between the logo and the title
            Text(
              'Liquide',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, "/dashboard");
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Your Broker',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: brokers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBrokerIndex = index;
                        });
                      },
                      child: Card(
                        elevation: 0,
                        color: selectedBrokerIndex == index
                            ? AppColors.accentColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selectedBrokerIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Container(
                          width: 160,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  brokers[index]['logo'] ?? "",
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  brokers[index]['name'] ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: selectedBrokerIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginRequested(
                            broker: brokers[selectedBrokerIndex]['name'] ?? "",
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
