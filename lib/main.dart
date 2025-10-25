import 'package:flutter/material.dart';
import 'package:petkeeper_lite/provider/users_provider.dart';
import 'package:petkeeper_lite/routes/app_routes.dart';
import 'package:petkeeper_lite/views/user_form.dart';
import 'package:petkeeper_lite/views/users_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //iniciando a rota pela tela usuario list
        initialRoute: AppRoutes.HOME,
        routes: {
          // Definindo minhas rotas
          AppRoutes.HOME: (ctx) => UserList(),
          AppRoutes.USER_FORM: (ctx) => UserForm(),
        },
      ),
    );
  }
}
