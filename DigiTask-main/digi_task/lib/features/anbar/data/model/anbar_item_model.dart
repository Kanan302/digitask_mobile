class AnbarItemModel {
  Warehouse? warehouse;
  String? equipmentName;
  String? brand;
  String? model;
  String? mac;
  int? portNumber;
  String? serialNumber;
  int? number;
  String? sizeLength;
  bool? deleted;

  AnbarItemModel({
    this.warehouse,
    this.equipmentName,
    this.brand,
    this.model,
    this.mac,
    this.portNumber,
    this.serialNumber,
    this.number,
    this.sizeLength,
    this.deleted = false,
  });

  AnbarItemModel.fromJson(Map<String, dynamic> json)
      : warehouse = json['warehouse'] != null
            ? Warehouse.fromJson(json['warehouse'])
            : null,
        equipmentName = json['equipment_name'],
        brand = json['brand'],
        model = json['model'],
        mac = json['mac'],
        portNumber = json['port_number'],
        serialNumber = json['serial_number'],
        number = json['number'],
        sizeLength = json['size_length'],
        deleted = json['deleted'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (warehouse != null) {
      data['warehouse'] = warehouse!.toJson();
    }
    data['equipment_name'] = equipmentName;
    data['brand'] = brand;
    data['model'] = model;
    data['mac'] = mac;
    data['port_number'] = portNumber;
    data['serial_number'] = serialNumber;
    data['number'] = number;
    data['size_length'] = sizeLength;
    data['deleted'] = deleted;
    return data;
  }
}

class Warehouse {
  int? id;

  Warehouse({this.id});

  Warehouse.fromJson(Map<String, dynamic> json)
      : id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
