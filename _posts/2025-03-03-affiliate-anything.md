---
title: Affiliate link anything
tags: ["my-life"]
comments: []
affiliate-link: true
---

Paste any product link here to turn it into an affiliate link that pays me a commission.

<input id="affiliate-link" type="text" style="width: 100%; height: 3em; font-size: 1.5em;" placeholder="Paste a product link here">

{: #affiliate-link-results}
(After you paste a link above, the affiliate link will appear here.)

<script>
document.getElementById("affiliate-link").addEventListener("input", function() {
    const inputUrl = document.getElementById("affiliate-link").value.trim();
    const resultsElement = document.getElementById("affiliate-link-results");

    // Clear results if input is empty
    if (!inputUrl) {
        resultsElement.innerHTML = "";
        return;
    }

    // Try to parse the input as a valid URL
    let url;
    try {
        url = new URL(inputUrl);
    } catch (e) {
        resultsElement.innerHTML = "<span style='color: red;'>Invalid URL format. Please enter a valid Amazon link.</span>";
        return;
    }

    // Check if it's an Amazon domain
    const amazonDomains = /\.(com|co\.uk|ca|de|fr|it|es|in|jp)$/i;
    if (!url.hostname.match(/^(www\.)?amazon\./i) || !url.hostname.match(amazonDomains)) {
        resultsElement.innerHTML = "<span style='color: red;'>Not an Amazon link. Please provide a valid Amazon URL.</span>";
        return;
    }

    // Extract ASIN for product pages
    const asinRegex = /\/(?:dp|gp\/product)\/([A-Z0-9]{10})(?:[\/?#]|$)/i;
    const asinMatch = inputUrl.match(asinRegex);

    if (asinMatch) {
        const asin = asinMatch[1];
        const affiliateLink = `https://www.amazon.com/gp/product/${asin}?tag=phor-20`;
        resultsElement.innerHTML = `<a href="${affiliateLink}" target="_blank">${affiliateLink}</a>`;
    } else {
        // Handle non-product pages (e.g., category, search, deals)
        const isAmazonPage = url.pathname.match(/^(\/(?:s|b|deal|g|top-rated|best-sellers)\/?)/i);
        if (isAmazonPage || url.search) { // Search or category pages often have query params
            const affiliateLink = `${inputUrl}${inputUrl.includes("?") ? "&" : "?"}tag=phor-20`;
            resultsElement.innerHTML = `<a href="${affiliateLink}" target="_blank">${affiliateLink}</a>`;
        } else {
            resultsElement.innerHTML = "<span style='color: red;'>Could not generate affiliate link. Ensure it’s a valid Amazon product or page.</span>";
        }
    }
});
</script>
