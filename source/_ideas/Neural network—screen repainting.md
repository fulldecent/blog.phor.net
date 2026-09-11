Every time I resize my browser, it is sadness and lag. Let's look at this from a technical perspective and see what new solutions are available in 2025.

THE CUSTOMER EXPECTATION

When you view a web page, if you want to resize it, you drag this corner. And while you drag it, you expect:

1. It updates frequently (>15 FPS)
2. The correct content is shown (not filler pixels)
3. When the pixels are shown it is near where your cursor actually is on the screen (not laggy)

CURRENT TECHNICAL APPROACH

Most things you use on a computer are driven by HTML. Many "native apps" on your computer use HTML underneath.

Every pixel in every app is rendered each frame by a web browser (e.g. Chrome) or an operating system built-in web rendering surface (e.g. WebKit, shout out to KDE)—but one exception is video, where the operating system offers a higher-order pipeline to render pixels.

CURRENT STATE OF THE ART

Less than 10 frames per second. The painting is at least several frames behind your pointer.

If using large Google Docs, expect 0.2 frames per second or worse!

This entire process is limited by the raw performance of your computer. If you had more RAM or processor speed or wanted to sip more energy, you would get more FPS.

A NEW EXPECTATION

Let's look at this again one more time a different way.

When you resize the browser, it is showing you new pixels. But actually what it shows you is not a big surprise. If you used Photoshop and had an existing screenshot, you could guess what any other size would look like. A good artist could make passable fakes.

And if you had three screenshots of resizing a window at a constant speed (or cubic curve) a computer could calculate the third screenshot.

A NEW APPROACH

There is a completely different way to resize windows. Rather than ask the running program to paint pixels at 15+ FPS (or really 60 FPS) you don't need to ask it anything.

You infer the pixels!

A visual neuron-based program running locally at 60 FPS can (mostly) guess what any web page will look like when you start to resize it.

If this is run at the operating system level in the compositor with no changes to the existing API, it will not know what text is "just below" what you are reading now. But it can know about text reflow, how the background moves independently from the foreground and 90%+ of what is painting on the screen.

And of course if you run this neuron-based program inside the browser it can know about text that is currently off screen.

👉 The browser can vibepaint the page on the screen without actually rendering it.

HOW TO GET THERE

Building this (in OS or in browser) will require a large corpus of screenshots:

1. A web page rendered at some size, r(p, s)
2. That page at a similar size, r(p, s + v⃗)
3. That page at third size in a similar trajectory, r(p, s + T(v⃗))

For browsers, this corpus can be generated automatically.

Then train a one-input visual model (screenshot, size) + (new size) -> (new screenshot)

And an interpolation model (screenshot, size) + (other screenshot, other size) + (new size) -> (third screenshot)

Because web browsers house so many applications, this data set is probably sufficient to generalize across all visual experience on a computer.

END RESULT

Buttery smooth, mostly correct pixels on your screen with less energy usage.
