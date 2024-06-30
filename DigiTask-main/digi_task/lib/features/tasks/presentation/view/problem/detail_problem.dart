import 'package:flutter/material.dart';

class CreateProblem extends StatelessWidget {
  final String serviceType;
  const CreateProblem({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem anketi'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Servis məlumatları',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    serviceType,
                    style: const TextStyle(
                      color: Color(0xFF005ABF),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Modemin arxa fotosu',
                style: TextStyle(fontSize: 16.0, color: Color(0xFF909094)),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  // Add your file upload functionality here
                  // Example: launch file picker or camera
                },
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Yükləmək üçün klikləyin',
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '(Maksimum fayl ölçüsü: 25 MB)',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Icon(Icons.upload_file_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              _buildTextField('Modem S/N'),
              _buildTextField('RG6 Kabel'),
              _buildTextField('F-Connector'),
              _buildTextField('Splitter'),
              _buildTextField('Qeyd', maxLines: 3),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Yadda saxla'),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, color: Color(0xFF909094)),
        ),
        const SizedBox(height: 8.0),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(174, 247, 245, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
