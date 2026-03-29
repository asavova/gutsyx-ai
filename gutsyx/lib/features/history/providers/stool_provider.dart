import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutsyx/features/history/models/stool_entry.dart';

class StoolNotifier extends StateNotifier<List<StoolEntry>> {
  StoolNotifier() : super([]);

  void addEntry(StoolEntry entry) {
    state = [entry, ...state];
  }

  double calculateWeeklyScore() {
    if (state.isEmpty) return 0;
    // Simple average for now
    double total = 0;
    for (var entry in state) {
      // Bristol 3 & 4 are ideal (100 points)
      if (entry.bristolScale == 3 || entry.bristolScale == 4) {
        total += 100;
      } else if (entry.bristolScale == 2 || entry.bristolScale == 5) {
        total += 70;
      } else {
        total += 40;
      }
    }
    return total / state.length;
  }
}

final stoolProvider = StateNotifierProvider<StoolNotifier, List<StoolEntry>>((ref) {
  return StoolNotifier();
});
