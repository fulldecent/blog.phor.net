---
title: How I audit smart contracts in 2026
---

*How I audit smart contracts: my complete checklist plus a real case study*

I audit smart contracts so you can ship code you trust. This is a repeatable process that catches bugs that matter.

I have used this workflow on real projects since 2019. It produces publishable, billable results. Sharing it here.

This applies to audits, and specifically as part of incident response. That means while you are working, life changing amount of money may be getting stolen and that process continues while you work.

## The workflow I actually use

I follow these steps every time. They keep the audit honest, public, and useful.

STEP ZERO IS GET A LOT OF WATER. This could be a very long night. And put food into your favorite food delivery shopping cart. This is a battle and if you run out of water or calories your work could become ineffective.

1. Engage. Collect:
   1. The exact code to audit
   2. The relevant documentation customers will see
   3. Test cases
   4. Other institutional knowledge that is requied to use or test the product

2. Announce audit to public, if in-scope.
3. Perform audit, see findings list list below.
4. Collate into a report, issues, test cases, or other deliverables as required by client.
5. Publish, if in-scope.

That's it. Stay focused.

## The checklist

### Verify collection and resources

- [ ] Use internet search to confirm all well-known source code/documentation/test cases related to the client and this engagement are actually included in the client-provided scope.

- [ ] Use internet search to identify any claimed leakers/evidence of insider threats at the client that may be relevant to the audit scope.

- [ ] Get and verify personal contact information for all stakeholders and subject matter experts. Confirm that they are available 24/7 and how to bypass silent settings on their phones. (Audit is sometimes a truly ASAP operation, meaning all participants are expected to forgoe sleep.)

- [ ] Document your inputs. E.g.

  > Code was provided privately with SHA-256 hash `afcdaf5ddb03b8a227b66a2a0aef41891754ab81450acec7ced296a437db522a`.

### Suit up

- [ ] Install a virtual machine or unpriviledged remote host to perform your work.

### Reputation review

- [ ] Confirm who wrote the code and how they were paid (check, crypto, etc.).
- [ ] Verify the project website has proper WHOIS and contact details.
- [ ] Review the mission statement of the client organization.
  These may be used in a finding if, for example, the organization claims a certain mission and level of control over the product, but the implementation is inconsistent with that.

### Supply chain audit

- [ ] Ensure the deployed product (if any) matches the provided source code.
- [ ] Identify all dependencies of the code and project.
  - [ ] If code is copy/pasted into the project (e.g. OpenZeppelin Contracts) then identify the specific commit this was pasted from.
  - [ ] This includes tooling versions.
  - [ ] Old versions by themselves may be an audit finding.
- [ ] Identify all known issues and caveats of these supply chain versions.
  For example, Solidity versions before 0.8 did not have integer overflow protection. Before 0.5 had all kinds of craziness.

### Identify any upgrades

- [ ] Mutations in smart contract behavior by proxies ("upgrades") and other mechanisms require the above work to be repeated for each version of the deployed contracts. This also requires a full accounting of how the upgrades happened.

### Identify party risk

- [ ] Find all accounts shown with special permissions against the smart contracts.
- [ ] Identify the beneficial owners of these accounts (if they are DAOs, smart contracts, "multisigs", etc.).
- [ ] Identify account code (EIP-7702) for external accounts.
- [ ] Review if the independence of these accounts violates any marketing claims in the documentation or mission statement of the project.

### Intended code usage

Try use cases using a fork of the target blockchain or your own testing instrumentation.

- [ ] Consider every documentation which explains how you are supposed to use this product. Write these down.
- [ ] Consider every NatSpec comment.
- [ ] Read the code paths and see if at any point there is a violation of any documented (or implied) specifications. These are findings.
- [ ] Consider anywhere you think you would have implemented this "better" or "differently". Make a note of that. Compare if their implementation has different edge cases than yours, write these down.

### Unexpected code usage

- [ ] For each code path you considered above, mark any external calls in red. Cross reference that call versus all possible execution contexts. (M×N)
- [ ] Read every contract entry point. And consider them versus normal operating storage state situations.
- [ ] Consider anywhere you think you would have implemented this "better" or "differently". Make a note of that. Compare if their implementation has different edge cases than yours, write these down.

### Undocumented code

This is only necessary for interactions including contracts where you do not see the source code. You will need to study the assemply. For example OpenSea Shared Storefront contract.

For a case study on that reverse engineering and zerodays found [see here](https://blog.phor.net/opensea-shared-storefront-backdoor#how-do-decompile-and-study-smart-contracts).

- [ ] Disassemble the code.
- [ ] Separate each code unit.
- [ ] Mark in color every potential write operation `SSTORE` `CALL*` .
- [ ] Work backwards to color every code unit that could possibly jump to a colored code unit. Repeat to exhaustion.
- [ ] Delete everything else.
- [ ] Look for telltale signs of Solidity versions.
- [ ] Pay attention to storage locations. And figure it out.

### Automated testing

- [ ] Run existing testing.
- [ ] Add your edge cases as noted above.
- [ ] Do fuzzing by hand. Test out-of-range inputs.
- [ ] Use solhint, slither. Any warning is a finding.
- [ ] Look for duplication, unused variables, wasteful storage layout.

## Change mindsets, last pass

Whatever mindset, level of sleep or chemicals were in your system... do the opposite of that. Those can all lock you into one way of thinking. To think like an adversary you need many ways of thinking.

You may do this by napping, jumping jacks, chemicals.

## Sensitivity and the final report

- [ ] Small findings can combine into big findings. (Old Solidity version + this control structure is not how I would implement it = a broken for loop and complete contract take over.)
- [ ] Structure your findings for your written report.
- [ ] Use basic copyediting techniques.
- [ ] Mark critical issues with 💣 and material issues with ⚠️.  
- [ ] Include recommendations that are immediately actionable.  
- [ ] Add a “best practices” section that cites the sources I actually respect.
- [ ] Ship the report.

Now you're done. Tell your client exactly how to get a hold of you. Tell your partner what is wake-me-up-worthy. Go sleep for 12 hours.

For follow up rounds, you may document which findings the client found as acceptable risks.

## Ready to get your contract audited?

If you want this exact process applied to your project, here is what happens next:

1. You send me the code and the specification.  
2. I run the checklist above.  
3. You receive a report in the same format as the Kred example.  
4. We iterate in public or private, whichever you prefer.

Book a call or just reply to this post with your repo. I answer every serious inquiry.

See [my past audits and zero-day research](https://phor.net/portfolio#smart-contract-audits-zero-day-research-security).
