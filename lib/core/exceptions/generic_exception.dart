part of exceptions;

class GenericException implements Exception {
  final ExceptionType code;
  final String message;
  final Exception? innerException;
  final StackTrace? stackTrace;

  const GenericException({
    this.code = ExceptionType.warn,
    required this.message,
  })  : innerException = null,
        stackTrace = null;

  const GenericException.withInner({
    this.code = ExceptionType.warn,
    required this.message,
    this.innerException,
    this.stackTrace,
  });

  @override
  String toString() {
    if (innerException == null) {
      return 'GenericException $code: $message';
    }
    return 'GenericException $code: $message (Inner exception: $innerException)\n\n$stackTrace';
  }

  factory GenericException.handler(dynamic e) {
    String? message;
    ExceptionType code;

    switch (e) {
      // SocketException
      case SocketException:
        {
          code = ExceptionType.serverError;
          message = e.message;
          break;
        }

      // PlatformException
      case PlatformException:
        {
          code = ExceptionType.fatal;
          message = e.message;
          break;
        }

      // MissingPluginException
      case MissingPluginException:
        {
          code = ExceptionType.fatal;
          message = e.message;
          break;
        }

      // TimeoutException
      case TimeoutException:
        {
          code = ExceptionType.serverError;
          message = e.message;
          break;
        }

      // PlatformException
      case GenericException:
        {
          code = e.code;
          message = e.message;
          break;
        }

      default:
        {
          code = ExceptionType.fatal;
          message = e.toString();
        }
    }

    return GenericException(
      message: message ?? 'GenericException',
      code: code,
    );
  }
}

class UnauthorizedException extends GenericException {
  const UnauthorizedException(
    String message, {
    ExceptionType code = ExceptionType.unauthorizedError,
  }) : super(code: code, message: message);
}

class FatalException extends GenericException {
  FatalException(
    String target, {
    ExceptionType code = ExceptionType.fatal,
  })  : assert(target.isNotEmpty),
        super(code: code, message: '$target does not exist.');
}

class NotFoundException extends GenericException {
  NotFoundException(
    String target, {
    ExceptionType code = ExceptionType.alert,
  })  : assert(target.isNotEmpty),
        super(code: code, message: '$target could not be found.');
}

class NotUniqueException extends GenericException {
  NotUniqueException(
    String value, {
    ExceptionType code = ExceptionType.validationError,
  })  : assert(value.isNotEmpty),
        super(code: code, message: '$value is duplicated.');
}

class NullEmptyException extends GenericException {
  NullEmptyException(
    String value, {
    ExceptionType code = ExceptionType.validationError,
  })  : assert(value.isNotEmpty),
        super(code: code, message: '$value is required.');
}

class LengthException extends GenericException {
  LengthException(
    String value,
    int max, {
    ExceptionType code = ExceptionType.validationError,
  })  : assert(max > 0),
        super(code: code, message: 'The maximum value of $value is $max.');
}

class RemovalException extends GenericException {
  RemovalException(
    String value, {
    ExceptionType code = ExceptionType.alert,
  }) : super(code: code, message: '$value could not be deleted.');
}

class ValidationException extends GenericException {
  ValidationException(
    String value, {
    ExceptionType code = ExceptionType.alert,
  }) : super(code: code, message: '$value is an invalid input value.');
}
