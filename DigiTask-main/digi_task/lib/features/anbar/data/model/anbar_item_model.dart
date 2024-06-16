class AnbarItemModel {
  int? id;
  Warehouse? warehouse;
  String? equipmentName;
  String? brand;
  String? model;
  String? serialNumber;
  int? number;
  String? sizeLength;
  bool? deleted;

  AnbarItemModel(
      {this.id,
      this.warehouse,
      this.equipmentName,
      this.brand,
      this.model,
      this.serialNumber,
      this.number,
      this.sizeLength,
      this.deleted});

  AnbarItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouse = json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null;
    equipmentName = json['equipment_name'];
    brand = json['brand'];
    model = json['model'];
    serialNumber = json['serial_number'];
    number = json['number'];
    sizeLength = json['size_length'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (warehouse != null) {
      data['warehouse'] = warehouse!.toJson();
    }
    data['equipment_name'] = equipmentName;
    data['brand'] = brand;
    data['model'] = model;
    data['serial_number'] = serialNumber;
    data['number'] = number;
    data['size_length'] = sizeLength;
    data['deleted'] = deleted;
    return data;
  }
}

class Warehouse {
  int? id;
  String? name;
  String? region;

  Warehouse({this.id, this.name, this.region});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['region'] = region;
    return data;
  }
}
