import 'package:flutter/material.dart';
import 'package:petkeeper_lite/models/users.dart';
import 'package:petkeeper_lite/provider/users_provider.dart';
import 'package:petkeeper_lite/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTitle extends StatelessWidget {
  //-- atributo da classe
  final User user;

  //-- construtor da classe
  const UserTitle(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    //-- Tratando os botoes de editar e deletar usuarios após clique --//
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.USER_FORM, arguments: user);
              },
              icon: Icon(Icons.edit, color: Colors.orange),
            ),
            IconButton(
              onPressed: () {
                // Implementar a lógica de exclusão do usuário aqui
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Usuário'),
                    content: Text(
                      'Tem certeza que deseja excluir este usuário?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // Fecha o diálogo
                        },
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).remove(user);
                          Navigator.of(ctx).pop(); // Fecha o diálogo
                        },
                        child: Text(
                          'Sim',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                );
                //Provider.of<UserProvider>(context, listen: false).remove(user);
              },
              icon: Icon(Icons.delete, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
