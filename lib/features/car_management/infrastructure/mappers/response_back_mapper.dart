import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/mappers/car_order_service_mapper.dart';

class ResponseBack<T> {
  final bool isSuccess;
  final String? message;
  final dynamic data;
  final dynamic errors;

  ResponseBack(
      {required this.isSuccess,
      required this.message,
      required this.data,
      required this.errors});
}

class ResponseBackMapper {
  static ResponseBack<T> responseBackJsonToEntity<T>(
    Map<String, dynamic> json,
    T Function(dynamic) dynamicMapper,
  ) {
    dynamic dataValue = json['data'];

    List<T>? dataList;
    dynamic nextDelivery;
    if (dataValue is List<dynamic>) {
      dataList =
          dataValue.map<T>((dataJson) => dynamicMapper(dataJson)).toList();
    } else {
      nextDelivery = {
        'orders': dataValue['ordenes']
            .map<T>((dataJson) => dynamicMapper(dataJson))
            .toList(),
        'nextDelivery': CarOrderServiceMapper.carOrderServiceToEntity(
            dataValue['proximaEntrega'])
      };
    }

    return ResponseBack<T>(
      isSuccess: json['isSuccess'],
      message: json['message'],
      errors: json['errors'] ?? '',
      data: dataList ?? nextDelivery,
    );
  }
}
