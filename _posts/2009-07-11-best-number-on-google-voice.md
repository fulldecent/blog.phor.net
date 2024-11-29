---
title: "The best number on Google Voice"
tags: 
  - youhearditherefirst	
old-link: https://fulldecent.blogspot.com/2009/07/best-number-on-google-voice.html
comments:
  - link: https://fulldecent.blogspot.com/2009/07/best-number-on-google-voice.html#comment-8920784486157531034
    name: William Entriken
    text: "More notes: https://privacylog.blogspot.com/2009/08/full-google-hack.html"
---

I got a Google Voice invite today and had to choose which number I want. Of course all the repeated digits are gone (215-777-7772, ...) are gone. Google provides a simple interface to find a good number, but this is the interface I like, `grep`:

![Grepping through Google Voice numbers](assets/images/2009-07-11-best-number-on-google-voice.png)

## So I did the following (Mac 10.5 / Safari):

1. [Download all available Google Voice phone numbers](full-google-voice-hack) for a given area code.

2. Normalize the data:

    ```bash
    grep -ho +1484....... *js | sort -u | cut -c 3- > numbers
    ```

3. Grep through to find the best numbers available (some example results shown):

    ```bash
    # repetition
    grep "\([0-9]\{4\}\).*\1" numbers
    >> 4843248432

    # pairs
    grep "\([0-9]\)\1.*\([0-9]\)\2.*\([0-9]\)\3" numbers
    >> 4842220022
    >> 4842220044

    # repetition
    grep '\([0-9]\)\1\{3\}' numbers
    >> 4849388886

    # only 3 digits (mostly)
    grep '^[483]\+.$' numbers
    >> 4843344881

    # palindromes
    grep "\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\).?\4\3\2\1" numbers
    >> 4846399364
    >> 4842020248

    # toggle
    grep "\([0-9]\)\([0-9]\)\1\2\1\2" numbers
    >> 4842020204

    grep "484\([0-9]\)\([0-9]\)\1\2" numbers
    >> xxx

    # only two digits (except area code)
    grep "484\([0-9]\)\1\*\([0-9]\)\(\1\|\2\)\{5\}" numbers
    >> 4842020002
    >> 4842020020
    >> 4842020022
    >> 4842020220
    >> 4842220002
    >> 4842220020
    >> 4842220022
    >> 4842220202
    >> 4842220220

    # more toggle
    grep "\([0-9]\)\([0-9]\)\1\2.*\([0-9]\)\([0-9]\)\3\4\3" numbers
    >> 4848580808

    # the best
    grep "\([0-9]\)\([0-9]\)\1\2\1.*\([0-9]\)\([0-9]\)\3\4\3" numbers
    ABABACDCDC
    ```
    
This is my new number. All the others are up for grabs.

Thanks for help from Chris Nolan who provided expeditious python scripting in support of this effort.