import 'package:flutter/widgets.dart';
export 'package:soulhealer/core/models/network_failure.dart';
export 'package:soulhealer/common/k_toast.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _loading = false;
  String _failure;

  bool get loading => _loading;
  bool get hasFailure => _failure != null;
  String get failure => _failure;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setFailure(String value) {
    _failure = value;
    notifyListeners();
  }

  void clearFailure() => setFailure(null);

  update(Function function) {
    function();
    notifyListeners();
  }
}
