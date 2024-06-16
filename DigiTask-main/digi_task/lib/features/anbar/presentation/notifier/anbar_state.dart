import 'package:equatable/equatable.dart';

import '../../data/model/anbar_item_model.dart';

abstract class AnabarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnbarInitial extends AnabarState {}

class AnbarLoading extends AnabarState {}

class AnbarSuccess extends AnabarState {
  final List<AnbarItemModel> anbarList;
  AnbarSuccess({required this.anbarList});

  @override
  List<Object?> get props => [anbarList];
}

class AnbarFailure extends AnabarState {
  final String message;
  AnbarFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
