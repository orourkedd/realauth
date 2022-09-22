import 'dart:math';

import 'exceptions.dart';
import 'user.dart';

class AuthRepository {
  late final Chaos chaos;

  AuthRepository({Chaos? chaos}) {
    this.chaos = chaos ?? RealChaos();
  }

  final Map<String, User> _db = {
    "test@caminoconnections.com": User(
      email: "test@caminoconnections.com",
      name: "Test User",
      password: "123456",
    ),
  };

  Future<User> login(String email, String password) async {
    await chaos.deploy();

    var user = _db[email];

    if (user == null) {
      throw AuthException("user does not exist");
    }

    if (password != user.password) {
      throw AuthException("invalid password");
    }

    return _db[email]!;
  }

  Future<User> createUser(User user) async {
    await chaos.deploy();

    if (await userExists(user.email)) {
      throw UserAlreadyExistsException();
    }

    _db[user.email] = user;

    return user;
  }

  Future<bool> userExists(String email) async {
    await chaos.deploy();
    return _db.containsKey(email);
  }
}

abstract class Chaos {
  Future deploy();
}

class RealChaos implements Chaos {
  final rng = Random();

  deploy() async {
    // simulate variable latency
    await Future.delayed(Duration(milliseconds: rng.nextInt(500)));

    // simulate errors 20% of the time
    if (rng.nextInt(100) > 80) {
      throw Exception("oye! sucedió algo inesperado 😏");
    }
  }
}

class TestChaos implements Chaos {
  deploy() async {
    // noop
  }
}
