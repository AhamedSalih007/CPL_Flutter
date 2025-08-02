part of 'category_usecases.dart';

@Riverpod(keepAlive: true)
ReadCategory readCategoryUseCase(ReadCategoryUseCaseRef ref) {
  return ReadCategory(ref.watch(secureStorageManagerProvider));
}

class ReadCategory extends NoParamsUseCase<String> {
  final SecureStorageManager _secureStorageManager;
  ReadCategory(this._secureStorageManager);
  @override
  Future<String> call() async {
    final category = await _secureStorageManager.getAsync(
      key: AppConstants.category,
    );
    return category?.toString() ?? "";
  }
}
