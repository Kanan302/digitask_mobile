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

  List<Map<String, dynamic>> _userItems = [];
  int? _selectedUserId;
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
          _userItems = users.map<Map<String, dynamic>>((user) {
            String fullName = '${user['first_name']} ${user['last_name']}';
            return {
              'id': user['id'],
              'name': fullName,
              'user_type': user['user_type'],
              'group': user['group'] != null ? user['group']['group'] : null,
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load user list');
      }
    } catch (e) {
      print('Error fetching users: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('İstifadəçi siyahısını yükləmək mümkün olmadı.')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_selectedUserId != null) {
      final isValidUser =
          _userItems.any((user) => user['id'] == _selectedUserId);
      if (!isValidUser) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xəta: Seçilmiş işçi mövcud deyil.')),
        );
        return;
      }
    }

    final postData = {
      'item_id': widget.itemId,
      "company": _companyController.text,
      "authorized_person": _authorizedController.text,
      "number": int.tryParse(_numberController.text) ?? 0,
      "texnik_user": _selectedUserId,
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
        if (response.data.toString().contains('Xətalı pk')) {
          final invalidUserId = _selectedUserId ?? 'unknown';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Xəta: Seçilmiş işçi mövcud deyil. ID: $invalidUserId',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xəta: ${response.data}')),
          );
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('Post data: $postData');
          print('Error submitting export: ${e.response?.statusCode}');
          print('Error data: ${e.response?.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xəta: ${e.response?.data}')),
          );
        } else {
          print('Error submitting export: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xəta: ${e.message}')),
          );
        }
      } else {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xəta: $e')),
        );
      }
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
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'İşçi seçin',
                  border: OutlineInputBorder(),
                ),
                value: _selectedUserId,
                items: _userItems.map<DropdownMenuItem<int>>((user) {
                  return DropdownMenuItem<int>(
                    value: user['id'],
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text('${user['name']} ')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    final selectedUser =
                        _userItems.firstWhere((user) => user['id'] == value);

                    _selectedUserId = selectedUser['id'];
                  });
                },
                validator: (value) {
                  if (value == null) {
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
