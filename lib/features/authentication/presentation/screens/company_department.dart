import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/login_screen.dart';
import 'package:gps_attendance/widgets/title_desc.dart';
import 'package:gps_attendance/features/authentication/presentation/widgets/auth_appbar.dart';
import 'package:gps_attendance/widgets/nice_button.dart';
import 'package:gps_attendance/widgets/text_form_field.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
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
      appBar: CustomAppBar(title: 'Register'),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserInfoDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Profile Completed!"),
                  backgroundColor: Colors.green),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleDesc(
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
                            icon:
                                Icon(Icons.edit, color: AppColors.primaryColor),
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return niceButton(
                    title: 'Complete Details',
                    onTap: () => _saveDetails(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
