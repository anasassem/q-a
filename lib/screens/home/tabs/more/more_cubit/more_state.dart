part of 'more_cubit.dart';

abstract class MoreState {}

class MoreInitial extends MoreState {}

class AddReviewLoading extends MoreState {}

class AddReviewSuccess extends MoreState {}

class AddReviewFailure extends MoreState {}

class GetReviewsLoading extends MoreState {}

class GetReviewsSuccess extends MoreState {}

class GetReviewsFailure extends MoreState {}

class DeleteReviewsFailure extends MoreState {}

class DeleteReviewsSuccess extends MoreState {}

class DeleteReviewsLoading extends MoreState {}