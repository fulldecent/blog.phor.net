---
title: "How to give government records both immutability and a right to be forgotten (lessons from Estonia's CTO)"
---

DRAFT: SEE EMAIL THREAD <https://mail.google.com/mail/u/0/#inbox/FMfcgzGrcPDrtPzMQXJXZQSfVHmVNxGc>

TODO: FOLLOW UP WITH HIM TO ASK FOR A ONE LINE NOTE AND AN ENDORSEMENT THAT I CAN PUBLISH THIS.

TODO: ADD MERMAID?

During the NFT Tallinn conference in early 2023, I sat down with Kristo Vaher — then Estonia’s Government Chief Technology Officer — and sketched out a practical architecture that lets public records stay forever verifiable while still allowing selective revocation for privacy or national-security reasons. Here’s the complete blueprint we discussed.

## The problem every digital government faces

Estonia has been the world’s leading digital government for two decades. From X-Road and e-Residency to the KSI hash-based blockchain used since 2008, they have shown that it *is* possible to run an entire country on verifiable digital records.

But even Estonia runs into a fundamental tension:

- **Immutability builds trust.** Citizens and businesses need to know that an official document (tax record, business registry extract, COVID test result, land title, etc.) was genuinely issued by the government and hasn’t been altered.
- **The right to be forgotten and national security still matter.** Once a document leaves government systems—printed, emailed or QR-scanned—the government can lose control. How do you revoke authenticity *after* distribution without breaking the entire chain of trust?

Traditional solutions fall short:

- Pure blockchain = permanent and immutable → no revocation possible.
- Central databases with “delete” buttons = easy revocation but zero public verifiability and a fraud risk.
- Classic digital signatures = once the document is out, the signature is forever valid.

We needed something better.

## The dual-path architecture we designed

During our follow-up email discussion in August–September 2023, Kristo and I converged on a clean, incremental design that re-uses Estonia’s existing strengths (strong digital identity, X-Road, KSI) while adding two parallel tracks:

### 1. Public records (permanent & fully verifiable)

1. Government signing server

   A hardened, linear-ledger service that:

   - Accepts authenticated requests from application servers.
   - Signs records with the current daily private key.
   - Publishes the signatures publicly.
   - Periodically anchors a hash of its entire ledger to Bitcoin (or any robust public append-only ledger).

2. Permanent object storage

   S3-compatible buckets (or equivalent) that store the actual documents or their hashes. These become the single source of truth for public data. Future-proofed for advanced query services similar to Pennsylvania’s open data portal.

3. Application servers

   Updated incrementally—one ministry or service at a time—to push new records to the signing + storage layer instead of (or in addition to) their current databases.

4. Offline-first QR codes

   Every public document gets a permanent QR code that links to the object and includes the signature. Validation works completely offline: scan the QR → compare the cryptographic hash and signature against the printed or displayed document. (Exactly how Taiwan and Mexico already do merchant receipts and certified lab results.)

5. Key transparency

   The current list of public verification keys is published on the main government website and, for maximum trust, reprinted annually in the official gazette/newspaper.

Result: Anyone in the world can verify that a document was issued by the Estonian government on a specific date, and the security is anchored against the trillion-euro Bitcoin network (or any other external network).

### 2. Private / deniable records (off-the-record style)

Some records *must* be revocable after issuance—tax details that later become protected, classified intelligence summaries, temporary permits, etc.

For these we use a simple but powerful adaptation of the classic “off-the-record” messaging protocol:

- Still use the same daily signing server.
- **Do not** publish the documents to permanent public storage. They remain distributed only by the issuing application.
- **Daily key rotation + publication**: The government publishes the *previous day’s private key* every day on its official website.
- Once a "private key" is published, *any* document signed with that key becomes indistinguishable from a forgery. The government can no longer cryptographically claim authorship.

This gives the recipient a short window (usually set to 24 hours) during which they can be 100% sure the document is authentic. After that, the record is deniable by design—exactly what you want for sensitive data.















### Why This Solves the Regeneration/Fraud Problem

Kristo immediately zeroed in on the key question: “How do we prevent someone from fraudulently regenerating the entire chain?”

The answer is the Bitcoin (or equivalent) anchor:

