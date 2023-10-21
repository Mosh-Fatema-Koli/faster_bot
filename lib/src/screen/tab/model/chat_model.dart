class ChatModel {
  late final String name;
  late final String massage;
  late final String time;
  late final String avater;

  ChatModel(
      {required this.name,
        required this.massage,
        required this.avater,
        required this.time});
}

List<ChatModel> chatdata = [
  ChatModel(
      name: "KOLi",
      massage: "Hello",
      avater: "images/IMG_2049.JPG",
      time: "22:30"),
  ChatModel(
      name: "Myna",
      massage: "Hi",
      avater: "images/IMG_2049.JPG",
      time: "22:30"),
  ChatModel(
      name: "Lima",
      massage: "Hello",
      avater: "images/IMG_2049.JPG",
      time: "22:30"),
  ChatModel(
      name: "Maliha",
      massage: "Hi",
      avater: "images/IMG_2049.JPG",
      time: "22:30"),
];