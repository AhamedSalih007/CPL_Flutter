class InfoModel {
  String title;
  String value;
  InfoModel({required this.title, required this.value});
}

List<InfoModel> infoList = [
  InfoModel(title: "Match", value: "BR vs GAW"),
  InfoModel(title: "Series", value: "CPL 2023"),
  InfoModel(title: "Date", value: "23 Fb 2023"),
  InfoModel(title: "time", value: "8:00 GMT"),
  InfoModel(title: "Toss", value: "BR won the toss and chose to bat"),
  InfoModel(
      title: "Venue", value: "Daren Sammy National Cricket Stadium, St Lucia")
];
