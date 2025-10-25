import 'package:flutter/material.dart';
import 'package:petkeeper_lite/models/users.dart';
import 'package:petkeeper_lite/provider/users_provider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  // Mapa para armazenar os dados do formulário
  final Map<String, String> _formData = {};

  // Método para carregar os dados do usuário no formulário
  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // Pegando os dados passados via rota
    final User user =
        ModalRoute.of(context)?.settings.arguments as User? ??
        User(id: '', name: '', email: '', avatarUrl: '');

    // Carregando os dados no formulário
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final formState = _form.currentState;
              if (formState != null && formState.validate()) {
                formState.save();

                Provider.of<UserProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'] ?? '',
                    name: _formData['name'] ?? '',
                    email: _formData['email'] ?? '',
                    avatarUrl: _formData['avatarUrl'] ?? '',
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome deve ter no mínimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Avatar URL'),
                onSaved: (value) => _formData['avatarUrl'] = value ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
