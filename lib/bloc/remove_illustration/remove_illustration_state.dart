part of 'remove_illustration_bloc.dart';

abstract class RemoveIllustrationState extends Equatable {
  const RemoveIllustrationState();
}

class RemoveIllustrationInitial extends RemoveIllustrationState {
  @override
  List<Object> get props => [];
}

class RemoveIllustrationLoading extends RemoveIllustrationState {
  @override
  List<Object> get props => [];
}

class RemoveIllustrationSuccess extends RemoveIllustrationState {
  @override
  List<Object> get props => [];
}

class RemoveIllustrationError extends RemoveIllustrationState {
  final String errorText;
  RemoveIllustrationError({
    this.errorText,
  });
  @override
  List<Object> get props => [errorText];
}
