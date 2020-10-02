class EventBus {
  EventBus._constructor();

  static EventBus _singleton = new EventBus._constructor();

  factory EventBus() => _singleton;

  var _emap = new Map<String, List<Function>>();

  void on(eventName, Function fn) {
    if (eventName == null || fn == null) {
      return;
    }
    _emap[eventName] ??= List<Function>();
    _emap[eventName].add(fn);
  }

  void emit(eventName, [arg]) {
    var deps = _emap[eventName];
    if (deps == null) {
      return;
    }
    deps.forEach((fn) => fn(arg));
  }
}

var eventBus = new EventBus();
