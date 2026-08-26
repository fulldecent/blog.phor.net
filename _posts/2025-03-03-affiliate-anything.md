---
title: Affiliate link anything
tags: ["my-life"]
comments: []
affiliate-link: true
---

Paste any product link here to turn it into an affiliate link that pays me a commission.

<input id="affiliate-link" type="text" style="width: 100%; height: 3em; font-size: 1.2em;" placeholder="Paste a product link here">

{: #affiliate-link-results}
(After you paste a link above, the affiliate link will appear here.)

To use your own affiliate code, edit the URL of this page.

<script>
const defaultCodes = {"az": "phor-20"};
const params = new URLSearchParams(window.location.search);
const codes = {...defaultCodes, ...Object.fromEntries(params)};

const matchers = new Map([
    [/^(www\.)?amazon\./i, decorateAmazonLink],
]);

const linkInput = document.getElementById("affiliate-link");
const resultsElement = document.getElementById("affiliate-link-results");

function updateUrlCodeParams() {
    const url = new URL(window.location.href);

    for (const codeName of Object.keys(defaultCodes)) {
        url.searchParams.set(codeName, codes[codeName]);
    }

    window.history.replaceState({}, "", url);
}

function decorateAmazonLink(url) {
    const asinMatch = url.pathname.match(/\/(?:dp|gp\/product)\/([A-Z0-9]{10})(?:[\/?#]|$)/i);

    if (asinMatch) {
        const affiliateUrl = new URL(`https://www.amazon.com/gp/product/${asinMatch[1]}`);
        affiliateUrl.searchParams.set("tag", codes.az);
        return affiliateUrl;
    }

    const affiliateUrl = new URL(url);
    affiliateUrl.searchParams.set("tag", codes.az);
    return affiliateUrl;
}

function renderAffiliateLink() {
    const inputUrl = linkInput.value.trim();

    if (!inputUrl) {
        resultsElement.replaceChildren();
        return;
    }

    let url;
    try {
        url = new URL(inputUrl);
    } catch {
        resultsElement.replaceChildren();
        return;
    }

    for (const [matcher, decorateLink] of matchers) {
        if (matcher.test(url.hostname)) {
            url = decorateLink(url);
            break;
        }
    }

    const affiliateLink = document.createElement("a");
    affiliateLink.href = url;
    affiliateLink.target = "_blank";
    affiliateLink.rel = "noopener";
    affiliateLink.textContent = url;
    resultsElement.replaceChildren(affiliateLink);
}

linkInput.addEventListener("input", renderAffiliateLink);

updateUrlCodeParams();
renderAffiliateLink();
</script>
