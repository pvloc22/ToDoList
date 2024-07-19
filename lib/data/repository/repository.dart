import 'package:to_do_list/data/data_provider/data_provider.dart';
import 'package:to_do_list/index.dart';

class Repository{
  final DataProvider dataProvider;
  Repository({required this.dataProvider});

  /**
  * To read file and filter data
   *
  **/
  Future<List<Task>> getAllData() async {
    final List<Task> dataSet = await dataProvider.readFile();
    // Sort data
    dataSet.sort((a, b) {
      int dateComparison = a.dateCreated.toString().compareTo(b.dateCreated.toString());
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return a.timeCreated.toString().compareTo(b.timeCreated.toString());
      }
    });
    return dataSet;
  }

  Future<List<Task>> getDataOfDay(FetchDataTaskOfDayEvent event) async {
    final List<Task> dataSet = await dataProvider.readFile();
    // Sort data
    dataSet.sort((a, b) {
      int dateComparison = a.dateCreated.toString().compareTo(b.dateCreated.toString());
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return a.timeCreated.toString().compareTo(b.timeCreated.toString());
      }
    });
    List<Task> todayTasks = dataSet.where((element) => element.dateCreated == event.date).toList();
    return todayTasks;
  }

  /**
   * Write data to file
   *
   */
  Future<void> completedTask(List<Task> taskList) async {
    //To write data to file
    dataProvider.writeFile(taskList);
  }
  Future<void> addTask(List<Task> tasks) async {
    //To write data to file
    await dataProvider.writeFile(tasks);
  }
  Future<void> updateTask(List<Task> updatedTasks) async {
    //To write data to file
    await dataProvider.writeFile(updatedTasks);
    print('To update the successful task.');
  }
  Future<void> removeTask(List<Task> taskList) async {
    //To write data to file
    await dataProvider.writeFile(taskList);
  }
}