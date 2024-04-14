import 'package:fakebook_posts/feature/home/bloc/feed_bloc.dart';
import 'package:fakebook_posts/feature/home/models/user_data_model.dart';
import 'package:fakebook_posts/feature/home/util/landing_page_utils.dart';

class NetworkRepository {
  FeedBloc feedBloc = FeedBloc();
  Future<List<UserModel>> fetchData() async {
    final result =
        LandingPageUtils.dataList.map((e) => UserModel.fromJson(e)).toList();
    return result;
  }

  Future<List<UserModel>> getUpdatedLike(
      {required int clickedIndex, required List<UserModel> dataList}) async {
    for (int i = 0; i < dataList.length; i++) {
      if (clickedIndex == i) {
        dataList[i].isLiked = !dataList[i].isLiked;
      }
    }
    return dataList;
  }

  Future<List<UserModel>> getDoubleTapLike(
      {required int index, required List<UserModel> dataList}) async {
    for (int i = 0; i < dataList.length; i++) {
      if (index == i) {
        dataList[i].isLiked = true;
        dataList[i].onDoubleTap = true;
      }
    }
    return dataList;
  }

  Future<List<UserModel>> getDoubleTapLikeBackToFalse(
      {required int index,
      required List<UserModel> list,
      required bool isTriggeredToFalse}) async {
    for (int i = 0; i < list.length; i++) {
      if (index == i) {
        list[i].onDoubleTap = false;
      }
    }
    return list;
  }
}
