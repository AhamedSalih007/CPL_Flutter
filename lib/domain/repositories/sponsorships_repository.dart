import '../../data/models/result/data_state.dart';
import '../models/partners/partners.dart';
import '../models/sponsors/sponsors.dart';

abstract interface class SponsorshipRepository {
  Future<DataState<List<SponsorsData>>> sponsors();
  Future<DataState<List<PartnersData>>> partners();
}
