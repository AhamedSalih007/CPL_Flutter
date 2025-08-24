class TrackerModel {
  final String teamName;
  final int count;
  final String logoUrl;

  TrackerModel({
    required this.teamName,
    required this.count,
    required this.logoUrl,
  });

  factory TrackerModel.fromJson(Map<String, dynamic> json) {
    return TrackerModel(
      teamName: json['acf']?['teamname'] ?? '',
      count: int.tryParse(json['acf']?['count']?.toString() ?? '0') ?? 0,
      logoUrl: json['acf']?["team_logo"]?['url'] ?? '', // logo image url
    );
  }
}
