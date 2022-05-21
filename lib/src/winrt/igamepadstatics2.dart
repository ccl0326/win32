// IGamepadStatics2.dart

// THIS FILE IS GENERATED AUTOMATICALLY AND SHOULD NOT BE EDITED DIRECTLY.

// ignore_for_file: unused_import, directives_ordering
// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../callbacks.dart';
import '../combase.dart';
import '../constants.dart';
import '../exceptions.dart';
import '../guid.dart';
import '../macros.dart';
import '../ole32.dart';
import '../structs.dart';
import '../structs.g.dart';
import '../utils.dart';

import 'igamepadstatics.dart';
import '../api_ms_win_core_winrt_string_l1_1_0.dart';
import '../winrt_helpers.dart';
import '../types.dart';

import '../extensions/hstring_array.dart';
import 'ivector.dart';
import 'ivectorview.dart';

import '../com/iinspectable.dart';

/// @nodoc
const IID_IGamepadStatics2 = '{42676DC5-0856-47C4-9213-B395504C3A3C}';

/// {@category Interface}
/// {@category winrt}
class IGamepadStatics2 extends IGamepadStatics {
  // vtable begins at 6, is 1 entries long.
  IGamepadStatics2(Pointer<COMObject> ptr) : super(ptr);

  Pointer<COMObject> FromGameController(Pointer<COMObject> gameController) {
    final retValuePtr = calloc<COMObject>();

    final hr =
        ptr.ref.vtable
                .elementAt(6)
                .cast<
                    Pointer<
                        NativeFunction<
                            HRESULT Function(
                                Pointer,
                                Pointer<COMObject> gameController,
                                Pointer<COMObject>)>>>()
                .value
                .asFunction<
                    int Function(Pointer, Pointer<COMObject> gameController,
                        Pointer<COMObject>)>()(ptr.ref.lpVtbl,
            gameController.cast<Pointer<COMObject>>().value, retValuePtr);

    if (FAILED(hr)) throw WindowsException(hr);

    return retValuePtr;
  }
}