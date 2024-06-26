/*
 * Copyright (c) 2015, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 * 
 * All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/// Helper to get the runtime-Info.
class InstanceCheck<T> {
  final bool _strict;

  /// if strict is set to true List<String> == List comparison return false
  InstanceCheck({final bool strict = true}) : _strict = strict;

  bool check(final obj) {
    return (obj is T && _strict == false) ||
        (_strict == true && obj is T && obj.runtimeType.toString() == type);
  }

  String get type {
    final String type = runtimeType
        .toString()
        .replaceFirst(RegExp(r'[^<]+<'), '')
        .replaceFirst(RegExp(r'>$'), '');
    return type;
  }
}
