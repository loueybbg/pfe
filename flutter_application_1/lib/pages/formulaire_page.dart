import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../utils/constants/sizes.dart';
import '../utils/constants/text_string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  labelText: TTexts.titre,
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(width: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  labelText: TTexts.description,
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  labelText: TTexts.categorie,
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  labelText: TTexts.gps,
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const AddReclamation());
                  },
                  child: const Text(TTexts.submit),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: const Text(TTexts.image2),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              _selectedImage != null
                  ? Image.file(_selectedImage!)
                  : const Text("please select an image")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}
