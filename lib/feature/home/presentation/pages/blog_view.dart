import 'package:blog_app/core/utils/calculate_readtime.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/presentation/blog_bloc/blog_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key, required this.id});

  final String id;
  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    final state = context.read<BlogBloc>().state;
    if (state is BlogInitial ||
        (state is GetBlogSuccess && state.blog.id != widget.id)) {
      context.read<BlogBloc>().add(GetBlogs(id: widget.id));
    }
    super.initState();
  }

  void _showDialog(Blog blog) {
    showDialog(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => context.pop(),
        child: Hero(
          tag: blog.userId,
          child: EasyImageView(
              maxScale: 1.5,
              doubleTapZoomable: true,
              imageProvider: CachedNetworkImageProvider(
                blog.imageUrl,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          if (state is GetBlogSuccess) {
            final blog = state.blog;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'By ${blog.userName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${formatDatedMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            _showDialog(blog);
                          },
                          child: Hero(
                            tag: blog.userId,
                            child: CachedNetworkImage(
                              imageUrl: blog.imageUrl,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      blog.content,
                      style: const TextStyle(
                          height: 1.5,
                          color: Color.fromARGB(255, 195, 193, 193)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
