import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateProblem extends StatefulWidget {
  final String serviceType;
  const CreateProblem({super.key, required this.serviceType});

  @override
  State<CreateProblem> createState() => _CreateProblemState();
}

class _CreateProblemState extends State<CreateProblem> {
  XFile? imageFile;
  final TextEditingController modemSnController = TextEditingController();
  final TextEditingController rg6KabelController = TextEditingController();
  final TextEditingController fConnectorController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  Map<String, dynamic>? savedProblem;
  
  void getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile = pickedImage;
        setState(() {});
      }
    } catch (e) {
      imageFile = null;
      setState(() {});
      print(e);
    }
  }

    void saveProblem() {
    setState(() {
      savedProblem = {
        'image': imageFile,
        'modemSn': modemSnController.text,
        'rg6Kabel': rg6KabelController.text,
        'fConnector': fConnectorController.text,
        'note': noteController.text,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    widget.serviceType,
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
              imageFile == null
                  ? _buildImagePickerContainer()
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(imageFile!.path),
                            width: double.infinity,
                            height: 100.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          right: 0.0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                imageFile = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField('Modem S/N'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTextField('RG6 Kabel'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTextField('F-Connector'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildTextField('Qeyd', maxLines: 3),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveProblem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005ABF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Yadda saxla',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
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

  Widget _buildImagePickerContainer() {
    return GestureDetector(
      onTap: () => getImage(),
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
    );
  }
}
