part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
}

class InfoInitial extends InfoState {
  @override
  List<Object> get props => [];
}
