import '../../data/models/result/data_state.dart';
import '../models/competitions/competitions.dart';

abstract interface class CompetitionRepository {
  Future<DataState<List<CompetitionData>>> competitions(
      {required String clientKey});
}
