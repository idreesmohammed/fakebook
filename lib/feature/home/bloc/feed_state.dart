import 'package:fakebook_posts/feature/home/models/user_data_model.dart';

abstract class FeedState {}

class FeedInitialState extends FeedState {}

class FeedLoadSuccessState extends FeedState {
  List<UserModel> userList;

  FeedLoadSuccessState({required this.userList});
}

class ToggleLikeButtonState extends FeedState {
  bool isLiked;
  ToggleLikeButtonState({required this.isLiked});
}

class FeedLoadfailedState extends FeedState {}

class FavLoadState extends FeedState {
  bool? fav;
  FavLoadState({this.fav});
}

class FeedToogledBackToFalseState extends FeedState {
  bool isFalse;
  FeedToogledBackToFalseState({required this.isFalse});
}
