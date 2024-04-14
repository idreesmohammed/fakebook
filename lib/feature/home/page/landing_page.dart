import 'package:fakebook_posts/feature/home/bloc/feed_bloc.dart';
import 'package:fakebook_posts/feature/home/bloc/feed_event.dart';
import 'package:fakebook_posts/feature/home/bloc/feed_state.dart';
import 'package:fakebook_posts/feature/home/page/helpers/heart_animation_widget.dart';
import 'package:fakebook_posts/feature/home/page/profile_page.dart';
import 'package:fakebook_posts/feature/home/util/landing_page_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FeedBloc feedBloc = FeedBloc();
  @override
  void initState() {
    feedBloc.add(FeedActionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<FeedBloc, FeedState>(
        bloc: feedBloc,
        builder: (context, state) {
          if (state is FeedInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FeedLoadSuccessState) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          LandingPageUtils.faceBook,
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            customIconContainer(
                                specificIcon: FontAwesomeIcons.heart),
                            const SizedBox(width: 10),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfilePage()));
                                },
                                child: Hero(
                                  tag: LandingPageUtils.heroTag,
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(LandingPageUtils
                                                .profilePicUrl))),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < state.userList.length; i++)
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              state.userList[i].profilePic)),
                                      color: Colors.blue),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  state.userList[i].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                const Icon(Icons.menu),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Image.asset(state.userList[i].imagePost),
                              Opacity(
                                opacity: state.userList[i].onDoubleTap ? 1 : 0,
                                child: HeartAnimationwidget(
                                  onEnd: () {
                                    feedBloc.add(FeedDoubleTapFalseAtEnd(
                                        isFalse: state.userList[i].onDoubleTap,
                                        data: state.userList,
                                        index: i));
                                  },
                                  time: const Duration(milliseconds: 400),
                                  isAnimation: state.userList[i].onDoubleTap,
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                ),
                              )
                            ]),
                            onDoubleTap: () {
                              feedBloc.add(FeedDoubleTapEvent(
                                  data: state.userList, index: i));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      feedBloc.add(FeedIsLikedActionEvent(
                                          index: i, data: state.userList));
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: state.userList[i].isLiked
                                          ? Colors.red
                                          : Colors.white,
                                    )),
                                const FaIcon(
                                  FontAwesomeIcons.comment,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const FaIcon(
                                  FontAwesomeIcons.shareNodes,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                const FaIcon(
                                  FontAwesomeIcons.bookmark,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 10,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(state
                                                      .userList[i].profilePic)),
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(state
                                                      .userList[1].profilePic)),
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  LandingPageUtils.likedBy,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${state.userList[i].name} ${LandingPageUtils.and}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${state.userList.length - 1} ${LandingPageUtils.others}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "${state.userList[i].name} ",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: state.userList[i].description
                                              .substring(0, 115),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      const TextSpan(
                                          text: LandingPageUtils.more,
                                          style: TextStyle(color: Colors.grey))
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(LandingPageUtils.viewAllComments,
                                    style: TextStyle(color: Colors.grey))),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(LandingPageUtils.timeAgo,
                                    style: TextStyle(color: Colors.grey))),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    )
                ],
              ),
            ));
          }
          return const Text(LandingPageUtils.somethingWentWrong);
        },
      ),
    );
  }

  Padding customIconContainer({required IconData specificIcon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FaIcon(
        specificIcon,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
