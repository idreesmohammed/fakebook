import 'package:fakebook_posts/feature/home/models/user_data_model.dart';

abstract class FeedEvent {}

class FeedActionEvent extends FeedEvent {}

class FeedIsLikedActionEvent extends FeedEvent {
  int index;
  List<UserModel> data;

  FeedIsLikedActionEvent({required this.index, required this.data});
}

class FeedDoubleTapEvent extends FeedEvent {
  int index;
  List<UserModel> data;

  FeedDoubleTapEvent({required this.index, required this.data});
}

class FeedDoubleTapFalseAtEnd extends FeedActionEvent {
  int index;
  List<UserModel> data;
  bool isFalse;
  FeedDoubleTapFalseAtEnd(
      {required this.isFalse, required this.data, required this.index});
}
