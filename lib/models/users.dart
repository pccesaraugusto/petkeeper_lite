class User {
  //
  /* Definindo atributos da classe
   * **/
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  //
  /* Defindo o construtor da classe
   * **/
  const User({
    this.id = '',
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}
