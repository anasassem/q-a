import 'package:bloc/bloc.dart';
import 'package:testqa/models/review_model.dart';
import 'package:testqa/screens/home/tabs/more/widgets/more_w_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ReviewModel> reviews = [];

  MoreCubit() : super(MoreInitial());

  static MoreCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addReview(ReviewModel model) async {
    emit(AddReviewLoading());
    try {
      await firestore.collection("reviews").add(model.toJson());
      emit(AddReviewSuccess());
    } catch (e) {
      emit(AddReviewFailure());
    }
  }

  Future<void> getReviews() async {
    emit(GetReviewsLoading());
    try {
      final result =  await firestore.collection("reviews").get();
      reviews = result.docs.map((e) => ReviewModel.fromJson(e.data(), e.id)).toList();
      emit(GetReviewsSuccess());
    } catch (e) {
      emit(GetReviewsFailure());
    }
  }


  Future<void> deleteReview(String id) async {
    emit(DeleteReviewsLoading());
    try {
      await firestore.collection("reviews").doc(id).delete();
      emit(DeleteReviewsSuccess());
    } catch (e) {
      emit(DeleteReviewsFailure());
    }
  }
}