- Every day (or every hour) the signing server publishes a single hash of *all* prior signatures to Bitcoin.
- Regenerating a convincing fake ledger would require rewriting Bitcoin history — an attack that currently costs tens or hundreds of billions of dollars and would be instantly noticed by the global network.

This is the same reason KSI has been so successful in Estonia: you get enterprise-scale immutability by piggy-backing on the most secure public ledger in existence.

### Kristo’s Feedback (Direct from Our Emails)

Kristo was deeply engaged and pushed the design in exactly the right places:

> “This means that by publishing Tuesday’s keys, government essentially locks any and every document it signed by that point with those keys… Every document needs to be stamped and its fingerprint stored on blockchain?”

> “I am trying to figure out why would there be a need to publishing keys anyway… immutability of documents… no private data on blockchain… validity of documents… inability to easily re-generate the whole blockchain to prevent fraud… ability to check document validity offline…”

He also forwarded the entire thread to his personal inbox with the note:

> “I’ll be digesting over this a little bit and get back to you again — I’m very interested in figuring out the ‘TO BE’ type of architecture for this especially as I’m interested in having it as one of the cornerstones for architecture blueprint for the digital states of the future.”

### Where We Are Today

The conversation happened in 2023. Kristo has since moved on from the CTO role, but the ideas remain as relevant as ever. Estonia continues to refine its digital agenda, and many other countries are watching closely.

This architecture is deliberately incremental:

- Start with one high-visibility public service (e.g. business registry or property titles).
- Add the signing server and Bitcoin anchoring.
- Roll out QR best practices.
- Later extend to deniable records for sensitive ministries.

No massive forklift upgrade required.

### Let’s Build It

If you work in government digital transformation, run a govtech startup, or are simply fascinated by the future of verifiable public records, I’d love to hear from you.

I’m happy to:

- Release a full technical paper or proof-of-concept code.
- Collaborate with any Estonian (or other) government team that wants to pilot this.
- Turn the diagrams below into open-source reference architecture.

Drop me a note at X @fulldecent.

The future of the digital state doesn’t have to choose between trust and privacy. We can have both — cryptographically.

---

MORE NOTES

Levels of information assurance

Read Kristo's email thread about this and work in to improve my wording

1. Public document, not timestamped, signed by auth source
   1. SHOW EXAMPLE: ethereum message signatures, a signed PDF document
   2. when scanning the document you can not know when it was signed, or if it was replaced (this requires online check/revocation, or it requires a time-since timestamp (hold up today's newspaper/show today's bitcoin hash) and a policy for how long it should expire) // read the login.xyz spec and their EIP , and tell them about this
   3. This signature can be used in coure and irrefutable evidence // the cost of forking bitcoin is well known and studied

2. Public document, timestamped, signed by authoritative source (competent authority)
   1. You can prove this to somebody offline
   2. Anybody can take a document and publish its hash to bitcoin to prove it existed before a certain date
   3. SHOW EXAMPLE: a data line showing a document signature by a government, and proof that this is on a blockchain timestamped
   4. This signature can be used in coure and irrefutable evidence
3. Unpublished (YouTube calls it "unlisted") document, timestampted, signed by autthoritatve source
   1. Because it is signed, anybody with the document can publish it and then it is undeniable
   2. You can provide this to somebody offline
   3. This signature can be used in coure and irrefutable evidence
4. Online verifiable document
   1. You cannot prove this to somebody offline or prove it to a smart contract
   2. Modern cryptography requires entropy from the skeptic to go to the authority to sign it and return it
   3. You can prove it online -- if there is a network connection, even through third parties
   4. This means that once the skpetic has verified it, they are UNABLE to prove to a different person this verification (becasue the other person does not know it is entropy)
   5. Document can be used in coure ONLY IF the webserver is still online. If the webserver takes the verifying service down then nobody can verify the document was uathentic
5. Unverifiable, trust-based document
   1. ?? IS MOST INFORMATION IN THIS BUCKET BECAUSE OF QUANTUM INSERT AND BECAUSE SYSTEMS ARE NOT VERIFIABLE ??
   2. This information cannot be trusted if it relayed through third parties. This inculdes paper-based (non-digital) documents. If you get this paper directly from a source you can trust the source authorized it to give to you. If that paper comes to you through an intermediary source, you cannot not directly know this is authorized information from the source meant for you. Because the third party could have altered it. (Other kinds of validation may be possible, physical security like wax stamps, code words (shared keys), and hidden marks) these are outside the scope of this paper.

