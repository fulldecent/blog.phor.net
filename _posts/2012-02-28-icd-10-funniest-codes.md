---
title: "The funniest and best ICD-10 codes"
tags:
  - politics
  - youhearditherefirst
old-link: https://fulldecent.blogspot.com/2012/02/new-medical-bill-theres-code-for-that.html
comments:
  - link: https://fulldecent.blogspot.com/2012/02/new-medical-bill-theres-code-for-that.html#comment-934452679068704226
    name: Anonymous
    text: "0HHX31Z Insertion of Radioactive Element into Left Nipple, Percutaneous Approach"
  - link: https://fulldecent.blogspot.com/2012/02/new-medical-bill-theres-code-for-that.html#comment-6928875771092177744
    name: Anonymous
    text: "Patient dead on arrival. Medical diagnosis... F40243 Fear of flying"
---

Situation: You've been involved in a water-skiing accident where your skis have caught fire and now you are being rushed to the emergency room.

![Water skiing accident](/assets/images/2012-02-28-icd-10-funniest-codes.webp)

The good news: There a code for that. ICD-10-CM ("we have to pass the bill so that you can find out what is in it") has anticipated this and your hospital will have no problem billing insurance for your treatment.

The bad news: You'll be delayed while the medical administrator chooses between the 6 different codes for this exact situation.

Records: Here are some actual medical diagnosis codes. In fact some of these would be newspaper headlines if they ever happened:

- `Z3754` Sextuplets, all liveborn
- `W5922xS` Struck by turtle, sequela
- `Z62891` Sibling rivalry
- `Z631` Problems in relationship with in-laws
- `V9107xD` Burn due to water-skis on fire, subsequent encounter
- `T505x6A` Underdosing of appetite depressants, initial encounter
- `V616xxD` Passenger in heavy transport vehicle injured in collision with pedal cycle in traffic accident, subsequent encounter
- `V9733xD` Sucked into jet engine, subsequent encounter
- `T63442S` Toxic effect of venom of bees, intentional self-harm, sequela
- `Z621` Parental overprotection

Search the full list of codes below and post the comment if you think this is funny or find another good one!

See the [complete list of ICD-10 codes](https://phor.net/fun/icd-10-all-codes.tsv).

## Random ICD-10 codes

<div class="container">
  <input class="form-control" id="query" placeholder="search...">
  <table class="table" id="results"></table>
</div>

<script>
let icd10Data = null;
fetch('https://phor.net/fun/icd-10-all-codes.tsv')
  .then(response => response.text())
  .then(data => {
    icd10Data = data.split(/\r?\n/).filter(Boolean);
    update();
  })

function update() {
  const query = document.getElementById('query').value.toUpperCase();
  let results = 0;
  let html = '';
  // Shuffle search
  for (let i = icd10Data.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [icd10Data[i], icd10Data[j]] = [icd10Data[j], icd10Data[i]];
    if (icd10Data[i].toUpperCase().includes(query)) {
      const [code, description] = icd10Data[i].split(/\t/);
      html += `<tr><td>${code}</td><td>${description}</td></tr>`;
      if (++results >= 20) {
        html += `<tr><td colspan="2">Showing ${results} results, search for more...</td></tr>`;
        break;
      }
    }
  }
  document.getElementById('results').innerHTML = html;
}

document.getElementById('query').addEventListener('input', () => update());
</script>
