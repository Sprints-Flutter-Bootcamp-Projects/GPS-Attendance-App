import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/nice_button.dart';
import '../../../../widgets/text_form_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/page_desc.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit_profile_screen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void dispose() {
    _companyController.dispose();
    _departmentController.dispose();
    _titleController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveDetails(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(SaveUserDetailsEvent(
      company: _companyController.text,
      department: _departmentController.text,
      title: _titleController.text,
      imageUrl: _image?.path,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Edit Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              "Full Name",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            CustomTextField(
              controller: _nameController,
              label: "Name",
              obsecureText: false,
              isPassword: false,
            ),
            Text(
              "Email",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            CustomTextField(
              controller: _emailController,
              label: "Email",
              obsecureText: false,
              isPassword: false,
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
              label: "Company Name",
              obsecureText: false,
              isPassword: false,
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
              label: "Department",
              obsecureText: false,
              isPassword: false,
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
              label: "Title",
              obsecureText: false,
              isPassword: false,
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              color: Color(0xFFED3241), // Red color for border
                              width: 2.0, // Width of the border
                            ),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Cancel',
                          style: const TextStyle(
                              color: Color(0xFFED3241), fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: () async {
                        _saveDetails(context);
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Color.fromARGB(255, 26, 150, 177),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Save',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                  // niceButton(
                  //     title: 'Cancel',
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     }),
                  // niceButton(
                  //   title: 'Save',
                  //   onTap: () async {
                  //     // if (_formKey.currentState!.validate()) {
                  //       // Save details
                  //       _saveDetails(context);
                  //       await Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProfileScreen()),
                  //       );
                  //     // }
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
