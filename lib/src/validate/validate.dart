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

import 'dart:convert';
import 'errors.dart';
import 'expect.dart' as expect;
import 'utils.dart';

/*
 * This class assists in validating arguments. The validation methods are
 * based along the following principles:
 *
 *      Validate.isTrue(i > 0, "The value must be greater than zero");
 *      Validate.notNull(surname, "The surname must not be null");
 *
 * For testing - use it like this:
 *      class UserContext {
 *          final String _restID;
 *          UserContext(this._restID) {
 *              Validate.isUUID(_restID);
 *          }
 *      }
 *      test('> wrong ID ', () {
 *          expect(() => new UserContext("abc"),
 *          throwsArgumentError);
 *      }); // end of 'wrong ID ' test
 *
 */

/*
 * Pattern-RegExp:
 *      http://goo.gl/jxPnU3
 *      http://www.mkyong.com/regular-expressions/how-to-validate-password-with-regular-expression/
 */
abstract class Validate {
  static const String PATTERN_EMAIL =
      "^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$";
  static const String PATTERN_PW =
      "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#\$%?])[0-9a-zA-Z@#\$%?]{8,15}\$";
  static const String PATTERN_ALPHANUMERIC = "^[a-zA-Z0-9öäüÖÄÜß]+\$";
  static const String PATTERN_HEX = "^(0x[a-fA-F0-9]+)|([a-fA-F0-9])+\$";
  static const String PATTERN_UUID =
      "^[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}\$";

  static const String DEFAULT_IS_TRUE_EX_MESSAGE =
      "The validated expression is false";
  static const String DEFAULT_IS_NULL_EX_MESSAGE =
      "The validated object is null";
  static const String DEFAULT_NOT_EMPTY_MESSAGE =
      "The validated value is empty";
  static const String DEFAULT_NOT_BLANK_EX_MESSAGE =
      "The validated string is blank";
  static const String DEFAULT_NO_NULL_ELEMENTS_ARRAY_EX_MESSAGE =
      "The validated array contains null element";
  static const String DEFAULT_VALID_INDEX_ARRAY_EX_MESSAGE =
      "The validated array index is invalid";
  static const String DEFAULT_VALID_STATE_EX_MESSAGE =
      "The validated state is false";
  static const String DEFAULT_MATCHES_PATTERN_EX =
      "The string does not match the pattern";
  static const String DEFAULT_INCLUSIVE_BETWEEN_EX_MESSAGE =
      "The value is not in the specified inclusive range";
  static const String DEFAULT_EXCLUSIVE_BETWEEN_EX_MESSAGE =
      "The value is not in the specified exclusive range";
  static const String DEFAULT_JSON_MESSAGE =
      "The value is neither a num, String, bool, Null, List or Map";
  static const String DEFAULT_KEY_IN_MAP_MESSAGE =
      "The key '%key%' is not available for this structure: %structure%";

  static const String DEFAULT_IS_INSTANCE_OF_EX_MESSAGE =
      "The instance of the validated object is invalid. Should have been %wish% but was %truth%";

  /// prettyPrint for JSON (Used for KeyInMap check)
  static const JsonEncoder _PRETTYJSON = const JsonEncoder.withIndent('  ');

  /*
  static const String _DEFAULT_NO_NULL_ELEMENTS_COLLECTION_EX_MESSAGE = "The validated collection contains null element at specified index";
  static const String _DEFAULT_VALID_INDEX_CHAR_SEQUENCE_EX_MESSAGE = "The validated character sequence index is invalid";
  static const String _DEFAULT_VALID_INDEX_COLLECTION_EX_MESSAGE ="The validated collection index is invalid";
  */

  // isTrue
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the argument condition is [true] otherwise
  * throwing an exception with the specified message. This method is useful when
  * validating according to an arbitrary boolean expression, such as validating a
  * primitive number or using your own custom validation expression.</p>
  *
  * <pre>Validate.isTrue(i > 0.0, "The value must be greater than zero: $value");</pre>
  *
  * [expression]  the boolean expression to check
  * [message]  the exception message if invalid, not null
  * Throws [ArgumentError] if expression is [false]
  */
  static bool isTrue(final bool expression,
          [final String message = DEFAULT_IS_TRUE_EX_MESSAGE]) =>
      expect.isTrue(expression, message: () => message);

  // notNull
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument is not [null];
  * otherwise throwing an exception.
  *
  * <pre>Validate.notNull(myObject, "The object must not be null");</pre>
  *
  * <p>The message of the exception is &quot;The validated object is
  * null&quot;.</p>
  *
  * [object]  the object to check
  * Returns the validated object if not null
  * Throws [ArgumentError] if the object is null
  */
  static T notNull<T>(final T object,
          [String message = DEFAULT_IS_NULL_EX_MESSAGE]) =>
      expect.notNull(object, message: () => message);

