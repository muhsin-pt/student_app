part of 'bottom_navigation_cubit.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState({required this.currentIndex});
  final int currentIndex;
  @override
  List<Object> get props => [currentIndex];

  BottomNavigationState copyWith({
    int? currentIndex,
  }) {
    return BottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
