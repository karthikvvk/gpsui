import 'package:flutter/foundation.dart';

class AppSession extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  /// Display name of the currently signed-in account (the person using the app).
  String _viewerName = 'You';

  /// When set, this represents a *different* account being viewed (e.g., a child).
  String? _linkedChildName;

  String get viewerName => _viewerName;
  String? get linkedChildName => _linkedChildName;

  bool get hasLinkedChild => _linkedChildName != null && _linkedChildName!.trim().isNotEmpty;

  /// Name to show in the UI as the subject being tracked/viewed.
  /// If the user is viewing their own account, this returns "You".
  String get subjectName => hasLinkedChild ? _linkedChildName!.trim() : 'You';

  void signIn() {
    _signedIn = true;
    notifyListeners();
  }

  void signOut() {
    _signedIn = false;
    // Reset UI-only state on sign out.
    _viewerName = 'You';
    _linkedChildName = null;
    notifyListeners();
  }

  /// UI-only helper: simulates linking to a child account.
  void linkChild({required String childName}) {
    final trimmed = childName.trim();
    _linkedChildName = trimmed.isEmpty ? null : trimmed;
    notifyListeners();
  }

  /// UI-only helper: removes the linked child account.
  void unlinkChild() {
    _linkedChildName = null;
    notifyListeners();
  }
}
