import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add-item';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Lost/Found Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              _pickedImage != null
                  ? Image.file(
                      _pickedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Text('No image selected.'),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
                onPressed: _pickImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'imagePath': _pickedImage?.path ?? '',
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
