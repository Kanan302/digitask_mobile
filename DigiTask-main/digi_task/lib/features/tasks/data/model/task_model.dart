class TaskModel {
  int? id;
  List<Group>? group;
  String? firstName;
  String? lastName;
  String? createdAt;
  String? updatedAt;
  String? taskType;
  String? description;
  String? registrationNumber;
  String? contactNumber;
  String? location;
  String? note;
  String? date;
  String? time;
  String? status;
  bool? isVoice;
  bool? isInternet;
  bool? isTv;
  int? user;

  TaskModel(
      {this.id,
      this.group,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.updatedAt,
      this.taskType,
      this.description,
      this.registrationNumber,
      this.contactNumber,
      this.location,
      this.note,
      this.date,
      this.time,
      this.status,
      this.isVoice,
      this.isInternet,
      this.isTv,
      this.user});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
    firstName = json['first_name'];
    lastName = json['last_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taskType = json['task_type'];
    description = json['description'];
    registrationNumber = json['registration_number'];
    contactNumber = json['contact_number'];
    location = json['location'];
    note = json['note'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    isVoice = json['is_voice'];
    isInternet = json['is_internet'];
    isTv = json['is_tv'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['task_type'] = taskType;
    data['description'] = description;
    data['registration_number'] = registrationNumber;
    data['contact_number'] = contactNumber;
    data['location'] = location;
    data['note'] = note;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['is_voice'] = isVoice;
    data['is_internet'] = isInternet;
    data['is_tv'] = isTv;
    data['user'] = user;
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
