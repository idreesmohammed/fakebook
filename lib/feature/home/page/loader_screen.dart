import 'package:fakebook_posts/feature/home/page/landing_page.dart';
import 'package:fakebook_posts/feature/signin/page/signin_landing_page.dart';
import 'package:fakebook_posts/feature/signin/util/signin_page_utils.dart';
import 'package:flutter/material.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key, required this.navPage});
  final String navPage;
  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  void initState() {
    navigate(context);

    super.initState();
  }

  navigate(context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (widget.navPage == SignInPageUtils.navKeyForSignIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LandingPage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInLandingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }
}
