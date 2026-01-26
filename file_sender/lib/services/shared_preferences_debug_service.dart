import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

/// Debug service to inspect and manage SharedPreferences data
class SharedPreferencesDebugService {
  static final Logger _logger = Logger();

  /// Get all stored preferences
  static Future<Map<String, dynamic>> getAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, dynamic> allData = {};

      // Get all keys
      final keys = prefs.getKeys();
      _logger.i('Found ${keys.length} keys in SharedPreferences');

      // Retrieve each key's value
      for (String key in keys) {
        final dynamicValue = prefs.get(key);
        allData[key] = dynamicValue;
        _logger.d('$key: $dynamicValue (${dynamicValue.runtimeType})');
      }

      return allData;
    } catch (e) {
      _logger.e('Error reading SharedPreferences: $e');
      return {};
    }
  }

  /// Get user registration data if available
  static Future<Map<String, dynamic>?> getUserRegistrationData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final regNo = prefs.getString('userRegNo');

      if (regNo == null) {
        _logger.i('No user registration data found');
        return null;
      }

      final userData = {
        'registrationNumber': regNo,
        'name': prefs.getString('userName'),
        'deviceId': prefs.getString('deviceId') ?? prefs.getString('macAddress'),
        'hasEmbedding': prefs.getStringList('faceEmbedding') != null,
        'embeddingLength': prefs.getStringList('faceEmbedding')?.length ?? 0,
      };

      _logger.i('User registration data: $userData');
      return userData;
    } catch (e) {
      _logger.e('Error reading user registration data: $e');
      return null;
    }
  }

  /// Get face embedding statistics
  static Future<Map<String, dynamic>?> getEmbeddingStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final embeddingList = prefs.getStringList('faceEmbedding');

      if (embeddingList == null || embeddingList.isEmpty) {
        _logger.i('No face embedding stored');
        return null;
      }

      final embedding = embeddingList.map((e) => double.parse(e)).toList();
      
      // Calculate statistics
      double sum = 0;
      double sumSquares = 0;
      double minVal = double.infinity;
      double maxVal = double.negativeInfinity;

      for (double val in embedding) {
        sum += val;
        sumSquares += val * val;
        if (val < minVal) minVal = val;
        if (val > maxVal) maxVal = val;
      }

      final mean = sum / embedding.length;
      final variance = (sumSquares / embedding.length) - (mean * mean);
      final stdDev = variance > 0 ? sqrt(variance) : 0;

      final stats = {
        'embeddingSize': embedding.length,
        'mean': mean,
        'stdDev': stdDev,
        'min': minVal,
        'max': maxVal,
        'firstFiveValues': embedding.take(5).toList(),
      };

      _logger.i('Embedding stats: $stats');
      return stats;
    } catch (e) {
      _logger.e('Error calculating embedding stats: $e');
      return null;
    }
  }

  /// Clear all preferences (for testing/debugging)
  static Future<bool> clearAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _logger.i('All SharedPreferences cleared');
      return true;
    } catch (e) {
      _logger.e('Error clearing SharedPreferences: $e');
      return false;
    }
  }

  /// Clear specific preference
  static Future<bool> clearPreference(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      _logger.i('Preference cleared: $key');
      return true;
    } catch (e) {
      _logger.e('Error clearing preference $key: $e');
      return false;
    }
  }

  /// Print formatted debug info
  static Future<void> printDebugInfo() async {
    try {
      _logger.i('========== SharedPreferences Debug Info ==========');
      
      final userData = await getUserRegistrationData();
      if (userData != null) {
        _logger.i('User Data: $userData');
      } else {
        _logger.i('No user data found');
      }

      final embeddingStats = await getEmbeddingStats();
      if (embeddingStats != null) {
        _logger.i('Embedding Stats: $embeddingStats');
      } else {
        _logger.i('No embedding data found');
      }

      final allData = await getAllPreferences();
      _logger.i('All Keys (${allData.length}): ${allData.keys.toList()}');
      _logger.i('================================================');
    } catch (e) {
      _logger.e('Error printing debug info: $e');
    }
  }
}
