import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_9nov24/users/authentication/login_screen.dart';
import 'package:flutter_9nov24/users/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_conecction.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });

      if (res.statusCode == 200) {
        //conexión con el api ok
        var resBodyOfValidateEmail = jsonDecode(res.body);
        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
              msg: 'El correo ya esciste, intente con otro..');
        } else {
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveUserRecord() async {
    User userModel = User(1, nameController.text.trim(),
        emailController.text.trim(), passwordController.text.trim());

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );
      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);
        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(msg: 'Felicidades registro satisfactorio');
          setState(() {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
          });
        } else {
          Fluttertoast.showToast(msg: 'Problemas de registro ');
        }
      }
    } catch (e) {
      print("otroooo1" + e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
                  //cabecera registro
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
                                  //mane register
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) => val == ""
                                        ? "Please enter your name"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: "name..",
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
                                          // validar el email
                                          validateUserEmail();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "Register",
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

                            //opciones de ingresar al login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Ya tengo cuenta",
                                  style: TextStyle(fontSize: 14),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(LoginScreen());
                                    },
                                    child: const Text(
                                      "Login aqui.",
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
