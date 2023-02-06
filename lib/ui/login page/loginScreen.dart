import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orix_aqua_adim/bloc/loginscreen/login_screen_bloc.dart';
import 'package:orix_aqua_adim/network/repositary.dart';
import 'package:orix_aqua_adim/ui/dashboard/dashboard.dart';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../../commonWidget/theme_helper.dart';
import '../../commonWidget/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final toast = FToast();

  LoginScreenBloc loginBloc = LoginScreenBloc(Repository.getInstance());
  // ProfilePageScreenBloc profilePageScreenBloc = ProfilePageScreenBloc(Repositary.getInstance());
  // LoginScreenBloc loginBloc = LoginScreenBloc(Repositary.getInstance().loginPost('profile/login', {"mobile": "1234567890", "password": "1234567"}));

  String? email;
  String? password;

  bool visiblePassowrd = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121223),
      body: BlocProvider<LoginScreenBloc>(
        create: (context) => loginBloc..add(LoginScreenInitialEvent()),
        child: BlocConsumer<LoginScreenBloc, LoginScreenStates>(
          builder: (context, state) {
            if (state is LoginScreenLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else {
              return mainLoginForm();
            }
          },
          listener: (context, state) async {
            if (state is APIFailureState) {
              ThemeHelper.toastForAPIFaliure(state.exception.toString());
            } else if (state is PostLoginDataEventState) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));

              Fluttertoast.showToast(
                msg: "Success fully Logged In...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              accessToken = state.loginResponseData.accessToken;
            }
          },
        ),
      ),
    );
  }

  Widget mainLoginForm() {
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: main_Width,
              child: Image(
                image: AssetImage("assets/images/k1.png"),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Please sign in to your existing account",
                  style: TextStyle(color: Colors.white, fontSize: 17.5),
                ),
                SizedBox(
                  height: main_Height * 0.05,
                ),
                Container(
                  width: main_Height,
                  height: main_Height * 0.728,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 28, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("EMAIL"),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  initialValue: "sweta.feeltech@outlook.com",
                                  validator: (value) {
                                    RegExp regex = RegExp(
                                        "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'t be empty';
                                    } else if (!regex.hasMatch(value)) {
                                      return ("Please check your email address");
                                    }
                                    return null;
                                  },
                                  onSaved: (onSavedVal) {
                                    print(onSavedVal);
                                    email = onSavedVal;
                                  },
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    // fillColor: ,
                                    hintText: "example@gmail.com",
                                    hintStyle: TextStyle(
                                      color: Color(0xFFbdc6cf),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("PASSWORD"),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  initialValue: "Test@123",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password can\'t be empty';
                                    }
                                    return null;
                                  },
                                  obscureText: visiblePassowrd,
                                  onSaved: (onSavedVal) {
                                    password = onSavedVal;
                                  },
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    // focusedBorder: InputBorder.none,
                                    // enabledBorder: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        visiblePassowrd
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          visiblePassowrd = !visiblePassowrd;
                                        });
                                      },
                                    ),
                                    hintText: "* * * * * * *",
                                    hintStyle: TextStyle(
                                      color: Color(0xFFbdc6cf),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Remember me",
                                  style: TextStyle(color: Color(0xFFbdc6cf)),
                                ),
                                Text(
                                  "Forget Password",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 160, 227),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: main_Width * 0.895,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              loginBloc
                                  .add(PostLoginDataEvent(email!, password!));
                            }

                            // Navigator.of(context).push
                            //   (MaterialPageRoute(builder: (context)=>Dashboard()));
                          },
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: Color.fromARGB(255, 0, 160, 227),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xFF646982)),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () => {},
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 18,
                                  // color: Color(0xFFFF7622),
                                  color: Color.fromARGB(255, 0, 160, 227),
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "or",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF646982)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/1.png"),
                          Image.asset("assets/images/2.png"),
                          Image.asset("assets/images/3.png"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
