---
title: "Your salary over the years"
tags:
  - finance
  - youhearditherefirst
old-link: https://fulldecent.blogspot.com/2011/03/your-salary-over-years.html
---

Here is the salary calculator:

<div style="border: 1em solid pink; margin: 1em; padding: 1em;">
You are <input id="age" onkeyup="document.getElementById('X').innerHTML=(Math.pow(document.getElementById('sal').value,1/(document.getElementById('age').value-16))*100-100).toFixed(2)+'%';" size="4/"> years old.<br>
After tax, you earn <input id="sal" onkeyup="document.getElementById('X').innerHTML=(Math.pow(document.getElementById('sal').value,1/(document.getElementById('age').value-16))*100-100).toFixed(2)+'%';" size="4/"> times the minimum wage.<br>
In your career, you have earned an average <strong id="X">6.15%</strong> raise every year.<br>
<br>
<i>The US federal minimum wage is $7.25 per hour effective July 24, 2009</i></div>

The calculator assumes your first job was at minimum wage when you were 16 and you didn't pax taxes.
