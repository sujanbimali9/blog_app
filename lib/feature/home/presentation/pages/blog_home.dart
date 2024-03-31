import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/feature/home/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/home/presentation/widget/blog_card.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    context.read<BlogBloc>().add(AllBlog());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blog"),
        actions: [
          IconButton(
              onPressed: () async {
                await context.push(Goto.addblog);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          if (state is Loading) {}
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: state.blog.length,
              itemBuilder: (context, index) {
                final blog = state.blog[index];
                return BlogCard(
                  blog: blog,
                  onTap: () {},
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
