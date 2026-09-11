---
title: "Integer game notation (IGN)"
tags:
  - technical
  - math
  - coding
old-link: https://phor.net/fun/ign
---

Integer game notation maps every state of a perfect information game into an integer. An example is shown for chess.

## Encode algorithm

Setup:

- Set the game to its opening position
- Set `IGN` = 0, and this represents the opening position
- Set `PRODUCT` = 1

For each move:

1. Before taking the move in the game, count and order possible moves
2. Identify which move, `I`, (from `1` through `NUM_MOVES`) is being taken
3. Take the move in the game
4. `IGN` += `PRODUCT` × `I`, this represents the current position
5. `PRODUCT` ×= `NUM_MOVES`

## Decode algorithm

Setup:

1. Set the game to its opening position
2. `IGN` is given

While `IGN` is greater than zero:

1. Count and order possible moves, `NUM_MOVES`
2. Let `I` = `IGN` % `NUM_MOVES`
3. `IGN` = ⌊`IGN` ÷ `NUM_MOVES`⌋
4. If `I` = 0, take the `NUM_MOVES`th move in the game, else take the `I`th move
5. Take any subsequent forced moves

## Implementation for chess

Moves are expressed as the tuple (origin file, origin rank, destination file, destination file, promotion piece) and ordered alphabetically.

### Example

```
[Event "F/S Return Match"]
[Site "Belgrade, Serbia JUG"]
[Date "1992.11.04"]
[Round "29"]
[White "Fischer, Robert J."]
[Black "Spassky, Boris V."]
[Result "1/2-1/2"]

1.e4 e5 2.Nf3 Nc6 3.Bb5 {This opening is called the Ruy Lopez.} 3...a6
4.Ba4 Nf6 5.O-O Be7 6.Re1 b5 7.Bb3 d6 8.c3 O-O 9.h3 Nb8  10.d4 Nbd7
11.c4 c6 12.cxb5 axb5 13.Nc3 Bb7 14.Bg5 b4 15.Nb1 h6 16.Bh4 c5 17.dxe5
Nxe4 18.Bxe7 Qxe7 19.exd6 Qf6 20.Nbd2 Nxd6 21.Nc4 Nxc4 22.Bxc4 Nb6
23.Ne5 Rae8 24.Bxf7+ Rxf7 25.Nxf7 Rxe1+ 26.Qxe1 Kxf7 27.Qe3 Qg5 28.Qxg5
hxg5 29.b3 Ke6 30.a3 Kd6 31.axb4 cxb4 32.Ra5 Nd5 33.f3 Bc8 34.Kf2 Bf5
35.Ra7 g6 36.Ra6+ Kc5 37.Ke1 Nf4 38.g3 Nxh3 39.Kd2 Kb5 40.Rd6 Kc5 41.Ra6
Nf2 42.g4 Bd3 43.Re6 1/2-1/2
```

> Result: 7194381939026059815816432728404500838835011451049668943765896734611284670867176530570061223664286778997380554654077775346194 (412 bits)

```
1.f3 e5 2.g4 Qh4#
```

> Result: 143395 (18 bits)

### Benefits

- Generic algorithm applies to any perfect information, finite/discrete game
- Easy database search with the mod operator, e.g. find all games that open with 1. f3 e5 by searching for entries with IGN % 400 = 195

### Caveats

- IGN does not distinguish a game that stops before a forced move versus after. If this is important to you, you would add "resign" as a valid move for every step. (Unforced game endings are always distinguishable.)
- This algorithm maintains the entire game path, so two games that reach an identical state, (e.g. `1. e4 e5 2. d4 d5` and `1. d4 d5 2. e4 e5`) are encoded differently.

## Discussion

I [posted this to rec.games.chess.computer](https://groups.google.com/g/rec.games.chess.computer/c/ejnKSqoI8lg) in May 2008 and got a reply from David Richerby questioning whether the encoding is unique. The encode/decode algorithms shown here use a product-based mixed-radix system that does produce a unique integer for each game sequence.
