part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class Show extends InfoEvent {
  final YoutubeVideo video;
  final YoutubeChannel channel;

  Show({this.video, this.channel});
  @override
  List<Object> get props => [video, channel];
}
