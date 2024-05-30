import 'dart:io';

import 'package:educa_app/core/common/widgets/rounded_button.dart';
import 'package:educa_app/core/common/widgets/titled_input_field.dart';
import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:educa_app/core/utils/constants.dart';
import 'package:educa_app/core/utils/core_utils.dart';
import 'package:educa_app/src/course/data/models/course_model.dart';
import 'package:educa_app/src/course/presentations/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _image;

  bool _isFile = false;

  bool _loading = false;

  Future<void> _pickImage() async {
    final image = await CoreUtils.pickImage();

    if (image == null) return;

    _isFile = true;
    _image = image;
    final imageName = image.path.split('/').last;
    _imageController.text = imageName;
  }

  void _addCourse() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();

    final course = CourseModel.empty().copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      image: _imageController.text.trim().isEmpty
          ? kDefaultAvatar
          : _isFile
              ? _image!.path
              : _imageController.text.trim(),
      createdAt: now,
      updatedAt: now,
      imageIsFile: _isFile,
    );

    context.read<CourseCubit>().addCourse(course: course);
  }

  @override
  void initState() {
    super.initState();
    _imageController.addListener(() {
      if (_isFile && _imageController.text.trim().isEmpty) {
        _image = null;
        _isFile = false;
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is AddingCourse) {
          _loading = true;
          CoreUtils.showLoadingDialog(context);
        } else if (state is CourseAdded) {
          if (_loading) {
            _loading = false;
            Navigator.pop(context);
          }

          CoreUtils.showSnackBar(context, 'Course added successfully!');
          Navigator.pop(context);
          // TODO(add-course): Send notification
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: context.mediaQuery.viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Add Course',
                  style: TextStyles.bold23,
                ),
                const SizedBox(height: 20),
                TitledInputField(
                  controller: _titleController,
                  title: 'Course Title',
                ),
                const SizedBox(height: 20),
                TitledInputField(
                  controller: _descriptionController,
                  title: 'Description',
                  required: false,
                ),
                const SizedBox(height: 20),
                TitledInputField(
                  controller: _imageController,
                  title: 'Course Image',
                  required: false,
                  hintText: 'Enter image URL or pick from gallery',
                  hintStyle: TextStyles.regular11.copyWith(
                    color: Colors.grey,
                  ),
                  suffixIcon: Material(
                    child: InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(4),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.add_photo_alternate_outlined),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        buttonColour: context.theme.colorScheme.onPrimary,
                        labelColour: context.theme.colorScheme.primary,
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: RoundedButton(
                        onPressed: _addCourse,
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
