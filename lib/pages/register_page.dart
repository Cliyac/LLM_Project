// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:main_project/component/my_button.dart';
// import 'package:main_project/component/square_tile.dart';
//
// class RegisterPage extends StatefulWidget {
//   final void Function()? onTap;
//   const RegisterPage({super.key,required this.onTap});
//
//
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   void signUserUp() async {
//     showDialog(context: context, builder: (context){
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     },
//     );
//     //try sign up
//     try {
//       //check if password is confirmed
//       if(passwordController.text==confirmPasswordController.text) {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//
//         );
//       }else{
//         //show error message ,passwords dont match
//         showErrorMessage("Passwords don't match!");
//       }
//       //pop the loading circle
//       Navigator.pop(context);
//     } on FirebaseAuthException catch(e) {
//       Navigator.pop(context);
//       //show error message
//       showErrorMessage(e.code);
//     }
//   }
//
//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return  AlertDialog(
//           backgroundColor: Colors.amber,
//           title: Center(
//               child:  Text(message)
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.amber[100],
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 150,),
//                   // Welcome
//                   Text('Hello Again!',
//                     style:
//                     TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 40,
//                       color: Colors.brown[900],
//                       fontFamily: 'Pacifico',
//                     ),),
//                   const SizedBox(height: 20),
//                   Text('Lets\'s create an account for you!',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.brown[600]
//
//                     ),),
//                   const SizedBox(height: 50),
//                   // Email textfield
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: TextField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Email',
//
//
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // password textfield
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: TextField(
//                           controller: passwordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Password',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   //confirm password
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: TextField(
//                           controller: confirmPasswordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Confirm Password',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 25),
//                   // login in button
//                   MyButton(
//                     text: "Sign Up",
//                     onTap: signUserUp,
//                   ),
//
//                   const SizedBox(height: 50),
//                   //or continue with google
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Divider(
//                               thickness: 0.5, color: Colors.grey[400]
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 25.0),
//                           child: Text('Or continue with google',
//                             style: TextStyle(color: Colors.brown),
//                           ),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             thickness: 0.5, color: Colors.grey[400],),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   //google button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SquareTile(imagePath: 'lib/asset/Google_logo.png'),
//                     ],
//                   ),
//                   const SizedBox(height: 50),
//                   // not a member? register now
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Already have an acoount?',
//                           style: TextStyle(color: Colors.brown,
//                               fontWeight: FontWeight.bold)),
//                       GestureDetector(
//                         onTap: widget.onTap,
//                         child: Text('Login now',
//                             style: TextStyle(color: Colors.black87,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//
//
//                 ],),
//             ),
//           ),
//         ));
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/component/my_button.dart';
import 'package:main_project/component/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isPasswordValid = false;
  bool _showPasswordRequirements = false;
  String _passwordError = '';

  bool _validatePassword(String password) {
    if (password.length < 8) {
      _passwordError = 'Password must be at least 8 characters long';
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _passwordError = 'Password must contain at least one uppercase letter';
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      _passwordError = 'Password must contain at least one lowercase letter';
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      _passwordError = 'Password must contain at least one number';
      return false;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _passwordError = 'Password must contain at least one special character';
      return false;
    }
    _passwordError = '';
    return true;
  }

  void signUserUp() async {
    if (!_isPasswordValid) {
      showErrorMessage("Please enter a valid password");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.amber,
          title: Center(
              child: Text(message)
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
                const SizedBox(height: 50),
                // Welcome
                Text(
                  'Hello Again!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.brown[900],
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown[600]
                  ),
                ),
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Password textfield
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
                        onChanged: (value) {
                          setState(() {
                            _isPasswordValid = _validatePassword(value);
                            _showPasswordRequirements = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              setState(() {
                                _showPasswordRequirements = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_showPasswordRequirements) ...[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRequirement('At least 8 characters', passwordController.text.length >= 8),
                        _buildRequirement('At least one uppercase letter', passwordController.text.contains(RegExp(r'[A-Z]'))),
                        _buildRequirement('At least one lowercase letter', passwordController.text.contains(RegExp(r'[a-z]'))),
                        _buildRequirement('At least one number', passwordController.text.contains(RegExp(r'[0-9]'))),
                        _buildRequirement('At least one special character', passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                // Confirm password
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
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Sign up button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50),
                // Or continue with google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Or continue with google',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Google button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'lib/asset/Google_logo.png'),
                  ],
                ),
                const SizedBox(height: 50),
                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Login now',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            color: isMet ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}