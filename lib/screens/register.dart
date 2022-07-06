import 'package:dio/dio.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool passwordVisible = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void register() async {
      Map formData = {
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "phone": phone.text,
      };

      setState(() {
        isLoading = true;
      });

      try {
        await dio().post('register', data: formData);

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } on DioError catch (e) {
        if (e.response!.statusCode == 401 || e.response!.statusCode == 500) {
          print(e);
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left_rounded,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                      child: Icon(
                        CupertinoIcons.person_add_solid,
                        size: 80,
                        color: Colors.black45,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Form wajib diisi";
                        }
                        return null;
                      },
                      controller: name,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        prefixIcon: Icon(Icons.badge),
                        labelText: "Nama Lengkap",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Form wajib diisi";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Form wajib diisi";
                        }
                        return null;
                      },
                      controller: password,
                      obscureText: passwordVisible ? false : true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Form wajib diisi";
                        }
                        return null;
                      },
                      controller: phone,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        prefix: Text("+62"),
                        prefixIcon: Icon(Icons.phone_android),
                        labelText: "No. HP",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!isLoading) {
                          if (formKey.currentState!.validate()) {
                            register();
                          }
                        }
                      },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                child: LoadingIndicator(
                                  indicatorType: Indicator.circleStrokeSpin,
                                  pathBackgroundColor: Colors.white,
                                ),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                              child: Text("Daftar"),
                            ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
