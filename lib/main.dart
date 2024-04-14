import 'package:fakebook_posts/feature/home/bloc/feed_bloc.dart';
import 'package:fakebook_posts/feature/home/page/landing_page.dart';
import 'package:fakebook_posts/feature/signin/page/signin_landing_page.dart';
import 'package:fakebook_posts/feature/storage_repository.dart/storage_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const FakeBook());
}

class FakeBook extends StatefulWidget {
  const FakeBook({super.key});

  @override
  State<FakeBook> createState() => _FakeBookState();
}

class _FakeBookState extends State<FakeBook> {
  @override
  void initState() {
    StorageRepository().getLoginInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => FeedBloc(),
        child: FutureBuilder(
          future: StorageRepository().getLoginInfo(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? const LandingPage()
                : const SignInLandingPage();
          },
        ),
      ),
    );
  }
}
