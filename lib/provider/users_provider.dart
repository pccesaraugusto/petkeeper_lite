import 'package:petkeeper_lite/data/dummy_users.dart';
import 'package:petkeeper_lite/models/users.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class UserProvider with ChangeNotifier {
  //-- lista dos usuários cadastrados no arquivo constante para ser usado inicialmente no projeto --//
  final Map<String, User> _items = {...DUMMY_USERS};

  //-- buscando a lista de usuários da lista acima pela provider --//
  List<User> get all {
    return [..._items.values];
  }

  //-- contando a quantidade de usuarios da lista constantes --//
  int get count {
    return _items.length;
  }

  //-- clonando a lista para usar na classe users_list.dart --//
  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user.id != '' &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      //-- criar o id de forma randomica --//
      final id = Random().nextDouble().toString();

      //-- incluir novo usuário --//
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }

    notifyListeners();
  }

  //-- criando a rotina de excluir usuario --//
  void remove(User user) {
    if (user.id != '') {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
