import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/component/my_button.dart';
import 'package:main_project/component/square_tile.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
     },
    );
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

   void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          backgroundColor: Colors.brown[200],
          title: Center(
              child:  Text(message)
          ),
        );
      },
    );
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.amber[100],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150,),
                    // Welcome
                    Text('Hello Again!',
                      style:
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.brown[900],
                        fontFamily: 'Pacifico',
                      ),),
                    const SizedBox(height: 20),
                    Text('Welcome Back, You\'ve been missed!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.brown[600]

                      ),),
                    const SizedBox(height: 50),
                    // Email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',


                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',


                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // sign in button
                    MyButton(
                      text: "Sign In",
                      onTap: signUserIn,
                    ),

                    const SizedBox(height: 50),
                    //or continue with google
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                                thickness: 0.5, color: Colors.grey[400]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0),
                            child: Text('Or continue with google',
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5, color: Colors.grey[400],),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    //google button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'lib/asset/Google_logo.png'),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // not a member? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member? ',
                            style: TextStyle(color: Colors.brown,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text('Register now',
                              style: TextStyle(color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),


                  ],),
              ),
            ),
          ));
    }
  }
