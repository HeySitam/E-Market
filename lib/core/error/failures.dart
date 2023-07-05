abstract class Failure {
  String? message;
  Failure({this.message});
}

// General Failures
class ServerFailure extends Failure{
  ServerFailure({super.message});
}

class CacheFailure extends Failure{
  CacheFailure({super.message});
}