import 'package:fakebook_posts/feature/home/page/loader_screen.dart';
import 'package:fakebook_posts/feature/home/util/landing_page_utils.dart';
import 'package:fakebook_posts/feature/signin/util/signin_page_utils.dart';
import 'package:fakebook_posts/feature/storage_repository.dart/storage_repo.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: StorageRepository().getLoginInfo(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: LandingPageUtils.heroTag,
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    LandingPageUtils.profilePicUrl)),
                            shape: BoxShape.circle)),
                  ),
                  Text(
                    snapshot.hasData
                        ? snapshot.data.toString()
                        : LandingPageUtils.loading,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(LandingPageUtils.flutterDev,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400)),
                  const Text(LandingPageUtils.gdl,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w300)),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      StorageRepository().removeUser();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoaderScreen(
                                    navPage: SignInPageUtils.navKeyForSignOut,
                                  )));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LandingPageUtils.logOut,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(width: 5),
                        Icon(Icons.logout_rounded, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
