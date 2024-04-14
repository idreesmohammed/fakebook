import 'package:fakebook_posts/feature/home/page/loader_screen.dart';
import 'package:fakebook_posts/feature/signin/util/signin_page_utils.dart';
import 'package:fakebook_posts/feature/storage_repository.dart/storage_repo.dart';
import 'package:flutter/material.dart';

class SignInLandingPage extends StatefulWidget {
  const SignInLandingPage({super.key});

  @override
  State<SignInLandingPage> createState() => _SignInLandingPageState();
}

class _SignInLandingPageState extends State<SignInLandingPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              SignInPageUtils.login,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            Text(
              SignInPageUtils.pleaseSignIn,
              style:
                  TextStyle(fontSize: 25, color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.85,
                  child: TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: SignInPageUtils.labelTextFirstName,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.85,
                  child: TextFormField(
                    controller: secondName,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: SignInPageUtils.labelLastName,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (firstName.text.isEmpty || secondName.text.isEmpty) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(SignInPageUtils.signInErrorMessage),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      StorageRepository().setLoginInfo(
                        name: "${firstName.text} ${secondName.text}",
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoaderScreen(
                              navPage: SignInPageUtils.navKeyForSignIn,
                            ),
                          ));
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.amber
                              ],
                            )),
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(SignInPageUtils.loginButton,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                            Icon(Icons.arrow_forward,
                                size: 22, color: Colors.white)
                          ],
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
