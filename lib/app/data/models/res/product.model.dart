class Product {
  bool? success;
  List<Data> data;

  Product({
    this.success,
    this.data = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      success: json['success'],
      data: (json['data'] as List? ?? [])
          .map((v) => Data.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class Data {
  int? id;
  int? storeId;
  int? categoryId;
  String? name;
  String? slug;
  String? sku;
  String? shortDescription;
  String? description;
  String? basePrice;
  String? comparePrice;
  String? costPrice;
  String? weight;
  String? status;
  bool? isFeatured;
  String? rating;
  int? totalReviews;
  int? totalSales;
  String? tags;
  bool? hasVariants;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Category? category;

  final List<Images> images;
  final List<Variants> variants;

  Data({
    this.id,
    this.storeId,
    this.categoryId,
    this.name,
    this.slug,
    this.sku,
    this.shortDescription,
    this.description,
    this.basePrice,
    this.comparePrice,
    this.costPrice,
    this.weight,
    this.status,
    this.isFeatured,
    this.rating,
    this.totalReviews,
    this.totalSales,
    this.tags,
    this.hasVariants,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
    this.images = const [],
    this.variants = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      storeId: json['store_id'],
      categoryId: json['category_id'],
      name: json['name'],
      slug: json['slug'],
      sku: json['sku'],
      shortDescription: json['short_description'],
      description: json['description'],
      basePrice: json['base_price']?.toString(),
      comparePrice: json['compare_price']?.toString(),
      costPrice: json['cost_price']?.toString(),
      weight: json['weight']?.toString(),
      status: json['status'],
      isFeatured: json['is_featured'],
      rating: json['rating']?.toString(),
      totalReviews: json['total_reviews'],
      totalSales: json['total_sales'],
      tags: json['tags']?.toString(),
      hasVariants: json['has_variants'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],

      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,

      images: (json['images'] as List? ?? [])
          .map((v) => Images.fromJson(v))
          .toList(),

      variants: (json['variants'] as List? ?? [])
          .map((v) => Variants.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'store_id': storeId,
    'category_id': categoryId,
    'name': name,
    'slug': slug,
    'sku': sku,
    'short_description': shortDescription,
    'description': description,
    'base_price': basePrice,
    'compare_price': comparePrice,
    'cost_price': costPrice,
    'weight': weight,
    'status': status,
    'is_featured': isFeatured,
    'rating': rating,
    'total_reviews': totalReviews,
    'total_sales': totalSales,
    'tags': tags,
    'has_variants': hasVariants,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'category': category?.toJson(),
    'images': images.map((e) => e.toJson()).toList(),
    'variants': variants.map((e) => e.toJson()).toList(),
  };
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Images {
  int? id;
  int? productId;
  String? path;
  String? url;

  Images({this.id, this.productId, this.path, this.url});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      productId: json['product_id'],
      path: json['path'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'path': path,
    'url': url,
  };
}

class Variants {
  int? id;
  int? productId;
  String? sku;
  String? price;
  String? image;

  bool isDefault;
  bool isActive;

  final List<int> attributeValueIds;
  final List<Attributes> attributes;

  Variants({
    this.id,
    this.productId,
    this.sku,
    this.price,
    this.image,
    this.isDefault = false,
    this.isActive = false,
    this.attributeValueIds = const [],
    this.attributes = const [],
  });

  factory Variants.fromJson(Map<String, dynamic> json) {
    return Variants(
      id: json['id'],
      productId: json['product_id'],
      sku: json['sku'],
      price: json['price']?.toString(),
      image: json['image'],

      isDefault: json['is_default'] == 1 || json['is_default'] == true,
      isActive: json['is_active'] == 1 || json['is_active'] == true,

      attributeValueIds: (json['attribute_value_ids'] as List? ?? [])
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .where((e) => e != 0)
          .toList(),

      // 🔥 FIX: NEVER NULL AGAIN
      attributes: (json['attributes'] as List? ?? [])
          .map((v) => Attributes.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'sku': sku,
    'price': price,
    'image': image,
    'is_default': isDefault,
    'is_active': isActive,
    'attribute_value_ids': attributeValueIds,
    'attributes': attributes.map((e) => e.toJson()).toList(),
  };
}

class Attributes {
  int? attributeId;
  String? attributeName;
  int? valueId;
  String? value;

  Attributes({
    this.attributeId,
    this.attributeName,
    this.valueId,
    this.value,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      attributeId: json['attribute_id'],
      attributeName: json['attribute_name'],
      valueId: json['value_id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'attribute_id': attributeId,
    'attribute_name': attributeName,
    'value_id': valueId,
    'value': value,
  };
}