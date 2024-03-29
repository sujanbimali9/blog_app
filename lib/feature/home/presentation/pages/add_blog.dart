import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pickimage.dart';
import 'package:blog_app/feature/home/data/filter.dart';
import 'package:blog_app/feature/home/presentation/widget/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  List<String> selectedFilter = [];
  File? file;

  @override
  void initState() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        file = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: file == null
                    ? DottedBorder(
                        radius: const Radius.circular(20),
                        borderType: BorderType.RRect,
                        dashPattern: const [20, 5],
                        stackFit: StackFit.passthrough,
                        color: AppPallete.borderColor,
                        child: const SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open_outlined,
                                size: 50,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text('Select your image')
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 300,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.file(file!, fit: BoxFit.cover),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: chipFilter.length,
                  itemBuilder: (context, index) {
                    final filter = chipFilter[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            if (selectedFilter.contains(filter)) {
                              selectedFilter.remove(filter);
                            } else {
                              selectedFilter.add(filter);
                            }
                            setState(() {});
                          },
                          child: Chip(
                            color: selectedFilter.contains(filter)
                                ? const MaterialStatePropertyAll<Color>(
                                    AppPallete.gradient1)
                                : null,
                            side:
                                const BorderSide(color: AppPallete.borderColor),
                            label: Text(
                              filter,
                              style: TextStyle(
                                color: selectedFilter.contains(filter)
                                    ? AppPallete.borderColor
                                    : null,
                              ),
                            ),
                          )),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              BlogEditor(
                hint: 'Blog Title',
                controller: titleController,
                type: BlogEditorType.title,
              ),
              const SizedBox(
                height: 20,
              ),
              BlogEditor(
                hint: 'Blog Content',
                controller: contentController,
                type: BlogEditorType.content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
