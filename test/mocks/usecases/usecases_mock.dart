import 'package:cpl/domain/usecases/auth/auth_usecases.dart';
import 'package:cpl/domain/usecases/storage/theme/theme_storage_usecases.dart';
import 'package:cpl/domain/usecases/user/user_usecases.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    LoginUser,
    LogoutUser,
    ReadUser,
    UpdateUser,
    ReadTheme,
    WriteTheme,
  ],
)
Future<void> main() async {}
