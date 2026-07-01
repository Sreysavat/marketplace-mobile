import 'package:marketplace_app/app/data/models/res/product.model.dart';
import 'package:marketplace_app/app/data/models/res/search_product.dart'
    hide Category, Images, Variants, Attributes;

class ProductMapper {
  const ProductMapper._();

  static Data fromSearch(DataProduct p) {
    return Data(
      id: p.id,
      storeId: p.storeId,
      categoryId: p.categoryId,
      name: p.name,
      slug: p.slug,
      sku: p.sku,
      shortDescription: p.shortDescription,
      description: p.description,
      basePrice: p.basePrice,
      comparePrice: p.comparePrice,
      costPrice: p.costPrice,
      status: p.status,
      isFeatured: p.isFeatured,
      rating: p.rating,
      totalReviews: p.totalReviews,
      totalSales: p.totalSales,
      tags: p.tags,
      hasVariants: p.hasVariants,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      deletedAt: p.deletedAt,

      category: p.category == null
          ? null
          : Category(
        id: p.category!.id,
        name: p.category!.name,
      ),

      images: (p.images ?? [])
          .map(
            (e) => Images(
          id: e.id,
          productId: p.id,
          path: e.path,
          url: e.url,
        ),
      )
          .toList(),

      variants: (p.variants ?? [])
          .map(
            (v) => Variants(
          id: v.id,
          productId: p.id,
          sku: v.sku,
          price: v.price,
          image: v.image,

          // Search API doesn't have these
          isDefault: false,
          isActive: true,
          attributeValueIds: [],
          attributes: [],
        ),
      )
          .toList(),
    );
  }
}