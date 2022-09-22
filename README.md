# Real Auth

Real auth provides a simple API to authenticate users in real-world conditions.

### AuthRepository class

#### Usage

```
import 'package:realauth/auth.dart';

var auth = AuthRepository();

await auth.login("foo@bar.com", "123456");
```

#### Methods

```
login(String email, String password) → Future<User>
Logins a user in.

createUser(User user) → Future<User>
Creates a user.

userExists(String email) → Future<bool>
Returns a boolean indicating if the user exists.
```