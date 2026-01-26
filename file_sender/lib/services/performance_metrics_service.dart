import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

/// Service to collect and analyze performance metrics for statistical validation
class PerformanceMetricsService {
  static final PerformanceMetricsService _instance = PerformanceMetricsService._internal();
  factory PerformanceMetricsService() => _instance;
  PerformanceMetricsService._internal();

  final Logger _logger = Logger();
  static const String _metricsKey = 'performance_metrics';
  static const String _authAttemptsKey = 'auth_attempts';
  static const String _fraudAttemptsKey = 'fraud_attempts';

  /// Record face authentication time
  Future<void> recordAuthTime(double timeInSeconds, {bool success = true}) async {
    _logger.i('🔵 recordAuthTime CALLED: time=${timeInSeconds.toStringAsFixed(3)}s, success=$success');
    try {
      _logger.d('🔵 Getting SharedPreferences instance...');
      final prefs = await SharedPreferences.getInstance();
      _logger.d('🔵 SharedPreferences instance obtained');
      
      _logger.d('🔵 Loading existing metrics...');
      final metrics = await _getMetrics(prefs);
      _logger.d('🔵 Existing metrics loaded: ${metrics.keys.length} keys');
      
      _logger.d('🔵 Initializing auth_times list...');
      metrics['auth_times'] ??= <double>[];
      _logger.d('🔵 Current auth_times count: ${metrics['auth_times']?.length ?? 0}');
      
      _logger.d('🔵 Adding new auth time: $timeInSeconds');
      metrics['auth_times']!.add(timeInSeconds);
      _logger.d('🔵 Auth time added. New count: ${metrics['auth_times']!.length}');
      
      metrics['total_auth_attempts'] = (metrics['total_auth_attempts'] ?? 0) + 1;
      if (success) {
        metrics['successful_auths'] = (metrics['successful_auths'] ?? 0) + 1;
      } else {
        metrics['failed_auths'] = (metrics['failed_auths'] ?? 0) + 1;
      }
      
      _logger.d('🔵 Metrics updated. Attempting to save...');
      _logger.d('🔵 Metrics to save: ${metrics.keys.toList()}');
      _logger.d('🔵 auth_times length: ${metrics['auth_times']?.length ?? 0}');
      
      await _saveMetrics(prefs, metrics);
      
      _logger.i('✅ Auth time recorded: ${timeInSeconds.toStringAsFixed(3)}s (success: $success)');
      _logger.i('✅ Total attempts: ${metrics['total_auth_attempts']}, Successful: ${metrics['successful_auths']}, Failed: ${metrics['failed_auths']}');
      _logger.i('✅ Total auth times stored: ${metrics['auth_times']?.length ?? 0}');
      
      // Verify it was saved
      _logger.d('🔵 Verifying save...');
      final verifyPrefs = await SharedPreferences.getInstance();
      final verifyJson = verifyPrefs.getString(_metricsKey);
      if (verifyJson != null) {
        _logger.i('✅ VERIFIED: Metrics saved successfully. JSON length: ${verifyJson.length}');
      } else {
        _logger.e('❌ VERIFICATION FAILED: Metrics not found after save!');
      }
    } catch (e, stackTrace) {
      _logger.e('❌ Error recording auth time: $e');
      _logger.e('❌ Stack trace: $stackTrace');
    }
  }

