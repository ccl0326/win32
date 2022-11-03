import 'dart:ffi';

final _wtsapi32 = DynamicLibrary.open('wtsapi32.dll');

///
/// BOOL WTSEnableChildSessions(
///   BOOL bEnable
/// );
///
int WTSEnableChildSessions(int bEnable) => _WTSEnableChildSessions(bEnable);

final _WTSEnableChildSessions = _wtsapi32.lookupFunction<
    Int32 Function(Int32 bEnable),
    int Function(int bEnable)>('WTSEnableChildSessions');
