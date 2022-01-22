class shopping {
  String price;
  String imageUrl;
  bool inStock;
  int num;

  shopping(this.price, this.imageUrl, this.inStock, this.num);

  static List<shopping> samples = [
    shopping('3600', 'assets/space_model.png', true, 1),
    shopping('3600', 'assets/rocket_model.png', true, 2),
  ];
}
