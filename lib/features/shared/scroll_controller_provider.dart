import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for scroll controller
final scrollControllerProvider = StateProvider<ScrollController>((ref) {
  return ScrollController();
});

// Provider for AppBar visibility
final appBarVisibilityProvider = StateProvider<bool>((ref) {
  return true; // Initially visible
});

// Provider for scroll direction detection
class ScrollDirectionNotifier extends StateNotifier<bool> {
  ScrollDirectionNotifier() : super(true);
  
  double _lastScrollPosition = 0.0;
  
  void updateScrollPosition(double currentPosition) {
    const double threshold = 10.0; // Minimum scroll distance to trigger hide/show
    
    if ((currentPosition - _lastScrollPosition).abs() > threshold) {
      if (currentPosition > _lastScrollPosition && currentPosition > 100) {
        // Scrolling down and past initial threshold - hide AppBar
        if (state) {
          state = false;
        }
      } else if (currentPosition < _lastScrollPosition) {
        // Scrolling up - show AppBar
        if (!state) {
          state = true;
        }
      }
      _lastScrollPosition = currentPosition;
    }
  }
}

final scrollDirectionProvider = StateNotifierProvider<ScrollDirectionNotifier, bool>((ref) {
  return ScrollDirectionNotifier();
});