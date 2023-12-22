import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: dotenv.env["BASE_URL"]!,
  ),
);

final dioClientErp = Dio(
  BaseOptions(
    baseUrl: dotenv.env["ERP_URL"]!,
  ),
);
