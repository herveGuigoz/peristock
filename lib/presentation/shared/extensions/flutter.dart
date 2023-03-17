import 'package:flutter/material.dart';

extension AsyncSnapshotExt<T> on AsyncSnapshot<T> {
  R when<R>({
    required R Function() loading,
    required R Function(T? value) data,
    required R Function(Object error) error,
  }) {
    if (hasData) return data(this.data);

    if (hasError) return error(error);

    return loading();
  }
}
