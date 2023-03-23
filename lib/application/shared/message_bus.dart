import 'dart:async';

/// An event type for use with [MessageBus].
abstract class Event {}

/// A message bus class. Clients can listen for classes of events, optionally
/// filtered by a string type. This can be used to decouple events sources and
/// event listeners.
class MessageBus {
  MessageBus._() : _controller = StreamController.broadcast();

  /// Get the singleton instance of the [MessageBus].
  static final instance = MessageBus._();

  /// The underlying stream controller.
  late final StreamController<Event> _controller;

  /// Listens for events of Type [T] and its subtypes.
  Stream<T> on<T extends Event>() {
    return _controller.stream.where((Event event) => event is T).cast<T>();
  }

  /// Add an event to the event bus.
  void publish(Event event) {
    _controller.add(event);
  }

  /// Close (destroy) this [MessageBus]. This is generally not used outside of a
  /// testing context. All stream listeners will be closed and the bus will not
  /// fire any more events.
  void close() {
    _controller.close();
  }
}

class EventSubscriber {
  EventSubscriber();

  StreamSubscription<Event> onEvent<T extends Event>(void Function(T) callback) {
    return MessageBus.instance.on<T>().listen(callback);
  }
}
