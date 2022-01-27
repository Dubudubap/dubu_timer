class shopping {
  int price;
  String imageUrl;
  bool inStock;
  int num;

  shopping(
    this.price,
    this.imageUrl,
    this.inStock,
    this.num,
  );

  static List<shopping> samples = [
    shopping(300, 'assets/model1.png', true, 1),
    shopping(1000, 'assets/model2.png', true, 2),
    shopping(5000, "assets/model3.png", true, 3),
    shopping(50, "assets/model4.png", true, 4),
    shopping(100, "assets/model5.png", true, 5),
    shopping(400, "assets/model6.png", true, 6),
    shopping(900, "assets/model7.png", true, 7),
    shopping(10000, "assets/model8.png", true, 8),
    shopping(100, "assets/model9.png", true, 9),
    shopping(200, "assets/model10.png", true, 10),
    shopping(100, "assets/model11.png", true, 11),
    shopping(300, "assets/model12.png", true, 12),
    shopping(800, "assets/model13.png", true, 13),
    shopping(700, "assets/model14.png", true, 14),
  ];
}
