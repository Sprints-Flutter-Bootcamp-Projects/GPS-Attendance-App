import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/authentication/screens/login_screen.dart';
import 'package:gps_attendance/features/authentication/widgets/page_desc.dart';
import 'package:gps_attendance/widgets/appbar.dart';
import 'package:gps_attendance/widgets/nice_button.dart';
import 'package:gps_attendance/widgets/text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class CompleteDetailsPage extends StatefulWidget {
  const CompleteDetailsPage({super.key});

  @override
  State<CompleteDetailsPage> createState() => _CompleteDetailsPageState();
}

class _CompleteDetailsPageState extends State<CompleteDetailsPage> {


  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Register'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        PageDesc(
            title: 'Profile Details',
            description: 'Complete Profile Details'),
        SizedBox(
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/images/Avatar.png')
                          as ImageProvider,
                ),
                 Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: Icon(Icons.edit, color: AppColors.primaryColor),
                  tooltip: "Choose Profile Picture",
                  iconSize: 20,
                ),
              ),
            ),
              ],
            ),
          ),
        ),
        Text(
            "Company",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          CustomTextField(
            controller: _companyController,
            label: "Name",
            obsecureText: false,
            isPassword: false,
            validator: (value) {
              if(value !=null && value.isEmpty){
                return 'type your company';
              }
            },
          ),
          Text(
            "Department",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          CustomTextField(
            controller: _departmentController,
            label: "Research And Development",
            obsecureText: false,
            isPassword: false,
            validator: (value) {
              if(value !=null && value.isEmpty){
                return 'type your department';
              }
            },
          ),
          Text(
            "Title",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          CustomTextField(
            controller: _titleController,
            label: "Software Engineer",
            obsecureText: false,
            isPassword: false,
            validator: (value) {
              if(value !=null && value.isEmpty){
                return 'type your title';
              }
            },
          ),
          const SizedBox(height: 10),
          niceButton(title: 'Complete Details', 
          onTap: (){
            Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()),
                      );
          })
                ],
              ),
      ),
    );
  }
}
