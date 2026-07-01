class CartList {
  String? message;
  List<Items>? items;
  int? subtotal;
  int? totalItems;

  CartList({this.message, this.items, this.subtotal, this.totalItems});

  CartList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = this.subtotal;
    data['total_items'] = this.totalItems;
    return data;
  }
}

class Items {
  int? id;
  int? productId;
  int? productVariantId;
  String? productName;
  String? variantName;
  int? quantity;
  String? unitPrice;
  int? subtotal;
  String? image;

  Items(
      {this.id,
        this.productId,
        this.productVariantId,
        this.productName,
        this.variantName,
        this.quantity,
        this.unitPrice,
        this.subtotal,
        this.image});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productVariantId = json['product_variant_id'];
    productName = json['product_name'];
    variantName = json['variant_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    subtotal = json['subtotal'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_variant_id'] = this.productVariantId;
    data['product_name'] = this.productName;
    data['variant_name'] = this.variantName;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['subtotal'] = this.subtotal;
    data['image'] = this.image;
    return data;
  }
}
