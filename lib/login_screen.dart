import 'package:coop/constant.dart';
import 'package:coop/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:unicons/unicons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoginInProgress = false;
  Future<void> loginWithEmailAndPasswod(String email, password) async {
    print("\n$email\n$password\n");
    setState(() {
      isLoginInProgress = true;
    });
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        isLoginInProgress = false;
      });
      print("\n\n\After Await\n");
      // return true;
      //SAVE THE TOKEN LOCAL AND VERIFIY WHEN THE USER LAUCH THE APP
      // final token = userCredential.credential!.token;
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoginInProgress = false;
      });
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    } catch (e) {
      print('\n\n ::Catch Section\n\n');
      throw Exception(e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisbile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(
                height: 48 * 2,
              ),
              Hero(
                tag: "logo",
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: kPadding * 3.5,
              ),
              //EMAIL
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return value != null && !EmailValidator.validate(value)
                      ? "Invalid email address"
                      : null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  label: Text("Email"),
                ),
              ),
              const SizedBox(
                height: kPadding,
              ),
              // PASSWROD
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: !isPasswordVisbile,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 8) {
                    return "Password must be greater than 8 characters";
                  }
                  return null;
                }),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  label: const Text("Password"),
                  prefixIcon: Icon(Icons.key),
                  suffix: GestureDetector(
                    onTap: () => setState(() {
                      isPasswordVisbile = !isPasswordVisbile;
                    }),
                    child: isPasswordVisbile
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: kPadding * 1.5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.white,
                        content: Row(
                          children: [
                            const Icon(
                              UniconsLine.shield_exclamation,
                              color: kGray1,
                              size: 28,
                            ),
                            const SizedBox(
                              width: kPadding,
                            ),
                            Flexible(
                              child: Text(
                                "If you forget your password and want to rest it. Please contact your system adminstrator.",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: kGray1),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Forget password?",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: kPrimaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: kPadding,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState?.validate() == true) {
                    try {
                      await loginWithEmailAndPasswod(
                          emailController.text, passwordController.text);
                      if (FirebaseAuth.instance.currentUser != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: kErrorColor,
                          content: Row(
                            children: const [
                              Icon(
                                UniconsLine.exclamation_triangle,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: kPadding,
                              ),
                              Text("Incorrect email or password")
                            ],
                          )));
                    }
                  }
                },
                child: Container(
                  height: kPadding * 3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kPrimaryColor),
                  child: isLoginInProgress
                      ? const SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
