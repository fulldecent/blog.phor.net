---
title: "Why does e^(pi*i) = -1?"
tags:
  - math
old-link: https://fulldecent.blogspot.com/2010/07/why-does-epii-1.html
---

This cannot be stressed enough:

> The thing you always have to consider when extending previously-developed concepts to complex numbers is what definition of the existing concept you're using, because you can't just assume that all of the definitions will give the same extension. (In fact, you get all sorts of weird stuff like different branch cuts if you're not careful. But e^z turns out to be well-behaved.)
>
> One good definition of e^x is that de^x/dx=e^x and e^0=1. That is, it's the function whose derivative is itself and whose value at 0 is 1. From the chain rule, we can see that de^ix/dx=ie^ix. That is, e^ix is the function such whose derivative is i times the function, and e^i0=e^0=1. For any complex value, iz is that value rotated 90 degrees around the origin. So what we've got so far is that e^ix starts at 1, and its derivative at any point is at right angles to the line from the origin, and the magnitude of its derivative is equal to its distance from the origin.
>
> The bit about the derivates is exactly the right thing to make a circle (look up the velocity of something in orbit). This means that it will keep the same magnitude all the time, so it's the unit circle. And it's velocity is 1, which means that it'll go all the way around when x is the circumference of the circle, which is 2 pi. So at pi, it's gone halfway around, and e^i pi = -1.
>
> - Source: Labervon <a href="https://forums.xkcd.com/viewtopic.php?f=7&amp;t=528">https://forums.xkcd.com/viewtopic.php?f=7&amp;t=528</a>
