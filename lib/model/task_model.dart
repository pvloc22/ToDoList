import 'package:equatable/equatable.dart';

class Task{
  int? id;
  String? title;
  String? shortDescription;
  String? dateCreated;
  String? timeCreated;
  String? longDescription;
  String? repeatTask;
  String? reminder;
  String? color;
  bool? isCompleted;

  Task(
      {this.id,
      this.title,
      this.shortDescription,
      this.dateCreated,
      this.timeCreated,
      this.longDescription,
      this.repeatTask,
      this.reminder,
      this.isCompleted,
      this.color});

  Task.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    shortDescription = json["shortDescription"];
    dateCreated = json["dateCreated"];
    timeCreated = json["timeCreated"];
    longDescription = json["longDescription"];
    repeatTask = json["repeatTask"];
    reminder = json["reminder"];
    color = json["color"];
    isCompleted = json["isCompleted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    data['dateCreated'] = dateCreated;
    data['longDescription'] = longDescription;
    data['repeatTask'] = repeatTask;
    data['timeCreated'] = timeCreated;
    data['reminder'] = reminder;
    data['color'] = color;
    data['isCompleted'] = isCompleted;

    return data;
  }
}
