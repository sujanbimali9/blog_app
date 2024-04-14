import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/feature/home/presentation/home_bloc/allblog_bloc.dart';
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

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late bool showSearchBar;
  late final TextEditingController _searchController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    showSearchBar = false;
    context.read<AllBlogBloc>().add(AllBlog());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.keepScrollOffset;
    _searchController.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Blog"),
        actions: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () async {
                await context.push(Goto.addblog);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: BlocConsumer<AllBlogBloc, AllBlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Loading();
          }
          if (state is BlogDisplaySuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AllBlogBloc>().add(AllBlog());
              },
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: false,
                addAutomaticKeepAlives: true,
                physics: const ScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: state.blog.length,
                itemBuilder: (context, index) {
                  final blog = state.blog[index];
                  return BlogCard(
                    blog: blog,
                    onTap: () async {
                      await context.push('${Goto.blogView}/${blog.id}');
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
