import 'dart:ui';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  const BlogCard({super.key, required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: LayoutBuilder(builder: (context, constraint) {
            return SizedBox(
              child: Stack(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      blog.imageUrl,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        height: 250,
                        color: Colors.black12,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: blog.topic
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Chip(
                                        color: const MaterialStatePropertyAll<
                                                Color>(
                                            Color.fromARGB(255, 233, 248, 233)),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        label: Text(
                                          e,
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 36,
                                child: Text(
                                  blog.title,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color.fromARGB(255, 200, 212, 197),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
