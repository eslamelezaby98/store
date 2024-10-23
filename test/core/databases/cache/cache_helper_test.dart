import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/core/databases/cache/cache_helper.dart';
// Update this with the correct path to your CacheHelper class

void main() {
  late CacheHelper cacheHelper;

  setUp(() async {
    SharedPreferences.setMockInitialValues(
        {}); // Initialize mock with empty storage
    cacheHelper = CacheHelper();
    await cacheHelper.init();
  });

  group('CacheHelper', () {
    test('saveString() should save a string value and retrieve it', () async {
      // Act
      final success =
          await cacheHelper.saveString(key: 'test_key', value: 'test_value');
      final retrievedValue = cacheHelper.getString('test_key');

      // Assert
      expect(success, true);
      expect(retrievedValue, 'test_value');
    });

    test('saveList() should save a list of strings and retrieve it', () async {
      // Act
      final success = await cacheHelper
          .saveList(key: 'test_list_key', value: ['item1', 'item2']);
      final retrievedList = cacheHelper.getList('test_list_key');

      // Assert
      expect(success, true);
      expect(retrievedList, ['item1', 'item2']);
    });

    test('removeData() should remove data for a specific key', () async {
      // Arrange
      await cacheHelper.saveString(
          key: 'test_key_to_remove', value: 'value_to_remove');

      // Act
      final success = await cacheHelper.removeData(key: 'test_key_to_remove');
      final retrievedValue = cacheHelper.getString('test_key_to_remove');

      // Assert
      expect(success, true);
      expect(retrievedValue, null);
    });

    test('clearData() should clear all stored data', () async {
      // Arrange
      await cacheHelper.saveString(key: 'test_key_1', value: 'value_1');
      await cacheHelper.saveString(key: 'test_key_2', value: 'value_2');

      // Act
      final success = await cacheHelper.clearData();
      final value1 = cacheHelper.getString('test_key_1');
      final value2 = cacheHelper.getString('test_key_2');

      // Assert
      expect(success, true);
      expect(value1, null);
      expect(value2, null);
    });
  });
}
