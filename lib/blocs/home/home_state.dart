import 'package:equatable/equatable.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/utils/enums.dart';

class HomeState extends Equatable {
  final PostStatus postStatus;
  final String message;
  final List<Task> listTodayTasks;

  const HomeState(
      {this.postStatus = PostStatus.loading,
      this.listTodayTasks = const <Task>[],
      this.message = ''});

  HomeState copyWith(
      {List<Task>? listTodayTasks, PostStatus? postStatus, String? message}) {
    return HomeState(
      listTodayTasks: listTodayTasks ?? this.listTodayTasks,
      postStatus: postStatus ?? this.postStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [listTodayTasks, postStatus, message];
}

class InitialState extends HomeState {}