  /// Record face embedding extraction time
  Future<void> recordEmbeddingTime(double timeInSeconds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      metrics['embedding_times'] ??= <double>[];
      metrics['embedding_times']!.add(timeInSeconds);
      
      await _saveMetrics(prefs, metrics);
      _logger.d('📊 Embedding extraction time: ${timeInSeconds.toStringAsFixed(3)}s');
    } catch (e) {
      _logger.e('Error recording embedding time: $e');
    }
  }

  /// Record face verification time
  Future<void> recordVerificationTime(double timeInSeconds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      metrics['verification_times'] ??= <double>[];
      metrics['verification_times']!.add(timeInSeconds);
      
      await _saveMetrics(prefs, metrics);
      _logger.d('📊 Verification time: ${timeInSeconds.toStringAsFixed(3)}s');
    } catch (e) {
      _logger.e('Error recording verification time: $e');
    }
  }

  /// Record fraud attempt (failed verification with wrong face)
  Future<void> recordFraudAttempt({String? reason}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      metrics['fraud_attempts'] = (metrics['fraud_attempts'] ?? 0) + 1;
      metrics['fraud_attempts_list'] ??= <Map<String, dynamic>>[];
      metrics['fraud_attempts_list']!.add({
        'timestamp': DateTime.now().toIso8601String(),
        'reason': reason ?? 'Face mismatch',
      });
      
      await _saveMetrics(prefs, metrics);
      _logger.w('🚨 Fraud attempt recorded: $reason');
    } catch (e) {
      _logger.e('Error recording fraud attempt: $e');
    }
  }

  /// Record successful authentication
  Future<void> recordSuccessfulAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      metrics['successful_auths'] = (metrics['successful_auths'] ?? 0) + 1;
      metrics['total_auth_attempts'] = (metrics['total_auth_attempts'] ?? 0) + 1;
      
      await _saveMetrics(prefs, metrics);
    } catch (e) {
      _logger.e('Error recording successful auth: $e');
    }
  }

  /// Get statistical analysis of authentication times
  Future<Map<String, dynamic>> getAuthTimeStatistics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      final authTimes = (metrics['auth_times'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ?? [];
      
      if (authTimes.isEmpty) {
        return {
          'count': 0,
          'mean': 0.0,
          'median': 0.0,
          'std_dev': 0.0,
          'min': 0.0,
          'max': 0.0,
          'p95': 0.0,
          'p99': 0.0,
          'confidence_interval_95': {'lower': 0.0, 'upper': 0.0},
        };
      }
      
      return _calculateStatistics(authTimes);
    } catch (e) {
      _logger.e('Error getting auth time statistics: $e');
      return {};
    }
  }

  /// Get accuracy statistics
  Future<Map<String, dynamic>> getAccuracyStatistics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metrics = await _getMetrics(prefs);
      
      final total = metrics['total_auth_attempts'] ?? 0;
      final successful = metrics['successful_auths'] ?? 0;
      final failed = metrics['failed_auths'] ?? 0;
      final fraudAttempts = metrics['fraud_attempts'] ?? 0;
      
      if (total == 0) {
        return {
          'total_attempts': 0,
          'successful': 0,
          'failed': 0,
          'fraud_attempts': 0,
          'accuracy_rate': 0.0,
          'fraud_prevention_rate': 0.0,
          'confidence_interval_95': {'lower': 0.0, 'upper': 0.0},
        };
      }
      
      final accuracyRate = successful / total;
      final fraudPreventionRate = fraudAttempts > 0 
          ? (fraudAttempts / (fraudAttempts + successful)) 
          : 0.0;
      
      // Calculate 95% confidence interval for accuracy using Wilson score interval
      final ci = _wilsonScoreInterval(successful, total, 0.95);
      
      return {
        'total_attempts': total,
        'successful': successful,
        'failed': failed,
        'fraud_attempts': fraudAttempts,
        'accuracy_rate': accuracyRate,
        'fraud_prevention_rate': fraudPreventionRate,
        'confidence_interval_95': ci,
        'standard_error': sqrt(accuracyRate * (1 - accuracyRate) / total),
      };
    } catch (e) {
      _logger.e('Error getting accuracy statistics: $e');
      return {};
    }
  }

  /// Get all performance statistics
  Future<Map<String, dynamic>> getAllStatistics() async {
    final authTimeStats = await getAuthTimeStatistics();
    final accuracyStats = await getAccuracyStatistics();
    
    return {
      'auth_time_statistics': authTimeStats,
      'accuracy_statistics': accuracyStats,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Calculate statistical measures
  Map<String, dynamic> _calculateStatistics(List<double> values) {
    if (values.isEmpty) return {};
    
    values.sort();
    final n = values.length;
    
    // Mean
    final mean = values.reduce((a, b) => a + b) / n;
    
    // Standard deviation
    final variance = values.map((x) => pow(x - mean, 2)).reduce((a, b) => a + b) / n;
    final stdDev = sqrt(variance);
    
    // Median
    final median = n % 2 == 0
        ? (values[n ~/ 2 - 1] + values[n ~/ 2]) / 2
        : values[n ~/ 2];
    
    // Percentiles
    final p95Index = (n * 0.95).floor().clamp(0, n - 1);
    final p99Index = (n * 0.99).floor().clamp(0, n - 1);
    
    // 95% Confidence interval (t-distribution for small samples, normal for large)
    final tValue = n < 30 ? 2.045 : 1.96; // Approximate t-value for 95% CI
    final marginOfError = tValue * (stdDev / sqrt(n));
    
    return {
      'count': n,
      'mean': mean,
      'median': median,
      'std_dev': stdDev,
      'min': values.first,
      'max': values.last,
      'p95': values[p95Index],
      'p99': values[p99Index],
      'confidence_interval_95': {
        'lower': (mean - marginOfError).clamp(0.0, double.infinity),
        'upper': mean + marginOfError,
        'margin_of_error': marginOfError,
      },
    };
  }

  /// Calculate Wilson score confidence interval for proportions
  Map<String, double> _wilsonScoreInterval(int successes, int total, double confidence) {
    if (total == 0) return {'lower': 0.0, 'upper': 0.0};
    
    final z = confidence == 0.95 ? 1.96 : 1.645; // z-score for confidence level
    final p = successes / total;
    final n = total.toDouble();
    
    final denominator = 1 + (z * z) / n;
    final center = (p + (z * z) / (2 * n)) / denominator;
    final margin = (z / denominator) * sqrt((p * (1 - p) / n) + (z * z) / (4 * n * n));
    
    return {
      'lower': (center - margin).clamp(0.0, 1.0),
      'upper': (center + margin).clamp(0.0, 1.0),
      'margin_of_error': margin,
    };
  }

  /// Get metrics from storage
  Future<Map<String, dynamic>> _getMetrics(SharedPreferences prefs) async {
    final metricsJson = prefs.getString(_metricsKey);
    if (metricsJson == null) {
      _logger.d('No metrics found in SharedPreferences');
      return {};
    }
    
    try {
      final decoded = json.decode(metricsJson);
      _logger.d('📊 Loaded metrics from storage: ${decoded.keys.length} keys');
      return Map<String, dynamic>.from(decoded);
    } catch (e) {
      _logger.e('Error parsing metrics: $e');
      _logger.e('Raw JSON: $metricsJson');
      return {};
    }
  }

  /// Save metrics to storage
  Future<void> _saveMetrics(SharedPreferences prefs, Map<String, dynamic> metrics) async {
    _logger.d('🔵 _saveMetrics CALLED with ${metrics.keys.length} keys');
    try {
      _logger.d('🔵 Encoding metrics to JSON...');
      final metricsJson = json.encode(metrics);
      _logger.d('🔵 JSON encoded. Length: ${metricsJson.length} characters');
      _logger.d('🔵 JSON preview: ${metricsJson.substring(0, metricsJson.length > 200 ? 200 : metricsJson.length)}...');
      
      _logger.d('🔵 Saving to SharedPreferences with key: $_metricsKey');
      final saved = await prefs.setString(_metricsKey, metricsJson);
      _logger.i('✅ Metrics saved to SharedPreferences: $saved');
      _logger.i('✅ Saved ${metrics.keys.length} keys, ${metrics['auth_times']?.length ?? 0} auth times');
      
      if (!saved) {
        _logger.e('❌ WARNING: setString returned false! Save may have failed!');
      }
    } catch (e, stackTrace) {
      _logger.e('❌ Error saving metrics: $e');
      _logger.e('❌ Stack trace: $stackTrace');
      rethrow; // Re-throw to see the error
    }
  }

  /// Clear all metrics (for testing)
  Future<void> clearMetrics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_metricsKey);
      _logger.i('📊 All metrics cleared');
    } catch (e) {
      _logger.e('Error clearing metrics: $e');
    }
  }

  /// Export metrics as JSON (for analysis)
  Future<String> exportMetrics() async {
    final stats = await getAllStatistics();
    return json.encode(stats);
  }
}
