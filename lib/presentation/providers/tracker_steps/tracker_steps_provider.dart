import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../domain/models/tracker_steps/tracker_steps.dart';

final trackerProvider = FutureProvider<List<TrackerModel>>((ref) async {
  final dio = Dio();
  final response = await dio.get(
    "https://wp.cplt20.com/wp-json/wp/v2/tracker?acf_format=standard",
  );

  if (response.statusCode == 200) {
    final List data = response.data;

    // Convert
    final trackers = data.map((e) => TrackerModel.fromJson(e)).toList();

    // Sort highest → lowest by count
    trackers.sort((a, b) => b.count.compareTo(a.count));

    return trackers;
  } else {
    throw Exception("Failed to fetch tracker data");
  }
});
