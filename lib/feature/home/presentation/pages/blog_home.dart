import 'package:blog_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).go('');
                context.go(Goto.addblog);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
    );
  }
}
