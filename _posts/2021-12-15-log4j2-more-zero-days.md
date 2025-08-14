---
title: "Log4j2 more zero days"
tags: 
  - security
  - zero-day	
old-link: https://privacylog.blogspot.com/2021/12/log4j2-more-zero-days.html
---

The log4j2 API is underspecified and still vulnerable to undefined behavior. Affects all versions up to and including the current 2.16.0.

This quick PR fixes the documentation from its current state of DANGEROUS into the better CORRECT, BUT ANNOYING WITH CAPITAL LETTERS.

## The problem

*I have also discussed this at <https://github.com/apache/logging-log4cxx> because every implementation is vulnerable and so they should all have defect reports opened on them. And they should all be blocking on this issue (PR) here.*

In the API specification, i.e. `Logger.java`, function documentations include the word “message”.

Each time it is unspecified whether that means:

- A “message” (definition in plain English is “some words”)
- A “Message” (an object of the class defined in `Message.java`, which can have dangerous side-effects)
- A string that is interpreted magically using some functionality in an unspecified interpolating function (which can have dangerous side-effects)

Of course because of CVE-2021-44228 we all know that this undefined behavior can and has led to dire consequences. And this confusion has still not been fixed.

## Proposed solution

### Rename the “Message” class to “InterpretedMessage”

The current class named `Message` *still* includes dangerous functionality including allowing interpolation. That means inputs still need to be sanitized. (There are other vulnerabilities here, less than shell access, which are out of scope for this PR.)

Therefore the name `Message` is inappropriate, in the same way that naming a machine gun as “Cuddly Cat” is irresponsible.

This should be renamed to `InterpretedMessage`. This better indicates that the content may be interpreted. And a reasonable programmer at the Balmer Peak will recognize that using `InterpretedMessage` might require sanitizing the inputs.

To maintain backwards compatibility in the version 2 release series, the existing `Message` class can be a deprecated alias for the new `InterpretedMessage`.

### Remove all usage of the lowercase, unqualified word “message” from parameter names and documentation

As per above, the word “message” is dangerously confusing. And for the kinds of people that don’t recognize the difference between a lower case “message” and a title case “Message” as referring to two totally different things, we can help them by using better words.

Instead, how about:

```java
@param text the content to be directly logged, without interpretation
```

and

```java
@param interpretedText the content to be interpreted via {@code InterpretedMessage} and logged
```

### Do not refer to `InterpretedMessage` as a “string”

Currently, function documentation in `Logger.java` refers to the `Message` object: “the message string to be logged”. This is a dangerous way to refer to the `Message` object.

A `Message` object is not a `String`, nor a string.

Instead, use refer to an `InterpretedMessage` only using “InterpretedMessage”.

### Specify which inputs are interpreted or not

Currently, the `Logger.java` specification includes these API signatures for the `debug(...)` functions. This list is exhaustive except for duplicative functions where the first parameter is `Marker marker` or where the trailing parameters are `Object p###` or where the trailing parameter is `Throwable t`:

```java
void debug(CharSequence message);
void debug(Message msg);
void debug(MessageSupplier msgSupplier);
void debug(Object message);
void debug(String message, Object... params);
void debug(String message, Supplier<?>... paramSuppliers);
void debug(String message);
void debug(Supplier<?> msgSupplier);
```

In all the functions, only one of them, with documentation read by a VERY attentive and skilled programmer, is specified whether the input is interpreted or not. Can you figure out which one? I won’t tell you.

Now just for one example, let’s look specifically at the `CharSequence` variant documentation:

```java
/**
* Logs a message CharSequence with the {@link Level#ERROR ERROR} level.
*
* @param marker the marker data specific to this log statement.
* @param message the message CharSequence to log.
*/
void error(Marker marker, CharSequence message);
```

There can be no definitive reading of this specification as to whether the `CharSequence` will be logged as-is, or whether it may be interpreted. This ambiguity is dangerous.

## Severity

William Entriken / [https://phor.net](https://phor.net/) / 2021-12-15

It is my opinion that logging is an important part of retrospective analysis of security incidents. And therefore any underspecified behavior in a logging library (including the above) which is vulnerable to threat actor manipulation is automatically a high-impact vulnerability.

## Timeline

- 2021-12-15 full disclosure publicly at <https://github.com/apache/logging-log4j2/pull/630>
