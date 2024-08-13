import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];

  String getMessage(BuildContext context);
}

class ServerFailure extends Failure {
  @override
  String getMessage(BuildContext context) {
    return L10n.of(context).serverFailure;
  }
}

class CacheFailure extends Failure {
  @override
  String getMessage(BuildContext context) {
    return L10n.of(context).cacheFailure;
  }
}

class NetworkFailure extends Failure {
  @override
  String getMessage(BuildContext context) {
    return L10n.of(context).networkFailure;
  }
}

class InvalidInputFailure extends Failure {
  @override
  String getMessage(BuildContext context) {
    return L10n.of(context).invalidInputFailure;
  }
}

String mapFailureToMessage(Failure failure, BuildContext context) {
  switch (failure.runtimeType) {
    case ServerFailure _:
      return L10n.of(context).serverFailure;
    case CacheFailure _:
      return L10n.of(context).cacheFailure;
    case NetworkFailure _:
      return L10n.of(context).networkFailure;
    case InvalidInputFailure _:
      return L10n.of(context).invalidInputFailure;
    default:
      return L10n.of(context).unexpectedError;
  }
}
