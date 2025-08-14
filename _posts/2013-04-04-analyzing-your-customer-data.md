---
title: "Analyzing your customer data"
tags: ["howto"]
old-link: https://fulldecent.blogspot.com/2013/04/analyzing-your-customer-data.html
---

This is the first part in a series about analyzing your customer data.

## Gender

Find the gender of your customer base after the fact. This is straightforward and can be done based on the first name of your customer list. First get a names database, for example [nam_dict.txt.bz2 from PHP](https://svn.php.net/viewvc/pecl/gender/trunk/data/nam_dict.txt.bz2?revision=275820&view=co) then connect the data using Excel or your command line:

```sh
# save your customer first names to ./customernames (lowercase, no writespace)
cat nam_dict | cut -b1-25 | egrep -i '^[a-z ]+$' > nam_dict2
cut -b1-2 nam_dict2 > t1
cat nam_dict | cut -b1-25 | egrep -i '^[a-z ]+$' | cut -b4- | tr '[:upper:]' '[:lower:]' | sed 's/[ \t]*$//' > t2
paste t2 t1 > nam_tsv
join customernames nam_tsv | cut -d' ' -f2 | sort | uniq -c
```

Sample output:

```
5711 F
5624 M
```
