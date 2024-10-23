import 'package:flutter_test/flutter_test.dart';
import 'package:store/features/cart/data/model/cart_model.dart';
import 'package:store/features/product/data/model/product_model.dart';


void main() {
  group('CartModel', () {
    test('fromMap() should return a valid CartModel instance', () {
      final map = {
        'id': 1,
        'product': {
          'id': 1,
          'title': 'Sample Product',
          'price': 99.99,
          'description': 'A description of the sample product',
          'category': 'electronics',
          'image': 'https://example.com/image.jpg',
          'rating': {
            'rate': 4.5,
            'count': 100,
          },
        },
        'count': 2,
      };

      final cart = CartModel.fromMap(map);

      expect(cart.id, 1);
      expect(cart.product.id, 1);
      expect(cart.product.title, 'Sample Product');
      expect(cart.product.price, 99.99);
      expect(cart.product.description, 'A description of the sample product');
      expect(cart.product.category, 'electronics');
      expect(cart.product.image, 'https://example.com/image.jpg');
      expect(cart.product.rating.rate, 4.5);
      expect(cart.product.rating.count, 100);
      expect(cart.count, 2);
    });

    test('toMap() should return a valid map', () {
      final product = ProductModel(
        id: 1,
        title: 'Sample Product',
        price: 99.99,
        description: 'A description of the sample product',
        category: 'electronics',
        image: 'https://example.com/image.jpg',
        rating: Rating(rate: 4.5, count: 100),
      );

      final cart = CartModel(
        id: 1,
        product: product,
        count: 2,
      );

      final map = cart.toMap();

      expect(map['id'], 1);
      expect(map['product']['id'], 1);
      expect(map['product']['title'], 'Sample Product');
      expect(map['product']['price'], 99.99);
      expect(map['product']['description'], 'A description of the sample product');
      expect(map['product']['category'], 'electronics');
      expect(map['product']['image'], 'https://example.com/image.jpg');
      expect(map['product']['rating']['rate'], 4.5);
      expect(map['product']['rating']['count'], 100);
      expect(map['count'], 2);
    });
  });
}
