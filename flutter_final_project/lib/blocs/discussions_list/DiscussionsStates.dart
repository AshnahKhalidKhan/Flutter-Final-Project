import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/DiscussionsModel.dart';

abstract class DiscussionsState extends Equatable
{
  const DiscussionsState();
  List<Object> get props => [];
}

class DiscussionsEmptyState extends DiscussionsState
{
  //Ye empty rahay ga
}

class DiscussionsInitialState extends DiscussionsState
{
  //Ye bhi empty rahay ga
}

class DiscussionsLoadingState extends DiscussionsState
{
  @override
  List<Object> get props => [];
}

class DiscussionsSuccessOrLoadedState extends DiscussionsState
{
  final List<Discussion> discussion;
  const DiscussionsSuccessOrLoadedState(this.discussion);

  @override
  List<Object> get props => [discussion];
}

class DiscussionsErrorState extends DiscussionsState
{
  final String error;
  const DiscussionsErrorState(this.error);

  @override
  List<Object> get props => [error];
}