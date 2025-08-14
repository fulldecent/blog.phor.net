---
title: "Storing arbitrary-length data in a Merkle tree"
tags: ["math", "blockchain"]
old-link: https://fulldecent.blogspot.com/2018/11/storing-arbitrary-length-data-in-merkle.html
---

A hash tree, or a Merkle tree, is a data structure that allows you to take a lot of information and summarize it together in such a way that you (the "prover") can succinctly prove to somebody else (the "skeptic") that certain data is included.

## Background

Here is a typical Merkle-tree implementation:

![Tree](/assets/images/2018-11-15-merkle-tree-arbitrary-length-data.webp)

Arrows represent inclusion in a hash. For example, `A = hash(B, C)`. And `hash()` customarily uses SHA-256.

You will publish root node, the *hash root*. And this is proof to the world that this entire tree (including facts F1, F2, F3, F4) is encoded in A. This rests on the worldwide assumption that hashes don't collide. If somebody is interested to confirm that F3 is included in A then you must share with them F4 and B so that they can recalculate A and confirm it matches the A you published.

Here is how that proof looks:

![Tree proof](/assets/images/2018-11-15-merkle-tree-arbitrary-length-data-2.webp)

## A simple proof

This easily handles the problem when the skeptic is only concerned that a fact they care about (F3) is included in the published root A. This works really well for Bitcoin or other cryptocurrencies because if a certain transaction deals with your money you just want to worry about that transaction and you don't care about other stuff.

In the naive implementation, the hash is `hash(B, C)` is `SHA256(CONCATENATE(B, C))`. The prover will require to explain the tree structure to the skeptic so that they can confirm the Merkle proof. Specifically, they will need to transmit [F3, addToRight, F4, addToLeft, B]. Then skeptic can confirm `A == hash(B, hash(F3, F4))`. Or more generally, the prover would transmit [F3, F4, B] and then explain that F3, is the sixth item in a three-deep binary tree structure. Actually, "three-deep" is redundant because three items are transmitted in the proof. Knowing this is the sixth position allows the skeptic to infer the entire tree structure and know that F4 will be hashed on the right and B will be hashed on the left.

## A more clever implementation

Rather than transmitting the position, you can instead specify that `hash(X, Y) = X &lt; Y ? hash(X || Y) : hash(Y || X)`. This makes it necessary only for the prover to transmit `[F3, F4, B]` and the skeptic will recover `A`.

This clever implementation is the most commonly used.

## Storing ordered data

Let us now increase the application requirements. Previously the skeptic wanted to know that their Bitcoin transaction was included in a set of transactions. Now let's consider an application where the order matters. Maybe in Bitcoin, you need to confirm that one transaction happened before another. You need to make sure money came in before you spent it. (Otherwise your spend would fizzle.) It is insufficient for the prover to tell you the `MONEY_IN` and `MONEY_OUT` transactions are both included in a block, you need to know unequivocally the position of each. And you need to know that everybody else sees them in the same order as well.

Well, the naive case handles this perfectly well. And you need to transmit the fact order as explained above.

## Data leak

In all the applications above, when the prover transmits a proof to the skeptic there is an element of data which is leaked. **Do you see what it is?**

It is the total length of the array! Let us consider an application where it is unacceptable that the total length of the array be known. Maybe you will make a list of every romantic relationship you ever had (sorted best first) and encode it into a Merkle tree and publish it to the blockchain. Then your significant other wants to confirm they are on the list (and hopefully near the top!) Following the protocol, you tell them "yes, you are number one" and provide the following proof to them `[THEIR_NAME, 3C02297C9B9A, BEAE103BD5A0, 2674F00FDED7, 74BC4237455E, 382295A819FA, 1413F07A107B]`. Your significant other is rightfully impressed that you have listed them as number one, a fact that cannot be disputed according the hashing conventions. But later that day they come back to you asking... so why did you need a level-7 tree to hash that data? You have just exposed that fact that you have had between 65 and 128 relations (2^6+1 ... 2^7).</div>

## Encoding arbitrary-length ordered data

Following is an approach to store arbitrary-length ordered data into a Merkle tree in a way that does not expose the full length of the tree.

![Arbitrary length tree](/assets/images/2018-11-15-merkle-tree-arbitrary-length-data-3.webp)

In this encoding scheme, there are several roots, starting with root0. Each successive root goes on the right and each subtree goes on the left. The first subtree is a single element. Trees increase one level each time. The facts are stored in the subtrees leaves.

This additional privacy increases the length of the proofs, the length is up to double. For the naive binary tree, each proof has length CEIL(LOG2(N)) where N is the number of facts. This proposed encoding has a proof length of 2×CEIL(LOG2(I)) where I is the index of the desired fact and the first fact is index 1.

The prover only needs to provide the skeptic with the index number and the number of expected hashes. The skeptic has a unique interpretation using this scheme to know whether to hash from the left or the right.

What data do you put into Root3 and the unused fact spaces? You put random data. The skeptic does not know whether it is random data or if it encodes a larger subtree.

## Bonus: note about brute force attack

In the scenarios above, if the facts represent actual usable data then your application may require you to keep that data secret. For example, at the top, providing F4 may be unacceptable if F4 should be a private fact. The way you handle this is to add a random nonce for every fact in the tree. The nonces are different for each fact. This adds one to the length of all proofs.

![Random nonces](/assets/images/2018-11-15-merkle-tree-arbitrary-length-data-4.webp)

When you use this approach, disclosing F4 does not reveal the fact because the nonce is not known to the skeptic. If your nonce is predictable then a brute force attack can be done against Fact1 to corroborate F1.

## Bonus: batch proofs

Regardless of your encoding scheme you will need to provide many nonces to prove an entire tree. Consider using a cryptographically secure pattern for your nonces. For example you may set your nonces as hash(SECRET || i) where i is the fact number. By convention, the nonce for an unused root (root3 above) will be hash(SECRET || -1).</div>

If you wish, then you could provide all the data and the SECRET to a skeptic. This is the most succinct proof possible for a Merkle tree which uses nonces. Using this convention, the skeptic can validate the entire tree with just that information.

Bonus bonus. If you are working on a Merkle tree that encodes a Merkle tree then don't use the same nonce. If you do, exposing a subtree will expose the main tree. Instead you need to study recursive directory initialization vectors. Go read the source code for encfs, an encrypted filesystem project.

Also big ups to mermaid.js, this is the tool used for the graphics above.
