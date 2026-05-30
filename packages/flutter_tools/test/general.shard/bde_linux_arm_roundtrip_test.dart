// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// BDE-verify-only scratch test for flutter/flutter #187018 (linux_arm enum).
// Asserts the linux_arm round-trip is consistent with linux_arm64/linux_x64.
// NOT for upstream submission; delete with the verification branch.

import 'package:flutter_tools/src/build_info.dart';

import '../src/common.dart';

void main() {
  testWithoutContext('linux_arm getNameForTargetPlatform round-trip', () {
    expect(getNameForTargetPlatform(TargetPlatform.linux_arm), 'linux-arm');
    expect(getTargetPlatformForName('linux-arm'), TargetPlatform.linux_arm);
    // Full round-trip both directions.
    expect(
      getTargetPlatformForName(getNameForTargetPlatform(TargetPlatform.linux_arm)),
      TargetPlatform.linux_arm,
    );
    expect(
      getNameForTargetPlatform(getTargetPlatformForName('linux-arm')),
      'linux-arm',
    );
  });

  testWithoutContext('linux_arm does not collide with linux_arm64 / linux_x64', () {
    expect(getNameForTargetPlatform(TargetPlatform.linux_arm64), 'linux-arm64');
    expect(getNameForTargetPlatform(TargetPlatform.linux_x64), 'linux-x64');
    expect(getTargetPlatformForName('linux-arm64'), TargetPlatform.linux_arm64);
    expect(getTargetPlatformForName('linux-x64'), TargetPlatform.linux_x64);
  });

  testWithoutContext('linux_arm enum-method handling matches linux sibling intent', () {
    // osName joins the linux group.
    expect(TargetPlatform.linux_arm.osName, 'linux');
    // simpleName resolves to the 32-bit arm short name.
    expect(TargetPlatform.linux_arm.simpleName, 'arm');
  });
}
