import 'package:flutter/material.dart';
import 'package:petkeeper_lite/components/users.title.dart';
import 'package:petkeeper_lite/provider/users_provider.dart';
import 'package:petkeeper_lite/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Ação ao pressionar o botão de adicionar
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTitle(users.byIndex(i)),
      ),
    );
  }
}
