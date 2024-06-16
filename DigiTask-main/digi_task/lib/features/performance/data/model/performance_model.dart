class PerformanceModel {
  int? id;
  String? userType;
  String? firstName;
  String? lastName;
  Group? group;
  TaskCount? taskCount;

  PerformanceModel({this.id, this.userType, this.firstName, this.lastName, this.group, this.taskCount});

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    taskCount = json['task_count'] != null ? TaskCount.fromJson(json['task_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (taskCount != null) {
      data['task_count'] = taskCount!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? group;
  String? region;

  Group({this.id, this.group, this.region});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group'] = group;
    data['region'] = region;
    return data;
  }
}

class TaskCount {
  int? total;
  int? connection;
  int? problem;

  TaskCount({this.total, this.connection, this.problem});

  TaskCount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    connection = json['connection'];
    problem = json['problem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['connection'] = connection;
    data['problem'] = problem;
    return data;
  }
}
