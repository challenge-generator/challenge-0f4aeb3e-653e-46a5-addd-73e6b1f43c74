import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:retail_app/core/constants/app_constants.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  final List<PerformanceSample> _performanceHistory = [];
  Timer? _samplingTimer;
  bool _isMonitoring = false;

  factory PerformanceMonitor() {
    return _instance;
  }

  PerformanceMonitor._internal();

  void startMonitoring() {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _samplingTimer = Timer.periodic(
      PerformanceConstants.performanceSamplingInterval,
      (_) => _samplePerformance(),
    );
  }

  void stopMonitoring() {
    _samplingTimer?.cancel();
    _isMonitoring = false;
  }

  void _samplePerformance() {
    if (!PerformanceConstants.enablePerformanceMonitoring) return;

    final sample = PerformanceSample(
      timestamp: DateTime.now(),
      cpuUsage: _getCpuUsage(),
      memoryUsageMB: _getMemoryUsage(),
      frameBuildTime: _getFrameBuildTime(),
    );

    _performanceHistory.add(sample);

    // Mantener solo los últimos N samples
    if (_performanceHistory.length > PerformanceConstants.maxPerformanceHistorySize) {
      _performanceHistory.removeAt(0);
    }

    _checkPerformanceAlerts(sample);
  }

  double _getCpuUsage() {
    // Simulación de obtención de uso de CPU
    // En una implementación real, usaríamos dart:developer o platform channels
    return 0.1 + (0.3 * (DateTime.now().second % 10) / 10);
  }

  int _getMemoryUsage() {
    // Simulación de obtención de uso de memoria
    // En una implementación real, usaríamos dart:developer o platform channels
    return 80 + (DateTime.now().second % 50);
  }

  Duration _getFrameBuildTime() {
    // Simulación de tiempo de construcción de frame
    return Duration(milliseconds: 8 + (DateTime.now().millisecond % 20));
  }

  void _checkPerformanceAlerts(PerformanceSample sample) {
    if (sample.cpuUsage > PerformanceConstants.warningCpuUsage) {
      debugPrint('ALERTA: Alto uso de CPU - ${sample.cpuUsage}');
    }

    if (sample.memoryUsageMB > PerformanceConstants.warningMemoryUsageMB) {
      debugPrint('ALERTA: Alto uso de memoria - ${sample.memoryUsageMB}MB');
    }

    if (sample.frameBuildTime > PerformanceConstants.warningFrameBuildTime) {
      debugPrint('ALERTA: Alto tiempo de construcción de frame - ${sample.frameBuildTime.inMilliseconds}ms');
    }
  }

  List<PerformanceSample> get performanceHistory => List.unmodifiable(_performanceHistory);

  PerformanceSample? get latestSample => _performanceHistory.isNotEmpty
      ? _performanceHistory.last
      : null;

  void recordNetworkLatency(Duration latency) {
    if (latency > PerformanceConstants.maxNetworkLatency) {
      debugPrint('ALERTA: Alta latencia de red - ${latency.inMilliseconds}ms');
    }
  }

  void recordImageLoadTime(String imageUrl, Duration loadTime) {
    debugPrint('Tiempo de carga de imagen $imageUrl: ${loadTime.inMilliseconds}ms');
  }

  void recordWidgetBuildTime(String widgetName, Duration buildTime) {
    if (buildTime > PerformanceConstants.maxFrameBuildTime) {
      debugPrint('ALERTA: Alto tiempo de construcción de $widgetName - ${buildTime.inMilliseconds}ms');
    }
  }
}

class PerformanceSample {
  final DateTime timestamp;
  final double cpuUsage;
  final int memoryUsageMB;
  final Duration frameBuildTime;

  PerformanceSample({
    required this.timestamp,
    required this.cpuUsage,
    required this.memoryUsageMB,
    required this.frameBuildTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'cpuUsage': cpuUsage,
      'memoryUsageMB': memoryUsageMB,
      'frameBuildTimeMs': frameBuildTime.inMilliseconds,
    };
  }
}