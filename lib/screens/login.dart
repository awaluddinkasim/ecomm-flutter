import 'package:ecomm/nav.dart';
import 'package:ecomm/providers/auth.dart';
import 'package:ecomm/providers/cart.dart';
import 'package:ecomm/providers/settings.dart';
import 'package:ecomm/screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final String logo = 'assets/bag_1.svg';

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, _) {
      if (auth.token != null) {
        Future.delayed(Duration.zero, () {
          Provider.of<CartState>(context, listen: false).countCart("${auth.token}");
          Provider.of<Settings>(context, listen: false).getSettings(auth.token);

          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Navigations()),
          );
        });
      }
      return Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: SvgPicture.asset(
                          logo,
                        ),
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: auth.passwordVisible ? false : true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              auth.togglePassword();
                            },
                            icon: Icon(auth.passwordVisible ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill),
                          ),
                        ),
                      ),
                      if (auth.err != null)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            "${auth.err}",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!auth.loading) {
                        auth.login(creds: {
                          "email": email.text,
                          "password": password.text,
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 50,
                      ),
                      child: (auth.loading)
                          ? const SizedBox(
                              height: 20,
                              child: LoadingIndicator(
                                indicatorType: Indicator.circleStrokeSpin,
                                pathBackgroundColor: Colors.white,
                              ),
                            )
                          : const Text("Login"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Belum punya akun?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
