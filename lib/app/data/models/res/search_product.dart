class ProductSearch {
  bool? success;
  SearchData? data;

  ProductSearch({this.success, this.data});

  ProductSearch.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? SearchData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class SearchData {
  int? currentPage;
  List<DataProduct>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  SearchData({this.data});

  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    data = (json['data'] as List<dynamic>?)
        ?.map((v) => DataProduct.fromJson(v))
        .toList();

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    links = (json['links'] as List<dynamic>?)
        ?.map((v) => Links.fromJson(v))
        .toList();

    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((v) => v.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((v) => v.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}
class DataProduct {
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
  int? weight;
  String? status;
  bool? isFeatured;
  String? rating;
  int? totalReviews;
  int? totalSales;
  Null? tags;
  bool? hasVariants;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Category? category;
  List<Images>? images;
  List<Variants>? variants;

  DataProduct(
      {this.id,
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
        this.images,
        this.variants});

  DataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    shortDescription = json['short_description'];
    description = json['description'];
    basePrice = json['base_price'];
    comparePrice = json['compare_price'];
    costPrice = json['cost_price'];
    weight = json['weight'];
    status = json['status'];
    isFeatured = json['is_featured'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    totalSales = json['total_sales'];
    tags = json['tags'];
    hasVariants = json['has_variants'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['sku'] = this.sku;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['base_price'] = this.basePrice;
    data['compare_price'] = this.comparePrice;
    data['cost_price'] = this.costPrice;
    data['weight'] = this.weight;
    data['status'] = this.status;
    data['is_featured'] = this.isFeatured;
    data['rating'] = this.rating;
    data['total_reviews'] = this.totalReviews;
    data['total_sales'] = this.totalSales;
    data['tags'] = this.tags;
    data['has_variants'] = this.hasVariants;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? image;
  String? description;
  bool? isActive;
  int? iLft;
  int? iRgt;
  Null? parentId;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.image,
        this.description,
        this.isActive,
        this.iLft,
        this.iRgt,
        this.parentId,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    image = json['image'];
    description = json['description'];
    isActive = json['is_active'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['image'] = this.image;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['_lft'] = this.iLft;
    data['_rgt'] = this.iRgt;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  int? id;
  int? productId;
  Null? productVariantId;
  String? path;
  Null? altText;
  int? sortOrder;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;
  String? url;

  Images(
      {this.id,
        this.productId,
        this.productVariantId,
        this.path,
        this.altText,
        this.sortOrder,
        this.isPrimary,
        this.createdAt,
        this.updatedAt,
        this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productVariantId = json['product_variant_id'];
    path = json['path'];
    altText = json['alt_text'];
    sortOrder = json['sort_order'];
    isPrimary = json['is_primary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_variant_id'] = this.productVariantId;
    data['path'] = this.path;
    data['alt_text'] = this.altText;
    data['sort_order'] = this.sortOrder;
    data['is_primary'] = this.isPrimary;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}

class Variants {
  int? id;
  int? productId;
  String? sku;
  String? price;
  String? image;
  Null? comparePrice;
  List<int>? attributeValueIds;
  int? isDefault;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Variants(
      {this.id,
        this.productId,
        this.sku,
        this.price,
        this.image,
        this.comparePrice,
        this.attributeValueIds,
        this.isDefault,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    sku = json['sku'];
    price = json['price'];
    image = json['image'];
    comparePrice = json['compare_price'];
    attributeValueIds = json['attribute_value_ids'].cast<int>();
    isDefault = json['is_default'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['image'] = this.image;
    data['compare_price'] = this.comparePrice;
    data['attribute_value_ids'] = this.attributeValueIds;
    data['is_default'] = this.isDefault;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  int? page;
  bool? active;

  Links({this.url, this.label, this.page, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    page = json['page'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['page'] = this.page;
    data['active'] = this.active;
    return data;
  }
}