  // notEmpty array
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument is neither [null]
  * nor is empty (object must have isEmpty implemented); otherwise throwing an exception
  * with the specified message.
  *
  * <pre>Validate.notEmpty(myArray, "The array must not be empty");</pre>
  *
  * [value]  the value to check, validated not null by this method
  * [message] the exception message if invalid, not null
  * Returns the validated value (never [null] method for chaining)
  * Throws [ArgumentError] if the array is [null]
  * Throws [ArgumentError] if the array is empty
  */
  static notEmpty(final value, [String message = DEFAULT_NOT_EMPTY_MESSAGE]) {
    Validate.notNull(value, message);

    if (value.isEmpty) {
      throw new ArgumentError(message);
    }

    return value;
  }

  // notBlank string
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified string is
  * neither [null], a length of zero (no characters), empty
  * nor whitespace; otherwise throwing an exception with the specified
  * message.
  *
  * <pre>Validate.notBlank(myString, "The string must not be blank");</pre>
  *
  * [value] the string to check, validated not null by this method
  * [message] the exception message if invalid, not null
  * Returns the validated string
  * Throws [ArgumentError] if the character sequence is [null]
  * Throws [ArgumentError] if the character sequence is blank
  */
  static String? notBlank(final String? value,
      [String message = DEFAULT_NOT_BLANK_EX_MESSAGE]) {
    Validate.notNull(value, message);
    if ((value is String) == false || value!.trim().isEmpty) {
      throw new ArgumentError(message);
    }
    return value;
  }

  // noNullElements array
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument array is neither
  * [null] nor contains any elements that are [null];
  * otherwise throwing an exception with the specified message.
  *
  * <pre>Validate.noNullElements(myArray, "The validated array contains null element");</pre>
  *
  * <p>If the array is [null], then the message in the exception
  * is &quot;The validated object is null&quot;.</p>
  *
  * [iterable] the Iterable to check, validated not null by this method
  * [message] the exception message if invalid, not null
  * Returns the validated iterable (never [null] method for chaining)
  * Throws [ArgumentError] if the iterable is [null]
  * Throws [ArgumentError] if an element is [null]
  */
  static Iterable noNullElements(Iterable iterable,
      [String message = DEFAULT_NO_NULL_ELEMENTS_ARRAY_EX_MESSAGE]) {
    Validate.notNull(iterable);
    for (var x in iterable) {
      if (x == null) {
        throw new ArgumentError(message);
      }
    }

    return iterable;
  }

  // validIndex array
  //---------------------------------------------------------------------------------

  /*
  * <p>Validates that the index is within the bounds of the argument
  * iterable; otherwise throwing an exception with the specified message.</p>
  *
  * <pre>Validate.validIndex(iterable, 2, "The validated array index is invalid");</pre>
  *
  * <p>If the array is [null], then the message of the exception
  * is &quot;The validated object is null&quot;.</p>
  *
  * [iterable] the iterable to check, validated not null by this method
  * [index] the index to check
  * [message] the exception message if invalid, not null
  * Returns the validated iterable (never [null] for method chaining)
  * Throws [ArgumentError] if the array is [null]
  * Throws [RangeError] if the index is invalid
  */
  static Iterable validIndex(Iterable iterable, int index,
      [String message = DEFAULT_VALID_INDEX_ARRAY_EX_MESSAGE]) {
    Validate.notNull(iterable);
    if (index < 0 || index >= iterable.length) {
      throw new RangeError(message);
    }
    return iterable;
  }

  // validState
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the stateful condition is [true] otherwise
  * throwing an exception. This method is useful when validating according
  * to an arbitrary boolean expression, such as validating a
  * primitive number or using your own custom validation expression.</p>
  *
  * <pre>
  * Validate.validState(field > 0);
  * Validate.validState(this.isOk());</pre>
  *
  * <p>The message of the exception is &quot;The validated state is
  * false&quot;.</p>
  *
  * [expression] the boolean expression to check
  * Throws [IllegalStateException] if expression is [false]
  */
  static void validState(bool expression,
      [String message = DEFAULT_VALID_STATE_EX_MESSAGE]) {
    if (expression == false) {
      throw new IllegalStateError(message);
    }
  }

  // matchesPattern
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument character sequence matches the specified regular
  * expression pattern; otherwise throwing an exception.</p>
  *
  * <pre>Validate.matchesPattern("hi", new RegExp("^test\$"));</pre>
  *
  * <p>The syntax of the pattern is the one used in the {@link RegExp} class.</p>
  *
  * [input] the character sequence to validate, not null
  * [pattern] the regular expression pattern, not null
  * Throws [ArgumentError] if the character sequence does not match the pattern
  */
  static void matchesPattern(String input, RegExp pattern,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    if (pattern.hasMatch(input) == false) {
      throw new ArgumentError(message);
    }
  }

