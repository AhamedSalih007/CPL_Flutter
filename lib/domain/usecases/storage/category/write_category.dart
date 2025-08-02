part of 'category_usecases.dart';

@Riverpod(keepAlive: true)
WriteCategory writeCategoryUseCase(WriteCategoryUseCaseRef ref) {
  return WriteCategory(ref.watch(secureStorageManagerProvider));
}

class WriteCategory extends UseCase<void, String> {
  final SecureStorageManager _secureStorageManager;
  WriteCategory(this._secureStorageManager);

  @override
  Future<void> call(String categoryType) async {
    await _secureStorageManager.putAsync(
      key: AppConstants.category,
      value: categoryType,
    );
  }
}
