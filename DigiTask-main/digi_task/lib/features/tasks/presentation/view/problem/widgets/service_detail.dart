import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';

class ServiceDetailsWidget extends StatelessWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ServiceDetailsWidget({
    Key? key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskModel? task = _findTaskById(taskId);

    if (task == null) {
      return const Center(
        child: Text('Task not found'),
      );
    }

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
                  '$serviceType anketi',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildServiceDetails(task),
        ],
      ),
    );
  }

  Widget _buildServiceDetails(TaskModel task) {
    List<Widget> widgets = [];

    // Check for Internet service
    if (task.internet != null) {
      widgets.add(_buildInternetDetails(task.internet!));
      widgets.add(const SizedBox(height: 16));
    }

    // Check for TV service
    if (task.tv != null && !widgets.contains(_buildTvDetails(task.tv!))) {
      widgets.add(_buildTvDetails(task.tv!));
      widgets.add(const SizedBox(height: 16));
    }

    // Check for Voice service
    if (task.voice != null &&
        !widgets.contains(_buildVoiceDetails(task.voice!))) {
      widgets.add(_buildVoiceDetails(task.voice!));
      widgets.add(const SizedBox(height: 16));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
  Widget _buildTvDetails(Tv tvData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', tvData.modemSN),
        _buildDetailRow('RG6 Kabel', tvData.rg6Cable),
        _buildDetailRow('F-Connector', tvData.fConnector),
        _buildDetailRow('Splitter', tvData.splitter),
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
        _buildDetailRow('Modem S/N', voiceData.modemSN),
        _buildDetailRow('Home Number', voiceData.homeNumber),
        _buildDetailRow('Password', voiceData.password),
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

  Widget _buildInternetDetails(Internet internetData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', internetData.modemSN),
        _buildDetailRow('Optik Kabel', internetData.optical_cable),
        _buildDetailRow('Fast Connector', internetData.fastconnector),
        _buildDetailRow('Signal', internetData.siqnal),
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

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
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
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TaskModel? _findTaskById(int taskId) {
    // Example logic to find a task in taskData based on taskId
    // Replace this with your actual implementation based on your data structure
    return taskData;
  }
}
