import 'package:broking_platform_app/screens/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Broker & Login")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, "/dashboard");
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                items: ["Broker A", "Broker B", "Broker C"]
                    .map((broker) => DropdownMenuItem(value: broker, child: Text(broker)))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(labelText: "Select Broker"),
              ),
              TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
              TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginRequested(
                            broker: "Broker A",
                            username: usernameController.text,
                            password: passwordController.text,
                          ));
                    },
                    child: Text("Login"),
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

class BrokerSelectionLoginScreen extends StatefulWidget {
  @override
  _BrokerSelectionLoginScreenState createState() =>
      _BrokerSelectionLoginScreenState();
}

class _BrokerSelectionLoginScreenState
    extends State<BrokerSelectionLoginScreen> {
  final brokers = [
    {'name': 'Broker A', 'logo': 'assets/logo_broker_a.png'},
    {'name': 'Broker B', 'logo': 'assets/logo_broker_b.png'},
    {'name': 'Broker C', 'logo': 'assets/logo_broker_c.png'},
    {'name': 'Broker D', 'logo': 'assets/logo_broker_d.png'},
  ];

  String? selectedBroker;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (selectedBroker != null &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Mock successful login action
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a broker and enter credentials.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Broker Platform'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Your Broker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: brokers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBroker = brokers[index]['name'];
                      });
                    },
                    child: Card(
                      elevation: 5,
                      color: selectedBroker == brokers[index]['name']
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: selectedBroker == brokers[index]['name']
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            brokers[index]['logo'],
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(height: 8),
                          Text(
                            brokers[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedBroker == brokers[index]['name']
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
