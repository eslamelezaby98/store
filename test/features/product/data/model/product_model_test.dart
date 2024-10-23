// Update this to point to where your ProductModel and Rating classes are located

import 'package:flutter_test/flutter_test.dart';
import 'package:store/features/product/data/model/product_model.dart';

void main() {
  group('ProductModel', () {
    test('fromJson() should return a valid ProductModel instance', () {
      final json = {
        'id': 1,
        'title': 'Sample Product',
        'price': 99.99,
        'description': 'A description of the sample product',
        'category': 'electronics',
        'image': 'https://example.com/image.jpg',
        'rating': {
          'rate': 4.5,
          'count': 100,
        }
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Sample Product');
      expect(product.price, 99.99);
      expect(product.description, 'A description of the sample product');
      expect(product.category, 'electronics');
      expect(product.image, 'https://example.com/image.jpg');
      expect(product.rating.rate, 4.5);
      expect(product.rating.count, 100);
    });

    test('toJson() should return a valid JSON map', () {
      final product = ProductModel(
        id: 1,
        title: 'Sample Product',
        price: 99.99,
        description: 'A description of the sample product',
        category: 'electronics',
        image: 'https://example.com/image.jpg',
        rating: Rating(rate: 4.5, count: 100),
      );

      final json = product.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Sample Product');
      expect(json['price'], 99.99);
      expect(json['description'], 'A description of the sample product');
      expect(json['category'], 'electronics');
      expect(json['image'], 'https://example.com/image.jpg');
      expect(json['rating']['rate'], 4.5);
      expect(json['rating']['count'], 100);
    });
  });

  group('Rating', () {
    test('fromJson() should return a valid Rating instance', () {
      final json = {
        'rate': 4.5,
        'count': 100,
      };

      final rating = Rating.fromJson(json);

      expect(rating.rate, 4.5);
      expect(rating.count, 100);
    });

    test('toJson() should return a valid JSON map', () {
      final rating = Rating(
        rate: 4.5,
        count: 100,
      );

      final json = rating.toJson();

      expect(json['rate'], 4.5);
      expect(json['count'], 100);
    });
  });
}
