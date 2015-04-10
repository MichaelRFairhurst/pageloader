// Copyright 2014 Google Inc. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library pageloader.async.test.mouse;

import 'package:matcher/matcher.dart';
import 'package:pageloader/async/objects.dart';
import 'package:unittest/unittest.dart';
import 'package:webdriver/async_helpers.dart';
import 'shared.dart';

void runTests() {
  group('mouse tests', () {
    test('mouse', () async {
      PageForMouseTest page = await loader.getInstance(PageForMouseTest);

      await loader.mouse.moveTo(page.element, 2, 2);
      await waitFor(() => page.element.visibleText,
          matcher: contains('MouseMove'));
      await loader.mouse.down(0);
      await waitFor(() => page.element.visibleText,
          matcher: contains('MouseDown'));
      await loader.mouse.moveTo(page.element, 10, 10);
      await loader.mouse.up(0);
      await waitFor(() => page.element.visibleText,
          matcher: contains('MouseUp'));
    });

    test('mouse with event target', () async {
      PageForMouseTest page = await loader.getInstance(PageForMouseTest);

      // make sure mouse is not on element;
      await loader.mouse.moveTo(page.element, -10, -10);
      await loader.mouse.down(0, eventTarget: page.element);
      await waitFor(() => page.element.visibleText,
          matcher: contains('MouseDown'));
      await loader.mouse.moveTo(page.element, 200, 200);
      await loader.mouse..up(0, eventTarget: page.element);
      await waitFor(() => page.element.visibleText,
          matcher: contains('MouseUp'));
    });
  });
}

class PageForMouseTest {
  @ById('mouse')
  PageLoaderElement element;
}
