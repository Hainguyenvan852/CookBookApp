abstract class Failure {
  final String message;
  Failure(this.message);
}

class AuthFailure extends Failure{
  AuthFailure(super.message);
}

class QueryFailure extends Failure{
  QueryFailure(super.message);
}