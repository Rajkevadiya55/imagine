/// Http exception used in send custom exception during api call.
/// mostly used in send custom exception from repository and catch the exception in cubit.
class CustomHttpException implements Exception{
  final String message;
  CustomHttpException({required this.message});
}