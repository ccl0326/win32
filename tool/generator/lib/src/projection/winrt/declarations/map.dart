import 'package:winmd/winmd.dart';

import '../../../../generator.dart';

mixin _MapProjection on WinRTMethodProjection {
  /// The type arguments of `IMap` and `IMapView`, as represented in the
  /// [returnType]'s [TypeIdentifier] (e.g. `String, Object?`, `String, String?`).
  String get mapTypeArgs => typeArguments(returnType.typeIdentifier.name);

  /// The constructor arguments passed to the constructors of `IMap` and
  /// `IMapView`.
  String get mapConstructorArgs {
    final typeProjection =
        TypeProjection(returnType.typeIdentifier.typeArg!.typeArg!);

    // If the type argument is an enum, a WinRT Object (e.g. IJsonValue), the
    // constructor of that class must be passed in the 'enumCreator' parameter
    // for enum, 'creator' parameter for WinRT Object so that the 'IMap' and
    // 'IMapView' implementations can instantiate the object
    final creator = parseArgumentForCreatorParameter(
        returnType.typeIdentifier.typeArg!.typeArg!);

    if (typeProjection.isWinRTEnum) return ', enumCreator: $creator';
    return creator == null ? '' : ', creator: $creator';
  }
}

class WinRTMethodReturningMapProjection extends WinRTMethodProjection
    with _MapProjection {
  WinRTMethodReturningMapProjection(super.method, super.vtableOffset);

  @override
  String toString() => '''
      IMap<$mapTypeArgs> $camelCasedName($methodParams) {
        final retValuePtr = calloc<COMObject>();
        $parametersPreamble
        ${ffiCall(freeRetValOnFailure: true)}
        $parametersPostamble
        return IMap.fromRawPointer(retValuePtr$mapConstructorArgs);
      }
  ''';
}

class WinRTGetPropertyReturningMapProjection extends WinRTGetPropertyProjection
    with _MapProjection {
  WinRTGetPropertyReturningMapProjection(super.method, super.vtableOffset);

  @override
  String toString() => '''
      IMap<$mapTypeArgs> get $exposedMethodName {
        final retValuePtr = calloc<COMObject>();

        ${ffiCall(freeRetValOnFailure: true)}

        return IMap.fromRawPointer(retValuePtr$mapConstructorArgs);
      }
  ''';
}

class WinRTMethodReturningMapViewProjection extends WinRTMethodProjection
    with _MapProjection {
  WinRTMethodReturningMapViewProjection(super.method, super.vtableOffset);

  @override
  String toString() => '''
      Map<$mapTypeArgs> $camelCasedName($methodParams) {
        final retValuePtr = calloc<COMObject>();
        $parametersPreamble

        try {
          ${ffiCall()}
          return IMapView<$mapTypeArgs>.fromRawPointer
            (retValuePtr$mapConstructorArgs).toMap();
        } finally {
          $parametersPostamble
          free(retValuePtr);
        }
      }
  ''';
}

class WinRTGetPropertyReturningMapViewProjection
    extends WinRTGetPropertyProjection with _MapProjection {
  WinRTGetPropertyReturningMapViewProjection(super.method, super.vtableOffset);

  @override
  String toString() => '''
      Map<$mapTypeArgs> get $exposedMethodName {
        final retValuePtr = calloc<COMObject>();

        try {
          ${ffiCall()}
          return IMapView<$mapTypeArgs>.fromRawPointer
            (retValuePtr$mapConstructorArgs).toMap();
        } finally {
          free(retValuePtr);
        }
      }
  ''';
}
