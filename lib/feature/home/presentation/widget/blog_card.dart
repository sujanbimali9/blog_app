import 'dart:ui';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_readtime.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 2),
                    child: CachedNetworkImage(
                      imageUrl: blog.imageUrl,
                      width: constraint.maxWidth,
                      height: 210,
                      placeholder: (context, url) => Container(
                        color: const Color.fromARGB(66, 112, 112, 112),
                      ),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 210,
                      width: constraint.maxWidth,
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
                                      color:
                                          const MaterialStatePropertyAll<Color>(
                                              AppPallete.chipColor),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      label: Text(
                                        e,
                                        style: const TextStyle(
                                            color: Colors.green),
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
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(calculateReadingTime(blog.content))),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
