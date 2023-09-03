import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_play/Functions/home.dart';
import 'package:form_play/Utils/request_controller.dart';
import 'package:form_play/ui/Register.dart';
import 'dart:convert' as convert;
import 'Functions/functions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var appContext;
bool isLoadingVisible = false;
bool isLoginPanelVisible = true;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool isPasswordHidden = true;
List<dynamic> dataList = [];
late Functions functions;

void main() {
  runApp(const MaterialApp(
    // theme: ThemeData(useMaterial3: true),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    appContext = context;
    functions = Functions(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/firstpagebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(

          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                child: Visibility(
                  visible: isLoginPanelVisible,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            validator: functions.validateEmail,
                            controller: emailController,
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: isPasswordHidden,
                            validator: functions.validatePassword,
                            textAlign: TextAlign.start,
                            decoration:  InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    isPasswordHidden = !isPasswordHidden;
                                    setState(() {

                                    });
                                  },
                                icon: FaIcon(isPasswordHidden == true?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,size: 18,color: Colors.black, ),
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
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
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
                            isLoadingVisible = true;
                            isLoginPanelVisible = false;
                            setState(() {

                            });
                            String email = emailController.text;
                            String password = passwordController.text;
                            if(email.isNotEmpty && password.isNotEmpty){
                              print("not empty");
                              String s = await RequestController(context).login(email,password);
                              // var jsonResponse = convert.jsonDecode(s) as Map<String, dynamic>;
                              // var something = jsonResponse['data'];
                              // dataList = (something != null ? List.from(something) : null)!;
                              print(s);

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const Home();
                                  }));
                                });
                              });




                            }




                          },
                          child: const Text("Login"),
                        ),
                      ),

                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 1, // Thickness
                                    color: Colors.grey,
                                  )),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text('or')),
                              Expanded(
                                  child: Container(
                                    height: 1, // Thickness
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
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
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const Register();
                            }));
                          },
                          child: const Text("Register"),
                        ),
                      ),
                    ],
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
              const Spacer()
            ]
            ,
          ),
        ),
      ),
    );
  }
}
