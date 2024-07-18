import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';

class ServiceDetailsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final TaskModel? task = _findTaskById(taskId);

    if (task == null) {
      return const Center(
        child: Text('Task not found'),
      );
    }

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
              const Expanded(
                child: Text(
                  'Internet anketi',
                  style: TextStyle(
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
          _buildInternetDetails(internetData),
        ],
      ),
    );
  }

  Widget _buildTvContainer(Tv tvData) {
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
              const Expanded(
                child: Text(
                  'TV anketi',
                  style: TextStyle(
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
          _buildTvDetails(tvData),
        ],
      ),
    );
  }

  Widget _buildVoiceContainer(Voice voiceData) {
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
              const Expanded(
                child: Text(
                  'Voice anketi',
                  style: TextStyle(
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
          _buildVoiceDetails(voiceData),
        ],
      ),
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
    return taskData;
  }
}
