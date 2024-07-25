import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ServiceDetailsWidget extends StatefulWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ServiceDetailsWidget({
    super.key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  });

  @override
  _ServiceDetailsWidgetState createState() => _ServiceDetailsWidgetState();
}

class _ServiceDetailsWidgetState extends State<ServiceDetailsWidget> {
  bool isEditing = false;
  late TaskModel task;

  @override
  void initState() {
    super.initState();
    task = widget.taskData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.internet != null) _buildInternetContainer(task.internet!),
        const SizedBox(height: 16),
        if (task.tv != null) _buildTvContainer(task.tv!),
        const SizedBox(height: 16),
        if (task.voice != null) _buildVoiceContainer(task.voice!),
      ],
    );
  }

  Widget _buildInternetContainer(Internet internetData) {
    return _buildContainer(
      title: 'Internet anketi',
      data: internetData,
      onSave: () => _updateTaskData('Internet', internetData),
    );
  }

  Widget _buildTvContainer(Tv tvData) {
    return _buildContainer(
      title: 'TV anketi',
      data: tvData,
      onSave: () => _updateTaskData('Tv', tvData),
    );
  }

  Widget _buildVoiceContainer(Voice voiceData) {
    return _buildContainer(
      title: 'Voice anketi',
      data: voiceData,
      onSave: () => _updateTaskData('Voice', voiceData),
    );
  }

  Widget _buildContainer({
    required String title,
    required dynamic data,
    required VoidCallback onSave,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isEditing ? Icons.save : Icons.edit_outlined,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      _saveChanges();
                    }
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetails(data),
        ],
      ),
    );
  }

  Widget _buildDetails(dynamic data) {
    if (data is Internet) {
      return _buildInternetDetails(data);
    } else if (data is Tv) {
      return _buildTvDetails(data);
    } else if (data is Voice) {
      return _buildVoiceDetails(data);
    }
    return const SizedBox.shrink();
  }

  Widget _buildInternetDetails(Internet internetData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', internetData.modemSN,
            (value) => internetData.modemSN = value),
        _buildDetailRow('Optik Kabel', internetData.optical_cable,
            (value) => internetData.optical_cable = value),
        _buildDetailRow('Fast Connector', internetData.fastconnector,
            (value) => internetData.fastconnector = value),
        _buildDetailRow('Signal', internetData.siqnal,
            (value) => internetData.siqnal = value),
        if (internetData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            internetData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildTvDetails(Tv tvData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            'Modem S/N', tvData.modemSN, (value) => tvData.modemSN = value),
        _buildDetailRow(
            'RG6 Kabel', tvData.rg6Cable, (value) => tvData.rg6Cable = value),
        _buildDetailRow('F-Connector', tvData.fConnector,
            (value) => tvData.fConnector = value),
        _buildDetailRow(
            'Splitter', tvData.splitter, (value) => tvData.splitter = value),
        if (tvData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            tvData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildVoiceDetails(Voice voiceData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', voiceData.modemSN,
            (value) => voiceData.modemSN = value),
        _buildDetailRow('Home Number', voiceData.homeNumber,
            (value) => voiceData.homeNumber = value),
        _buildDetailRow('Password', voiceData.password,
            (value) => voiceData.password = value),
        if (voiceData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            voiceData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(
      String title, String? value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              initialValue: title,
              readOnly: true,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: TextFormField(
              initialValue: value ?? '',
              readOnly: !isEditing,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateTaskData(String serviceType, dynamic data) async {
    String url;

    if (serviceType == 'Internet') {
      url = 'http://135.181.42.192/services/update_internet/${widget.taskId}/';
    } else if (serviceType == 'Tv') {
      url = 'http://135.181.42.192/services/update_tv/${widget.taskId}/';
    } else if (serviceType == 'Voice') {
      url = 'http://135.181.42.192/services/update_voice/${widget.taskId}/';
    } else {
      print('Unknown service type: $serviceType');
      return;
    }

    try {
      print('Sending data to $url');

      MultipartFile? photoFile;
      if (data.photoModem != null) {
        if (Uri.tryParse(data.photoModem!)?.hasAbsolutePath ?? false) {
          var fileInfo =
              await DefaultCacheManager().getFileFromCache(data.photoModem!);
          fileInfo ??=
              await DefaultCacheManager().downloadFile(data.photoModem!);
          photoFile = await MultipartFile.fromFile(fileInfo.file.path);
        } else {
          photoFile = await MultipartFile.fromFile(data.photoModem!);
        }
      }

      FormData formData = FormData.fromMap({
        'photo_modem': photoFile,
        'modem_SN': data.modemSN,
        if (serviceType == 'Tv') 'rg6_cable': data.rg6Cable,
        if (serviceType == 'Tv') 'f_connector': data.fConnector,
        if (serviceType == 'Tv') 'splitter': data.splitter,
        if (serviceType == 'Voice') 'home_number': data.homeNumber,
        if (serviceType == 'Voice') 'password': data.password,
        if (serviceType == 'Internet') 'optical_cable': data.optical_cable,
        if (serviceType == 'Internet') 'fastconnector': data.fastconnector,
        if (serviceType == 'Internet') 'siqnal': data.siqnal,
      });
      print('FormData: ${formData.fields}');

      Response response = await Dio().put(
        url,
        data: formData,
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$serviceType updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update $serviceType: ${response.data}')),
        );
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.response?.data}');
        if (e.response?.statusCode == 404) {
          print('Resource not found. Check taskId.');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  void _saveChanges() {
    if (widget.serviceType == 'Internet' && task.internet != null) {
      _updateTaskData('Internet', task.internet!);
    } else if (widget.serviceType == 'Tv' && task.tv != null) {
      _updateTaskData('Tv', task.tv!);
    } else if (widget.serviceType == 'Voice' && task.voice != null) {
      _updateTaskData('Voice', task.voice!);
    }
  }
}
