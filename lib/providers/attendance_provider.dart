import 'dart:collection';
import 'package:flutter/foundation.dart';
import '../models/student.dart';

class AttendanceProvider extends ChangeNotifier {
  final List<Student> _students = [];

  /// Unmodifiable view of students list
  UnmodifiableListView<Student> get students => UnmodifiableListView(_students);

  /// Total count of students
  int get totalStudents => _students.length;

  /// Count of present students
  int get presentStudents =>
      _students.where((student) => student.isPresent).length;

  /// Count of absent students
  int get absentStudents =>
      _students.where((student) => !student.isPresent).length;

  /// Add a new student. Initial attendance is always absent (isPresent: false).
  void addStudent(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return;

    final newStudent = Student(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: trimmedName,
      isPresent: false,
    );

    _students.add(newStudent);
    notifyListeners();
  }

  /// Toggle attendance state for a student
  void toggleAttendance(String id) {
    final index = _students.indexWhere((student) => student.id == id);
    if (index != -1) {
      _students[index].isPresent = !_students[index].isPresent;
      notifyListeners();
    }
  }

  /// Remove a student by id
  void removeStudent(String id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }
}
