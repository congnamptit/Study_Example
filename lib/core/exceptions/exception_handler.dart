part of exceptions;

// Đưa ra phán quyết (xử lý gỡ lỗi)

const isRelease = bool.fromEnvironment('dart.vm.product');

final exceptionHandlerProvider = Provider(
  (ref) => const ExceptionHandler(),
);

class ExceptionHandler {
  const ExceptionHandler();

  /// Common exception handling
  void handler(dynamic e) async {
    // GenericException
    if (e is GenericException) {
      switch (e.code) {
        case ExceptionType.alert:
          await alertHandler(e.message);
          break;

        case ExceptionType.unauthorizedError:
          _unauthorizedErrorHandler();
          break;

        case ExceptionType.forbidden:
          _forbiddenHandler();
          break;

        case ExceptionType.fatal:
          _fatalHandler();
          break;

        case ExceptionType.notFoundError:
          _notFoundErrorHandler();
          break;

        case ExceptionType.validationError:
          _validationErrorHandler(e.message);
          break;

        case ExceptionType.serverError:
          _serverErrorHandler();
          break;

        case ExceptionType.forcedUpdate:
          forcedUpdateHandler();
          break;

        case ExceptionType.warn:
          assert(throw Exception(e.toString()));
          break;

        default:
      }
    } else {
      /// Bạn cần giải quyết một vấn đề
      /// đang gặp vấn đề với Kho lưu trữ hoặc Ứng dụng
      assert(throw Exception('Please fix: ${e.toString()}'));
    }
    debugPrint(e.toString());
  }

  /// Exception alert
  /// Hiển thị dialog cảnh báo
  ///
  Future<void> alertHandler(
    String message, {
    String title = 'Error',
  }) async {
    /// TODO: showErrorMessageDialog
  }

  ///
  /// Exception (authentication error)
  /// chuyển đến trang đăng nhập
  ///
  void _unauthorizedErrorHandler() {
    /// TODO: deleteSecurityToken
  }

  ///
  /// Permission error (Lỗi quyền)
  /// Transition to the `403` page
  ///
  void _forbiddenHandler() {
    if (isRelease) {
      /// TODO: deleteSecurityToken
      /// router.replaceAll([const ForbiddenRoute()])
    } else {
      assert(throw Exception('Please fix the problem')); //khắc phục sự cố
    }
  }

  ///
  /// Exception (fatal)
  /// Transition to the `403` page
  ///
  void _fatalHandler() {
    if (isRelease) {
      /// TODO: deleteSecurityToken
      /// router.replaceAll([const ForbiddenRoute()])
    } else {
      assert(throw Exception('Please fix the problem'));
    }
  }

  ///
  /// Exception (Not Find - không tìm thấy)
  /// Transition to the `404` page
  ///
  void _notFoundErrorHandler() {
    /// TODO: router.replaceAll([const NotFoundRoute()])
  }

  ///
  /// Exception (validation error)
  /// Display an alert dialog
  ///
  void _validationErrorHandler(String message) {
    final messageRes = message.isNotEmpty
        ? message
        : 'There is an invalid input value. Please check your input.';

    alertHandler(messageRes);
  }

  ///
  /// Exception (server error)
  /// Display an alert dialog
  ///
  void _serverErrorHandler() {
    alertHandler(
      'Please check the communication status and try again.',
      title: 'No response',
    );
  }

  ///
  /// Forced version upgrade Nâng cấp phiên bản bắt buộc
  ///
  void forcedUpdateHandler() {
    /// TODO: router.replaceAll([const ForcedUpdateRoute()])
  }
}