  static void isEmail(String input,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    matchesPattern(input, new RegExp(PATTERN_EMAIL), message);
  }

  static void isPassword(String input,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    matchesPattern(input, new RegExp(PATTERN_PW), message);
  }

  static void isAlphaNumeric(String input,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    matchesPattern(input, new RegExp(PATTERN_ALPHANUMERIC), message);
  }

  static void isHex(String input,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    matchesPattern(input, new RegExp(PATTERN_HEX), message);
  }

  static void isUUID(String input,
      [String message = DEFAULT_MATCHES_PATTERN_EX]) {
    matchesPattern(input, new RegExp(PATTERN_UUID), message);
  }

  // inclusiveBetween
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument object fall between the two
  * inclusive values specified; otherwise, throws an exception.</p>
  *
  * <pre>Validate.inclusiveBetween(0, 2, 1);</pre>
  *
  * [start] the inclusive start value, not null
  * [end] the inclusive end value, not null
  * [value] the object to validate, not null
  * Throws [ArgumentError] if the value falls out of the boundaries
  */
  static void inclusiveBetween(
      Comparable start, Comparable end, Comparable value,
      [String message = DEFAULT_INCLUSIVE_BETWEEN_EX_MESSAGE]) {
    if (value.compareTo(start) < 0 || value.compareTo(end) > 0) {
      throw new ArgumentError(message);
    }
  }

  // exclusiveBetween
  //---------------------------------------------------------------------------------

  /*
  * <p>Validate that the specified argument object fall between the two
  * exclusive values specified; otherwise, throws an exception.</p>
  *
  * <pre>Validate.inclusiveBetween(0, 2, 1);</pre>
  *
  * [start] the exclusive start value, not null
  * [end] the exclusive end value, not null
  * [value] the object to validate, not null
  * Throws [ArgumentError] if the value falls out of the boundaries
  */
  static void exclusiveBetween(
      Comparable start, Comparable end, Comparable value,
      [String message = DEFAULT_EXCLUSIVE_BETWEEN_EX_MESSAGE]) {
    if (value.compareTo(start) <= 0 || value.compareTo(end) >= 0) {
      throw new ArgumentError(message);
    }
  }

  // json Object
  //---------------------------------------------------------------------------------
  /*
  * <p>Validate that the specified value ist either a num, String, bool, Map or List.
  * If the first check fails isJson checks if the value has a toJson() function - if so, the value is also valid
  * </p>
  *
  * [value] the value to validate, not null
  * Throws [ArgumentError] if the value falls out of the boundaries
  */
  static void isJson(final dynamic value,
      [String message = DEFAULT_JSON_MESSAGE]) {
    Validate.notNull(value, message);
    if (!((value is num) ||
        (value is String) ||
        (value is bool) ||
        (value is List) ||
        (value is Map))) {
      try {
        value.toJson();
      } on NoSuchMethodError {
        throw new ArgumentError(message);
      }
    }
  }

  // Key in Map
  //---------------------------------------------------------------------------------
  /*
  * <p>Validate that the specified key is in the map and if so the value is not null.
  * If %key% is found in [message] it will be replaced with [key].toString() </p>
  *
  * [key] the key to validate, [map] to validate, must not be null
  * Throws [ArgumentError] if the key is not found in the map or if the value found is null.
  */
  static void isKeyInMap(final dynamic key, final Map map,
      [String message = DEFAULT_KEY_IN_MAP_MESSAGE]) {
    Validate.notNull(map, message);
    if (!map.containsKey(key) || map[key] == null) {
      throw new ArgumentError(message
          .replaceFirst("%key%", key.toString())
          .replaceFirst("%structure%", _PRETTYJSON.convert(map)));
    }
  }

  // isInstanceOf
  //---------------------------------------------------------------------------------

  /*
  * Validate that the argument is an instance of the specified class; otherwise
  * throwing an exception. This method is useful when validating according to an arbitrary
  * class
  *
  * Sample:
  *    Validate.isInstance(new instanceCheck<String>(),"Test");
  *    Validate.isInstance(new instanceCheck<String>(),myParam);
  *    Validate.isInstance(new instanceCheck<List<String>>(strict: false),new List())
  */
  static void isInstance(final InstanceCheck instanceCheck, var obj,
      [String message = DEFAULT_IS_INSTANCE_OF_EX_MESSAGE]) {
    Validate.notNull(instanceCheck);

    if (!instanceCheck.check(obj)) {
      final String wish = instanceCheck.type;
      final String truth = (obj != null ? obj.runtimeType.toString() : 'null');
      throw new ArgumentError(
          message.replaceAll('%wish%', wish).replaceAll('%truth%', truth));
    }
  }
}