---

A separate concern is pubishing the data on the fact server

---

this means fraudulently regenerating the blockchain would cost

look at forking cost

---

an ✅ reference when a document has been replaced with a new version

see online certificate revocation service and papers about that for SSL certs

---

The only thing you can't do is ❌ you can't scan a document offline and know if it has subsequently been replaced. We can rely on some workarounds here like "when offline, don't trust anything older than X days" or

also see how to synchronize lists of replaced documents (bloom filters) and then when offline don't trust anything signed before the last time your bloom filter was synchronized.

---

---

Hi Kristo,

Yes, we are very close here! You have the right notes and questions.

The government can hash a record and sign it and publish that signature (with or without the hash, ✅ no private data) on its blockchain. Timestamping can validate through Bitcoin and similar networks, once timestamped ✅ it's immutable. By tying to Bitcoin (or similar), this means ✅ fraudulently regenerating the blockchain would cost trillions of Euros. (Yes, you only need to periodically publish a hash of your whole blockchain to e.g. Bitcoin and vice versa.)

In addition, as you say, the fact server (e.g. S3 bucket) can store all government documents. And it can ✅ reference when a document has been replaced with a new version. Printed QR codes can validate against that. This works for public and also for unlisted documents. Anybody can copy the public documents, and if somebody receives some unlisted URLs then they can copy those documents too.

✅ These documents can be validated offline. A similar system powers merchant sales receipts in Taiwan and Mexico ("factivo") where QR codes are printed on every receipt. They built this system knowing we cannot rely on internet access everywhere all the time. I worked with a state government in Mexico to implement this for COVID test results, which needed to be timestamped and validated offline for airport security.

The only thing you can't do is ❌ you can't scan a document offline and know if it has subsequently been replaced. We can rely on some workarounds here like "when offline, don't trust anything older than X days" and there are other tricks. This is a well-studied problem because it affects the security of certificates we use for HTTPS connections which many things depend on.

\---

Once somebody has received a copy of a public or unlisted document, it can forevermore be known as authentic. (Ignoring here whether it was replaced.) If there are some documents where government doesn't want this, then those documents must not go through such a system. The technical word for this is "deniability". That is the only situation where an "off-the-record" or "publishing private keys" system is useful. Sorry for confusing things and talking too much about that part.

---

---

TOPIC FOR CSH Make a demo for Kristo of a fact registry for Estonia

think about it // stuff on page 156

Two systems, one is permanent and one is ephemeral.

The permanent one is only disclosed by court order.

The ephemeral one is disclosed in the normal course of business.

---

Storing a record permanently: hash it, then hash that with a random nonce. Then hash all available records up into a merkle root. Then sign that. Then publish that signed, hashed root on the Bitcoin ledger daily and on the EE website somewhere.

Storing a record ephemerally: hash it sign it, then provide the signed hash (i.e. receipt) to the customer or data recipient. This is done by a “government fact server” which is centrally controlled. This server signs using a signing key, the key is well known and published on site and on blockchain. And at the end of each year (or period), the PRIVATE signing key is also published and a new key is generated. This allows ANYBODY TO FORGE old documents. In other words  old documents cannot be validated. (The same documents can be downloaded again from government in the new year using the new then-available key.)

This is basically the Off-The-Record protocol.

Counter point: if anybody sees a validated ephemeral record. And they publish it to blockchain with the signature, then everybody can know this is an authentic document. (Because everybody knows the private key was only known to government at that time.)

---

Things to build:

A document signer. Demo site.
A public document ledger/publisher. Demo site.
An ephemeral signer. Demo site.

A recommendation for including QR codes on all published documents. That QR code can validate the document, and procude the same document.

EH: A generic api for querying the public document repository using a URI. This allows you to find a newer version of the same document. But even better is to use a permalink. Nah, lame. Out of scape. Or maybe documents in general should just





(Important caveat: If the recipient wants permanent proof, they can themselves timestamp the document on Bitcoin before the key is published. But that’s their choice, not the government’s.)

###
