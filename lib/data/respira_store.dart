import 'package:flutter/foundation.dart';

/// Registro de ánimo de un día.
class MoodEntry {
  const MoodEntry({required this.level, required this.date});

  /// Nivel de ánimo de 0 (muy bajo) a 4 (muy bien).
  final int level;
  final DateTime date;
}

/// Datos de una sesión de "Tres cosas buenas".
class GratitudeEntry {
  const GratitudeEntry({required this.answers, required this.date});

  final List<String> answers;
  final DateTime date;
}

/// Guarda lo que la persona registra mientras usa la app.
/// Los datos se quedan solo en la memoria del teléfono.
class RespiraStore extends ChangeNotifier {
  final List<MoodEntry> _moods = [];
  final Set<String> _completedSteps = {};
  final List<GratitudeEntry> _gratitude = [];

  List<MoodEntry> get moods => List.unmodifiable(_moods);

  MoodEntry? get todayMood {
    final now = DateTime.now();
    for (final entry in _moods.reversed) {
      if (_sameDay(entry.date, now)) return entry;
    }
    return null;
  }

  /// Registra el ánimo de hoy. Si ya había uno, lo reemplaza.
  void registerMood(int level) {
    final now = DateTime.now();
    _moods.removeWhere((entry) => _sameDay(entry.date, now));
    _moods.add(MoodEntry(level: level, date: now));
    notifyListeners();
  }

  bool isStepDone(String id) => _completedSteps.contains(id);

  int get completedStepsCount => _completedSteps.length;

  void toggleStep(String id) {
    if (!_completedSteps.remove(id)) {
      _completedSteps.add(id);
    }
    notifyListeners();
  }

  List<GratitudeEntry> get gratitude => List.unmodifiable(_gratitude);

  void addGratitude(List<String> answers) {
    _gratitude.add(GratitudeEntry(answers: answers, date: DateTime.now()));
    notifyListeners();
  }

  /// Borra todo lo registrado.
  void clearAll() {
    _moods.clear();
    _completedSteps.clear();
    _gratitude.clear();
    notifyListeners();
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
