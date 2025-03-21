/// Http exception used in send custom exception during api call.
/// mostly used in send custom exception from repository and catch the exception in cubit.
class CustomHttp404Exception implements Exception{
  final String message;
  CustomHttp404Exception({required this.message});
}