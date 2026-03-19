// ignore_for_file: avoid_print

import 'package:quiz_app_supabase/models/category.dart';
import 'package:quiz_app_supabase/models/question.dart';
import 'package:quiz_app_supabase/models/quiz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .order('created_at', ascending: true);
      return (response as List)
          .map((category) => Category.fromJson(category))
          .toList();
    } catch (e, st) {
      print('Error fetching categories: $e\n$st');
      throw Exception('Failed to fetch categories: ${e.toString()}');
    }
  }

  Future<List<Quiz>> getQuizzesByCategory(String categoryId) async {
    try {
      final response = await _supabase
          .from('quizzes')
          .select()
          .eq('category_id', categoryId)
          .order('created_at', ascending: true);
      return (response as List).map((quiz) => Quiz.fromJson(quiz)).toList();
    } catch (e, st) {
      print('Error fetching quizzes: $e\n$st');
      throw Exception('Failed to fetch quizzes: ${e.toString()}');
    }
  }

  Future<List<Question>> getQuestionsByQuiz(String quizId) async {
    try {
      final response = await _supabase
          .from('questions')
          .select()
          .eq('quiz_id', quizId)
          .order('created_at', ascending: true);
      return (response as List)
          .map((question) => Question.fromJson(question))
          .toList();
    } catch (e, st) {
      print('Error fetching questions: $e\n$st');
      throw Exception('Failed to fetch questions: ${e.toString()}');
    }
  }

  Future<Category> getCategoryById(String categoryId) async {
    try {
      final response =
          await _supabase
              .from('categories')
              .select()
              .eq('id', categoryId)
              .single();
      return Category.fromJson(response);
    } catch (e, st) {
      print('Error fetching category: $e\n$st');
      throw Exception('Failed to fetch category: ${e.toString()}');
    }
  }

  Future<Quiz> getQuizById(String quizId) async {
    try {
      final response =
          await _supabase.from('quizzes').select().eq('id', quizId).single();
      return Quiz.fromJson(response);
    } catch (e, st) {
      print('Error fetching quiz: $e\n$st');
      throw Exception('Failed to fetch quiz: ${e.toString()}');
    }
  }
}
