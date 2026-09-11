See als: Solid, local box.md

Manifesto

1. `PRODUCT_NAME` is a customer-vault paradigm.
2. This replaces the client-server paradigm, whereas the customer has full access and visibility to its data, and the vault has none.
3. Customer-vault became possible recently because the physical devices you buy got much more powerful. Your iPhone can recognize faces, run a chatbot, play chess, process voice commands, and classify spam on your device better than most data centers did ten years ago.
   1. Chess: HIARCS 3100 <https://apps.apple.com/us/app/hiarcs-chess/id327708154> vs. Rybka 3100 in year 2017

How does it work?

1. The vault provides a S3-compatible bucket and a MAYBE a simple queue
2. All processing is done by customer (phone / "server" / desktop) which have full access to the data
3. Vault can be subpoenaed/hacked/stolen with zero compromise of customer information
4. Can this model be extended so that a trusted party (friend) can run a server and have SOME access to SOME data to do useful things? such as apple push notifications?

related people: / interested parties

- <https://signal.org/blog/signal-foundation/>
- <https://signalfoundation.org>

Name it: HexBox.io

Posts

- iCloud design
- Signal design
- Ring alternative

About Page

- Why TFF exists?

  > These are designs for products we can make in the future that will help people. The designs are made to empower customers and have a strong user-first, user-agency philosophy.

- Why the name?

  > The current universe of products you can buy today are more and more made to support the sellers of the product in perpetuity. By default, every photo you take with an iPhone is send to Apple for review by law enforcement. Everything you do with any Google product is used to improve Google's machine learning algorithms. People that use Nest give law enforcement and neighbors 24/7 access to see who comes to their home.
  >
  > ^^ show the benefits of these not the risks
  >
  > But at the same time, Apple ..., Google... and even Signal...
  >
  > Overall, a cinic might say that the manufacturers are only making

RELATED

- <https://inrupt.com/solid>
- <https://www.photoworkout.com/best-photo-organizing-software-mac/>

## Design

> When you are using your phone/computer how much of the time is it doing what you want versus it doing what you want?
>
> Are you in an abusive relationship with your phone / computer / tech devices?

When computers were introduced, they were sold as "digital assistants". This metaphore is strained. Yes, computers can find and recommend things for you. But would you hire an assistant if it seems like their primary motivation is to turn each thing you want into a monhtly subscription, prevent you from contacting customer support. (And remove buttons like "don't ask me again" and send feedback, if those buttons aren't directly related to you spending money or providing personal or contact information?)

Instead the metaphore is a communications device connected to a library.
