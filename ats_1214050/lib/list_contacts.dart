import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';

class MyListContacts extends StatefulWidget {
  const MyListContacts({super.key});

  @override
  State<MyListContacts> createState() => _MyListContactsState();
}

class _MyListContactsState extends State<MyListContacts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;

  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  String? _dataFile;
  File? _pickedImage;

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  void _addData() {
    final data = {
      'name': _controllerNama.text,
      'phoneNumber': _controllerPhoneNumber.text,
      'date': _controllerDate.text,
      'color': _currentColor,
      'image': _pickedImage
    };

    setState(() {
      if (editedData != null) {
        // Jika editedData ada, maka kita sedang dalam mode edit
        // Sehingga kita perlu memperbarui data yang sedang diedit
        editedData!['name'] = data['name'];
        editedData!['phoneNumber'] = data['phoneNumber'];
        editedData!['date'] = data['date'];
        editedData!['color'] = data['color'];
        editedData!['image'] = data['image'];
        // Kosongkan kembali editedData setelah proses edit selesai
        editedData = null;
      } else {
        // Jika editedData kosong, maka kita sedang dalam mode insert
        _myDataList.add(data);
      }

      _controllerNama.clear();
      _controllerPhoneNumber.clear();
      _controllerDate.clear();
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerPhoneNumber.text = data['phoneNumber'];
      _controllerNama.text = data['name'];
      _controllerDate.text = data['date'];
      _currentColor = data['color'] as Color;

      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama harus diisi oleh user';
    }
    // Split the name into words
    List<String> words = value.split(' ');
    // Check if there are at least two words
    if (words.length < 2) {
      return 'Nama harus terdiri dari minimal 2 kata';
    }
    // Check if each word starts with a capital letter
    for (String word in words) {
      if (word.isEmpty || !isCapitalized(word)) {
        return 'Setiap kata harus dimulai dengan huruf kapital';
      }
    }
    // Check if the name contains only letters and spaces
    if (!isAlphabeticWithSpaces(value)) {
      return 'Nama tidak boleh mengandung angka atau karakter khusus';
    }
    return null;
  }

  // Helper function to check if a string is capitalized
  bool isCapitalized(String word) {
    return word[0] == word[0].toUpperCase();
  }

  // Helper function to check if a string contains only letters and spaces
  bool isAlphabeticWithSpaces(String value) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon harus diisi oleh user';
    }
    // Check if the phone number contains only digits
    if (!isNumeric(value)) {
      return 'Nomor telepon harus terdiri dari angka saja';
    }
    // Check if the length of the phone number is between 8 and 13 digits
    if (value.length < 8 || value.length > 13) {
      return 'No Hp minimal 8 digit dan maksimal 13 digit';
    }
    // Check if the phone number starts with the digit 0
    if (value[0] != '0') {
      return 'Nomor telepon harus dimulai dengan angka 0';
    }
    return null;
  }

  // Helper function to check if a string contains only numeric characters
  bool isNumeric(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal harus diisi oleh user';
    }
    return null;
  }

  Widget buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          final selectDate = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(1990),
            lastDate: DateTime(currentDate.year + 5),
          );
          if (selectDate != null) {
            final formattedDate =
                DateTime(selectDate.year, selectDate.month, selectDate.day);
            setState(() {
              _controllerDate.text =
                  DateFormat('dd-MM-yyyy').format(formattedDate);
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
              controller: _controllerDate,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.date_range),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              validator: _validateDate),
        ),
      ),
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color'),
          const SizedBox(height: 10.0),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _currentColor, // Optional: You can add a border
              borderRadius: BorderRadius.circular(10.0), // Set the BorderRadius
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_currentColor),
              ),
              child: const Text('ColorPicker'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertDialog(
                            title: const Text('Pick a color!'),
                            content: ColorPicker(
                              pickerColor: _currentColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _currentColor = color;
                                });
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  return Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick File',
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10.0),
        Center(
          child: ElevatedButton(
            child: const Text('Pick File'),
            onPressed: () {
              _pickFile();
            },
          ),
        ),
        if (_dataFile != null) Text('File Name: $_dataFile'),
      ],
    );
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    final file = result.files.single;

    setState(() {
      _dataFile = file.name;
      _pickedImage =
          File(file.path!); // Perbarui _dataFile dengan nama file yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerPhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Write your phone number here...',
                      labelText: 'Your Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: _validatePhoneNumber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerNama,
                    decoration: const InputDecoration(
                      hintText: 'Write your name here...',
                      labelText: 'Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: _validateName,
                  ),
                ),
                buildDatePicker(context),
                buildColorPicker(context),
                buildFilePicker(context),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: Text(editedData != null ? "Update" : "Submit"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addData();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill the form correctly'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'List Contacts',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _myDataList.length,
                  itemBuilder: (context, index) {
                    final data = _myDataList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              data['name'].isNotEmpty ? data['name'][0] : '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'] ?? ''),
                                Text(data['phoneNumber'] ?? ''),
                                Text(data['date'] ?? ''),
                                // Text(data['color'].red ?? ''),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: data[
                                        'color'], // Optional: You can add a border
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Set the BorderRadius
                                  ),
                                ),
                                if (data['image'] != null)
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        // image: FileImage(data['image'] as File),
                                        image: FileImage(data['image'] as File),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _editData(data);
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _deleteData(data);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
