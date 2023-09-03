import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_play/Utils/request_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Functions/functions.dart';

late Functions functions;
var isRegisterPanelVisible = true;
var isLoadingVisible = false;
var isPassHidden = true;
var isConfPassHidden = true;
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();
TextEditingController emailEdtController = TextEditingController();

String? validateConfirmPassword(String? value) {
  String pass = passwordController.text;
  if(value!.isEmpty){
    return null;
  }else if(value.length <5){
    return "Password must be at least 6 characters";
  }else if(pass.isEmpty){
    return null;
  }else if(pass != value){
    return "Password did not match";
  }
  return null;
}

class Register extends StatefulWidget {
  const Register({super.key});


  @override
  State<Register> createState() => _MyAppState();
}

class _MyAppState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    functions = Functions(context);

    return Scaffold(
      body: Container(
        height: functions.getHeight(),
        width: functions.getWidth(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/firstpagebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
              child: Visibility(
                visible: isRegisterPanelVisible,
                child: SizedBox(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: emailEdtController,
                      validator: functions.validateEmail,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
              child: Visibility(
                visible: isRegisterPanelVisible,
                child: SizedBox(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: functions.validatePassword,
                      obscureText: isPassHidden,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPassHidden = !isPassHidden;
                            setState(() {

                            });
                          },
                            icon: FaIcon(isPassHidden == true?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,size: 18,color: Colors.black, ),
                        ),

                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          labelText: 'Password',
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.grey)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
              child: Visibility(
                visible: isRegisterPanelVisible,
                child: SizedBox(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: validateConfirmPassword,
                      controller: confirmpasswordController,
                      obscureText: isConfPassHidden,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      decoration:  InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              isConfPassHidden = !isConfPassHidden;
                              setState(() {

                              });
                            },
                            icon: FaIcon(isConfPassHidden == true?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,size: 18,color: Colors.black, ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          labelText: 'Confirm Password',
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.grey)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
              child: Visibility(
                visible: isRegisterPanelVisible,
                child: SizedBox(
                  height: 40.0,
                  child: MaterialButton(
                    color: Colors.blue,
                    disabledColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            10.0), // Change your border radius here
                      ),
                    ),
                    onPressed: () async {
                      isRegisterPanelVisible = false;
                      isLoadingVisible = true;
                      setState(() {

                      });

                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return const Register();
                      // }));
                      String email = emailEdtController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmpasswordController.text;
                      if(email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty){
                        if(functions.validateEmail(email) == null && functions.validatePassword(password) == null && validateConfirmPassword(confirmPassword) == null ){
                          RequestController req = RequestController(context);
                          String registerResponse = await req.register(email, password);
                          print(registerResponse);

                          isRegisterPanelVisible = true;
                          isLoadingVisible = false;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          });
                        }
                      }



                    },
                    child: const Text("Register"),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoadingVisible,
              child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                  size: 50, color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}