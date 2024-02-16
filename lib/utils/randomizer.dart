import 'dart:math';

extension Randomizer<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
