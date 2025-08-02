import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  double toDouble() {
    return double.tryParse(this) ?? 0;
  }

  DateTime? get toUtc {
    return DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.tryParse(substring(0, 2)) ?? 0,
      int.tryParse(substring(3, 5)) ?? 0,
    );
  }

  DateTime get yyyymmdd {
    DateTime originalDateTime = DateTime.parse(this);
    return DateTime(
        originalDateTime.year, originalDateTime.month, originalDateTime.day);
  }

  DateTime get yyyyMMDD {
    try {
      return DateFormat("yyyy-MM-dd").parse(this);
    } catch (ex) {
      return DateTime(DateTime.now().year);
    }
  }

  String get eeemmd {
    DateTime originalDateTime = DateTime.parse(this).toLocal();
    return DateFormat('EEE, MMM d').format(originalDateTime);
  }

  String get dDMM {
    try {
      return DateFormat.MMMd().format(DateTime.parse(this).toLocal());
    } catch (ex) {
      return DateFormat.MMMd().format(DateTime.now().toLocal());
    }
  }

  String get toTitleCaseFromSnakeCase {
    List<String> words = split('-');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return capitalizedWords.join(' ');
  }

  String get time {
    DateTime dateTime = DateTime.parse(this).toLocal();
    String formattedTime =
        DateFormat.jm().format(dateTime); // 12-hour format without seconds
    return formattedTime;
  }

  String get gmtTime {
    DateTime dateTimeGmt = DateTime.parse(this).toLocal();
    return '${DateFormat('h:mm a').format(dateTimeGmt)} GMT';
  }

  DateTime? get toDate {
    if (isEmpty) return null;
    return DateFormat('MM/dd/yyyy').parse(this).toLocal();
  }

  DateTime? get toDateyyyyMMdd {
    if (isEmpty) return null;
    return DateFormat('yyyy-MM-dd').parse(this);
  }

  String get youtubeThumbnail {
    final Uri? uri = Uri.tryParse(this);
    if (uri == null) return '';
    final String? videoId = extractVideoId(uri);
    if (videoId == null) return '';
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  String? extractVideoId(Uri uri) {
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }
    return null;
  }
}
