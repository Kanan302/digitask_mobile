import 'package:digi_task/features/performance/data/model/performance_model.dart';

import '../../../../data/services/jwt/dio_configuration.dart';

abstract class IPerformanceNetworkService {
  Future<List<PerformanceModel>?> getPerformance();
}

class PerformanceNetworkService implements IPerformanceNetworkService {
  @override
  Future<List<PerformanceModel>?> getPerformance() async {
    final response = await baseDio.get('services/performance/');
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      final performanceList = response.data;
      if (performanceList is List) {
        return performanceList.map((e) => PerformanceModel.fromJson(e)).toList();
      }
    }
    return null;
  }
}
