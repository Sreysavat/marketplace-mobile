class VariantAttributes {
  String? color;
  String? size;

  VariantAttributes({this.color, this.size});

  VariantAttributes.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    size = json['size'];
  }
}