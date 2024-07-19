
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/model/task_model.dart';

class DataProvider {

  Future<List<Task>> readFile() async {
    final List<Task> listTask;
    try {
      // Get directory path and connect to file.
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/dataCustomer.json';
      File file = File(filePath);

      //Read data in file.
      String response = "";
      response = await file.readAsString();
      print("Read data successfully");
      final listTaskMap = await json.decode(response) as List;

      listTask =listTaskMap.map((e) => Task.fromJson(e)).toList();
      return listTask;
    } catch (e) {
      print("Error reading JSON file: $e");
      return [];
    }
  }

  List<Map<String, dynamic>> dataListToJson(List<Task> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    dataList.forEach((data) {
      jsonList.add(data.toJson());
    });
    return jsonList;
  }

  Future<void> writeFile(List<Task> listTask) async {
    try {
      // Get directory path and connect to file.
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath ='${directory.path}/dataCustomer.json';
      final file = File(filePath);

      //Convert data from json object to String.
      List<Map<String, dynamic>> jsonDataList = dataListToJson(listTask);
      final jsonData = jsonEncode(jsonDataList);
      await file.writeAsString(jsonData);
      print('Data written to file successfully');
    } catch (e) {
      print('Error writing to file: $e');
    }
  }
}
