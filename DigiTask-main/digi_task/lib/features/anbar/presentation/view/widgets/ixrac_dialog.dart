import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IxracDialog extends StatefulWidget {
  final int? itemId;

  const IxracDialog({super.key, required this.itemId});

  @override
  State<IxracDialog> createState() => _IxracDialogState();
}

class _IxracDialogState extends State<IxracDialog> {
  final _formKey = GlobalKey<FormState>();
  final _dio = Dio();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  List<DropdownMenuItem<String>> _userItems = [];
  String? _selectedUser;
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _authorizedController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response =
          await _dio.get('http://135.181.42.192/accounts/userListFilter/');
      if (response.statusCode == 200) {
        List<dynamic> users = response.data;
        setState(() {
          _userItems = users.map<DropdownMenuItem<String>>((user) {
            String fullName = '${user['first_name']} ${user['last_name']}';
            return DropdownMenuItem<String>(
              value: fullName,
              child: Text(fullName),
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load user list');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final postData = {
      'item_id': widget.itemId.toString(),
      "company": _companyController.text,
      "authorized_person": _authorizedController.text,
      "number": int.tryParse(_numberController.text) ?? 0,
      "texnik_user": _selectedUser,
    };

    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        'http://135.181.42.192/services/export/',
        data: postData,
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Məlumatlar uğurla yeniləndi')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datanı ixrac etmək alınmadı')),
        );
      }
    } catch (e) {
      print('Error submitting export: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('İxrac'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'İşçi seçin',
                  border: OutlineInputBorder(),
                ),
                value: _selectedUser,
                items: _userItems,
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Şirkətin adı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _authorizedController,
                decoration: const InputDecoration(
                  labelText: 'Səlahiyyətli şəxs',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Sayı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: Colors.blue.shade900,
          ),
          child: const Text(
            'İxrac et',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _companyController.dispose();
    _authorizedController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
