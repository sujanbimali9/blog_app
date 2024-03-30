import 'dart:ui';

import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  const BlogCard({super.key, required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 0,
        child: GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: LayoutBuilder(builder: (context, constraint) {
              return Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Image.network(
                      blog.imageUrl,
                      filterQuality: FilterQuality.high,
                      alignment: const FractionalOffset(1, 1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: blog.topics
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Chip(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      label: Text(e),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
