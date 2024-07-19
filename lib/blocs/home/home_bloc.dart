import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/data_provider/data_provider.dart';
import 'package:to_do_list/data/repository/repository.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/utils/enums.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  DataProvider dataProvider = DataProvider();
  List<Task> allTaskList = [];
  List<Task> taskList = [];
  List<Task> taskListOfWeek = [];
  Repository repository = Repository(dataProvider: DataProvider());

  HomeBloc() : super(const HomeState()) {
    on<LoadDataTask>(_fetchData);
    on<FetchDataTaskOfDayEvent>(_fetchDataOfDay);
    on<FetchDataTaskOfWeekEvent>(_fetchDataOfWeek);
    on<SearchTaskEvent>(_searchTask);
    on<CompletedTaskEvent>(_completedTask);
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<RemoveTaskEvent>(_removeTask);
  }

  void _fetchData(LoadDataTask event, Emitter<HomeState> emit) async {
    List<Task> allTasksList = await repository.getAllData();
    taskList = allTasksList;
    try {
      emit(state.copyWith(
          postStatus: PostStatus.success, message: 'success', listTodayTasks: taskList));
    }catch(error){
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    }
    // ignore: invalid_use_of_visible_for_testing_member
  }

  void _fetchDataOfDay(FetchDataTaskOfDayEvent event, Emitter<HomeState> emit) async {
    List<Task> tasksListOfDay = await repository.getDataOfDay(event);
    taskList = tasksListOfDay;
    try {
      emit(state.copyWith(
          postStatus: PostStatus.success, message: 'success', listTodayTasks: taskList));
    }catch(error){
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    }
    // ignore: invalid_use_of_visible_for_testing_member
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime, int index) {
    return dateTime.subtract(Duration(days: dateTime.weekday - index));
  }
  Future<void> getListTaskOfTheWeek(DateTime dateTime) async{
    for(int i = 1; i < 8; i++){
      String date = "${DateFormat.yMMMd().format(findFirstDateOfTheWeek(dateTime, i))}";
      print("date: " + date);
      await dataProvider.readFile().then((value) {

        taskListOfWeek.addAll(value.where((element) => element.dateCreated == date).toList());
      });
      print("task list: " + taskListOfWeek[0].title!);
    }
  }
  void _fetchDataOfWeek(FetchDataTaskOfWeekEvent event, Emitter<HomeState> emit) async {
    await getListTaskOfTheWeek(event.date);
    emit(state.copyWith(
        postStatus: PostStatus.success, message: 'success', listTodayTasks: taskListOfWeek));
    // ignore: invalid_use_of_visible_for_testing_member
  }

  Future<List<Task>> searchItem(String keySearch) async{
    final List<Task> listTask;
    try {
      var result = taskList.where((task) => task.title.toString().toLowerCase().contains(keySearch.toLowerCase())
          || task.dateCreated.toString().toLowerCase().contains(keySearch.toLowerCase())
          || task.timeCreated.toString().toLowerCase().contains(keySearch.toLowerCase()));
      listTask = result.toList();
      return listTask;
    } catch (e) {
      print("Error reading JSON file: $e");
      return [];
    }
  }
  void _searchTask(SearchTaskEvent event, Emitter<HomeState> emit) async {
    await searchItem(event.keySearch).then((value) => {
      print(event.keySearch),
      if(value.isNotEmpty){
        emit(state.copyWith(
            postStatus: PostStatus.success, message: 'success', listTodayTasks: List.from(value)))
      }else{
        emit(state.copyWith(postStatus: PostStatus.failure, message: "failure"))
    }

    });
  }


  List<Task> isAddNewTaskListHome(Task task){
    if(task.dateCreated == DateFormat.yMMMd().format(DateTime.now())){
      return List<Task>.from(state.listTodayTasks)..add(task);
    }
    return state.listTodayTasks;
  }
  void _addTask(AddTaskEvent event, Emitter<HomeState> emit) async{
    taskList = isAddNewTaskListHome(event.task);
    await repository.addTask(taskList);
    emit(state.copyWith(listTodayTasks: taskList));
  }
  void _updateTask(UpdateTaskEvent event, Emitter<HomeState> emit) async{
    taskList = taskList.map((iTask)=>iTask.id == event.task.id? event.task:iTask).toList();
    repository.updateTask(taskList);
    emit(state.copyWith(listTodayTasks: taskList));
  }

  Future<void> completedTask(Task task) async {
    for (var element in taskList) {
      if (element.id == task.id) {
        element.isCompleted = task.isCompleted;
        print("The task was completing");
        return;
      }
    }
  }
  void _completedTask(CompletedTaskEvent event, Emitter<HomeState> emit) async{
    await completedTask(event.task);
    await repository.completedTask(taskList);
    emit(state.copyWith(listTodayTasks: List.from(taskList)));

    // ignore: invalid_use_of_visible_for_testing_member
  }
  void _removeTask(RemoveTaskEvent event, Emitter<HomeState> emit) async {
    final removedTasks = List<Task>.from(state.listTodayTasks)..remove(event.task);
    await dataProvider.writeFile(removedTasks);
    emit(state.copyWith(listTodayTasks: List.from(removedTasks)));

    // ignore: invalid_use_of_visible_for_testing_member
  }
}
