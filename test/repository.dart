import 'package:realauth/auth.dart';
import 'package:test/test.dart';

void main() {
  group("AuthRepository", () {
    group("login", () {
      test("successful login", () async {
        var repo = AuthRepository(chaos: TestChaos());

        var user = await repo.login("test@caminoconnections.com", "123456");

        expect(
          user,
          User(
            email: "test@caminoconnections.com",
            password: "123456",
            name: "Test User",
          ),
        );
      });

      test("failed login (wrong password)", () async {
        var repo = AuthRepository(chaos: TestChaos());

        expect(
            () async => await repo.login("test@caminoconnections.com", "WRONG"),
            throwsA(isA<AuthException>()));
      });

      test("failed login (wrong email)", () async {
        var repo = AuthRepository(chaos: TestChaos());

        expect(() async => await repo.login("WRONG", "123456"),
            throwsA(isA<AuthException>()));
      });
    });

    group("userExists", () {
      test("does exist", () async {
        var repo = AuthRepository(chaos: TestChaos());

        var exists = await repo.userExists("test@caminoconnections.com");

        expect(exists, isTrue);
      });

      test("does not exist", () async {
        var repo = AuthRepository(chaos: TestChaos());

        var exists =
            await repo.userExists("doesnotexist@caminoconnections.com");

        expect(exists, isFalse);
      });
    });

    group("createUser", () {
      test("create user", () async {
        var repo = AuthRepository(chaos: TestChaos());

        var user = User(
          name: "Foo",
          email: "user-${DateTime.now().microsecond}@test.com",
          password: "123",
        );

        var created = await repo.createUser(user);
        expect(created, user);

        // should not throw
        await repo.login(user.email, user.password);
      });

      test("create user who already exists", () async {
        var repo = AuthRepository(chaos: TestChaos());

        var user = User(
          name: "Foo",
          email: "test@caminoconnections.com",
          password: "123",
        );

        expect(() async => await repo.createUser(user),
            throwsA(isA<UserAlreadyExistsException>()));
      });
    });
  });
}
