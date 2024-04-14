import 'package:fakebook_posts/feature/home/bloc/feed_event.dart';
import 'package:fakebook_posts/feature/home/bloc/feed_state.dart';
import 'package:fakebook_posts/feature/home/models/user_data_model.dart';
import 'package:fakebook_posts/feature/home/repository/network_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  bool isLiked = false;
  FeedBloc() : super(FeedInitialState()) {
    Future.delayed(const Duration(seconds: 2));
    on<FeedActionEvent>((event, emit) async {
      try {
        List<UserModel> networkRepository =
            await NetworkRepository().fetchData();

        emit(FeedLoadSuccessState(userList: networkRepository));
      } catch (e) {
        emit(FeedLoadfailedState());
      }
    });
    on<FeedIsLikedActionEvent>(
      (FeedIsLikedActionEvent event, Emitter<FeedState> emit) async {
        try {
          List<UserModel> networkRepository = await NetworkRepository()
              .getUpdatedLike(clickedIndex: event.index, dataList: event.data);

          emit(FeedLoadSuccessState(userList: networkRepository));
        } catch (e) {
          throw Exception(e);
        }
      },
    );
    on<FeedDoubleTapEvent>(
      (event, emit) async {
        List<UserModel> networkRepository =
            await NetworkRepository().getDoubleTapLike(
          index: event.index,
          dataList: event.data,
        );
        emit(FeedLoadSuccessState(userList: networkRepository));
      },
    );
    on<FeedDoubleTapFalseAtEnd>(
      (event, emit) async {
        List<UserModel> networkRepository = await NetworkRepository()
            .getDoubleTapLikeBackToFalse(
                index: event.index,
                list: event.data,
                isTriggeredToFalse: event.isFalse);
        emit(FeedLoadSuccessState(userList: networkRepository));
      },
    );
  }
}
