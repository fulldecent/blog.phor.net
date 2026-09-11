Run https://github.com/signalapp/ContactDiscoveryService

https://github.com/signalapp/ContactDiscoveryService-Icelake/issues

---

1. Configure server with several registered accounts
2. Client queries one of those clients
3. Rerun steps 1 and 2 by using a binary search of registered accounts
4. Now the server knows which contacts the client is querying

---

This attack depends on Signal being able to take an incoming client request and repeat it multiple times while changing the host on-disk state. (This is defeated if client connection to Secure Enclave is "online" and somehow incorporates randomness, and multiple interrations, to confirm no replay is happening.)

If this assumption is true then Signal could change the registered accounst list to contain one entry. Let's assume the client has two entries for this example (Signal wouldn't know that but bear with me).  It then repeats the client request by having the registered account list entry to be high, then low, and then use bisection to find some middle value.

Because lookup is done with a O(n log(m)) algorithm, this means each lookup against the client list will use one or two memory accesses. The bisection will allow to find with global account list entry entry switches between one or two accesses.

(The keyspace is small, so hashing does not provide any more security, since it can be enumerated. Unless it is salted... by the client? Is the client salting this?)

This can also be defeated if the server will first send a hash of the complete global list, and then the client includes this hash in the request. Then the secure enclave will abort if the global list does not match the hash.





https://signal.org/blog/private-contact-discovery/

---

sucker disclosure

Security@Signal.org // https://www.tenable.com/security/research/tra-2020-33

win disclosure

contact this company https://www.tenable.com/products and ask if they buy vulnerabilities for the publicity of being able to publish first about it