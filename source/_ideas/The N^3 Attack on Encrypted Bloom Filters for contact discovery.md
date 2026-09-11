How does Signal work?

- OLD BLOG <https://signal.org/blog/contact-discovery/>
- Ask Reddit <https://www.reddit.com/r/signal/comments/k34vdu/how_many_people_use_redphone/>
- CURRENT BLOG ? <https://signal.org/blog/private-contact-discovery/>
- CURRENT REDDIT? <https://github.com/signalapp/ContactDiscoveryService/>

---

How many users?

- <https://www.reddit.com/r/signal/comments/k34vdu/how_many_people_use_redphone/>

---

Is there another service vulnerable to this attack?

- search: <https://www.google.com/search?hl=en&q=wiki%20secure%20contact%20discovery%20%22blinded%20query%22>

- > If anyone develops any insight into a practical privacy-preserving mechanism for achieving this type of contact discovery, or notices something we’ve missed, please let us know here <https://signal.org/blog/contact-discovery/>

- <https://www.reddit.com/r/signal/comments/k34vdu/how_many_people_use_redphone/>

- > bloom filters, encrypted bloom filters, sharded bloom filters, private information retrieval, or private set intersection in order to test my attack.
  - <https://crypto.stackexchange.com/questions/20400/private-information-retrieval-is-it-still-theoretical>

---

Potential publishers / relevant papers

- Swamidass, S. Joshua; [Baldi, Pierre](https://en.wikipedia.org/wiki/Pierre_Baldi) (2007), "Mathematical correction for fingerprint similarity measures to improve chemical retrieval", *Journal of Chemical Information and Modeling*, **47** (3): 952–964, [doi](https://en.wikipedia.org/wiki/Doi_(identifier)):[10.1021/ci600526a](https://doi.org/10.1021%2Fci600526a), [PMID](https://en.wikipedia.org/wiki/PMID_(identifier)) [17444629](https://pubmed.ncbi.nlm.nih.gov/17444629)

---

Signal app Attack bloom filter

## Blinding attack

Do a signature request for the value `1`. The server thinks this is a blinded query. But you can multiply the result to query ANY value.

<https://en.wikipedia.org/wiki/Blind_signature>

## Poisoning attack

Add bits to the bloom filter. This makes it useless.

## Friend of fiend attack (corroborate attack)

(This requires blinding attack)

(This requires the bloom filter stores pairs [contactA, contact B])

You can practically find all a contacts relations by

1. Pick target A
2. Iterate to find all contacts of A (with false positives)
3. Then run a N*N search of found contacts
4. Discard any potential contact if it does not connect with another potential contact

---

# Other Signal attacks

## Repudiation attack

The app should let you edit any message you stored locally (even your record of what the other person said) for deniability
