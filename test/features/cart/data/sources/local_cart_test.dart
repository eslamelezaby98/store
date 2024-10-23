// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'dart:convert';
// import 'package:store/core/databases/cache/cache_helper.dart';
// import 'package:store/features/cart/data/model/cart_model.dart';
// import 'package:store/features/cart/data/sources/local_cart.dart';
// import 'package:store/features/product/data/model/product_model.dart';

// import 'package:store/core/errors/expentions.dart';

// // Create a mock CacheHelper using mockito
// class MockCacheHelper extends Mock implements CacheHelper {}

// void main() {
//   late LocalCart localCart;
//   late CacheHelper mockCacheHelper;

//   setUp(() {
//     mockCacheHelper = MockCacheHelper();
//     localCart = LocalCart(cacheHelper: mockCacheHelper);
//   });

//   group('LocalCart', () {
//     final sampleProduct = ProductModel(
//       id: 1,
//       title: 'Sample Product',
//       price: 50.0,
//       description: 'Sample description',
//       category: 'electronics',
//       image: 'https://example.com/image.jpg',
//       rating: Rating(rate: 4.5, count: 100),
//     );

//     final sampleCart = CartModel(
//       id: 1,
//       product: ProductModel(
//         id: 1,
//         title: 'Sample Product',
//         price: 50.0,
//         description: 'Sample description',
//         category: 'electronics',
//         image: 'https://example.com/image.jpg',
//         rating: Rating(rate: 4.5, count: 100),
//       ),
//       count: 1,
//     );

//     final sampleCartList = [sampleCart];
//     final sampleCartJsonList =
//         sampleCartList.map((c) => json.encode(c.toMap())).toList();

//     test('cacheCart() should save cart data in CacheHelper', () async {
//       // Arrange
//       when(() => mockCacheHelper.saveList(
//               key: "cartCache", value: sampleCartJsonList))
//           .thenAnswer((_) => () =>
//               Future.value(true)); // Correct syntax for stubbing async methods

//       // Act
//       var result = await localCart.cacheCart(sampleCartList);

//       // Assert
//       expect(result, true);
//       // Verify the method was called exactly once
//       // verify(mockCacheHelper.saveList(key: "key", value: sampleCartJsonList))
//       //     .called(1);
//     });

//     // test('getCachedCart() should return cached cart data', () {
//     //   // Arrange
//     //   when(mockCacheHelper.getList(any)).thenReturn(sampleCartJsonList);

//     //   // Act
//     //   final cachedCart = localCart.getCachedCart();

//     //   // Assert
//     //   expect(cachedCart.length, 1);
//     //   expect(cachedCart[0].id, 1);
//     //   expect(cachedCart[0].product.title, 'Sample Product');
//     // });

//     // test('addToCart() should add a new product to the cached cart', () async {
//     //   // Arrange
//     //   when(mockCacheHelper.getList(any))
//     //       .thenReturn(sampleCartJsonList); // Mock the initial cart

//     //   // Act
//     //   await localCart.addToCart(sampleProduct);

//     //   // Assert
//     //   verify(mockCacheHelper.saveList(
//     //           key: anyNamed('key'), value: anyNamed('value')))
//     //       .called(1);
//     //   final updatedCart = localCart.getCachedCart();
//     //   expect(updatedCart.length, 2); // One product is added to the existing one
//     // });

//     // test('removeFromCart() should remove the product with the given ID',
//     //     () async {
//     //   // Arrange
//     //   when(mockCacheHelper.getList(any)).thenReturn(sampleCartJsonList);

//     //   // Act
//     //   await localCart.removeFromCart(1);

//     //   // Assert
//     //   verify(mockCacheHelper.saveList(
//     //           key: anyNamed('key'), value: anyNamed('value')))
//     //       .called(1);
//     //   final updatedCart = localCart.getCachedCart();
//     //   expect(updatedCart.isEmpty, true); // Product with id 1 was removed
//     // });

//     // test('cacheCart() should throw a CacheException when cartCache is null',
//     //     () {
//     //   expect(() => localCart.cacheCart(null), throwsA(isA<CacheExeption>()));
//     // });

//     // test('addToCart() should throw CacheException when there is an error',
//     //     () async {
//     //   // Arrange
//     //   when(mockCacheHelper.getList(any)).thenThrow(Exception());

//     //   // Act & Assert
//     //   expect(() => localCart.addToCart(sampleProduct),
//     //       throwsA(isA<CacheExeption>()));
//     // });

//     // test('removeFromCart() should throw CacheException when there is an error',
//     //     () async {
//     //   // Arrange
//     //   when(mockCacheHelper.getList(any)).thenThrow(Exception());

//     //   // Act & Assert
//     //   expect(() => localCart.removeFromCart(1), throwsA(isA<CacheExeption>()));
//     // });
//   });
// }
