import 'package:cpl/domain/repositories/auth_repository.dart';
import 'package:cpl/domain/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    AuthRepository,
    UserRepository,
  ],
)
Future<void> main() async {}
