---
title: "C++ STL set functions… and liquids that can write code"
tags: ["coding"]
comments:
  - link: https://x.com/fulldecent/status/1522343235007438848
    name: '@fulldecent'
    text: The official X thread
  - link: https://fulldecent.blogspot.com/2004/06/are-you-badass-with-c-then-fix-this.html?showComment=1087170900000#c108717092705622985
    name: Tyler
    text: "You were very close to getting the solution.\nFrom the version where you have the ltpairchar struct, change this line:\nset_difference(A.begin(), A.end(), B.begin(), B.end(), ltpairchar, inserter(C, C.begin()) );\nto:\nset_difference(A.begin(), A.end(), B.begin(), B.end(), inserter(C, C.begin()), ltpairchar());\nYou needed the () operator after your struct, and you had the last two arguments out of order."
old-link: https://fulldecent.blogspot.com/2004/06/are-you-badass-with-c-then-fix-this.html
---

Are you badass with C++ STL? Then fix this...

```c++
#include <iostream>
#include <map>
#include <set>
#include <algorithm>
#include <ostream>
#include <iterator>

using namespace std;

int main()
{
  map<const char, int> A;
  A['a'] = 0;
  A['b'] = 5;
  A['c'] = 10;

  map<const char, int> B;
  B['b'] = 105;
  B['c'] = 110;
  B['d'] = 115;

  map<const char, int> C;

  set_difference(A.begin(), A.end(), B.begin(), B.end(), less<char>, inserter(C, C.begin()) );
  /*cout << "Set C (difference of A and B): ";
  copy(C.begin(), C.end(), ostream_iterator<const char*>(cout, " "));
  cout << endl;*/
}
```

> <span style="color:blue">&lt;aeacides&gt;</span> lol<br>
> <span style="color:blue">&lt;aeacides&gt;</span> fulld: you reversed the order of the comparison functor with the insert iterator<br>
> <span style="color:blue">&lt;aeacides&gt;</span> set_difference(A.begin(), A.end(), B.begin(), B.end(), inserter(C, C.begin()), ltpairchar());<br>
> <span style="color:red">&lt;fulld&gt;</span> aeacides: so basically... what you're saying is I need more coffee :-)<br>
> <span style="color:red">&lt;fulld&gt;</span> thanks<br>
> <span style="color:blue">&lt;aeacides&gt;</span> fulld: programmers are essentially machines which transform coffee into code<br>
> <span style="color:red">&lt;fulld&gt;</span> I'm gonna blog that
