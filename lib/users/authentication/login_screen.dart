import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_9nov24/users/authentication/singup_screen.dart';
import 'package:flutter_9nov24/users/fragments/dashboard_of_fragments.dart';
import 'package:flutter_9nov24/users/userPreferences/userPreferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_conecction.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'user_email': emailController.text.trim(),
          'user_password': passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: 'Felicidades login satisfactorio');

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          await RememberUserPrefs.storeUserInfo(userInfo);
          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.to(DashboardOfFragments());
          });
        } else {
          Fluttertoast.showToast(
              msg:
                  'Credenciales incorrectas \n Ingrese los datos corrctos. Intente nuevamente ');
        }
      }
    } catch (errorMsg) {
      print("Error :" + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //cabecera
                  SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: Image.asset("assets/logoCCpink.png"),
                      //child: Image(image: AssetImage('assets/logoCC.png')),
                    ),
                  ),

                  //login formulario
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, -3),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            //formulario de registro
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //email login
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) => val == ""
                                        ? "Please engrese email"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email..",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                        //color: Colors.white60),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                153, 160, 2, 73)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //password
                                  Obx(
                                    () => TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == ""
                                          ? "Please engrese password"
                                          : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Obx(() => GestureDetector(
                                              onTap: () {
                                                isObsecure.value =
                                                    !isObsecure.value;
                                              },
                                              child: Icon(
                                                isObsecure.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            )),
                                        hintText: "passsword..",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  153, 160, 2, 73)),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //button
                                  Material(
                                    color: Color.fromARGB(255, 255, 0, 225),
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          loginUserNow();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //opciones de crear cuenta
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "No tienes cuenta?",
                                  style: TextStyle(fontSize: 14),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(SingupScreen());
                                    },
                                    child: const Text(
                                      "Registrate aqui.",
                                      style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 14),
                                    )),
                              ],
                            ),

                            const Text(
                              "O",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),

                            //opciones de cuenta admin
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Eres administrador",
                                  style: TextStyle(fontSize: 14),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "ingresa aqui.",
                                      style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 14),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
