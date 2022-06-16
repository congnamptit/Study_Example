library exceptions;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'exception_handler.dart';

part 'generic_exception.dart';

enum ExceptionType {
  warn, // không có chỉ định
  alert, // cảnh báo (gửi tin nhắn cho người dùng)
  forbidden, // lỗi quyền
  notFoundError, // Không thể tìm thấy
  validationError, // lỗi xác nhận
  unauthorizedError, // lỗi trái phép
  serverError, // lỗi server
  fatal, // không thể tránh được
  forcedUpdate, // bắt buộc nâng cấp phiên bản
}