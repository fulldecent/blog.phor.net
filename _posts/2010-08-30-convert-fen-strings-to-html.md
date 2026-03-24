---
title: "Convert FEN strings to HTML"
tags:
  - youhearditherefirst
old-link: https://fulldecent.blogspot.com/2010/08/convert-fen-strings-to-html.html
updates:
  - date: 2026-03-23
    changes: Interactive converter now embedded directly in this post
comments:
  - link: https://fulldecent.blogspot.com/2010/08/convert-fen-strings-to-html.html#comment-3765269258234609476
    name: Anonymous
    text: "Thanks for sharing this link,  but unfortunately it seems to be offline... Does anybody have a mirror or another source? Please reply to my post if you do!<br /><br />I would appreciate if a staff member here at fulldecent.blogspot.com could post it.<br /><br />Thanks,<br />Jules"
  - link: https://fulldecent.blogspot.com/2010/08/convert-fen-strings-to-html.html#comment-3651018604546488685
    name: William Entriken
    text: "Are you able to access the homepage https://phor.net ? I posted a copy of fen2html at hosting2.phor.net/~phor/beta/fen2html.html<br /><br />Enjoy!"
---

Introducing the FEN to HTML converter. Paste FEN in, view the board and get HTML out. Does not use any images.

<style>
table.chess { border: 1px solid black; margin: 2px; font-size: xx-large}
table.chess td { width: 1.5em; height: 1.5em; padding: 0; margin: 0; vertical-align:middle; text-align: center }
table.chess tr td { background: #F2E0CB }
table.chess tr:nth-child(odd) td:nth-child(even), table.chess tr:nth-child(even) td:nth-child(odd)  { background: #C4AA8B }
</style>

## Try it

<div class="input-group input-group-lg mb-3">
  <input class="form-control" onkeyup="fentohtml()" id="fen" value="rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1">
</div>

<div class="row">
  <div class="col-lg-6">
    <h3>Output view</h3>
    <div id="out"></div>
  </div>
  <div class="col-lg-6">
    <h3>Output HTML</h3>
    <pre id="outhtml" style="font-size: 0.7em; overflow-x: auto;"></pre>
  </div>
</div>

<script>
const pieces = {
  K: '♔', Q: '♕', R: '♖', B: '♗', N: '♘', P: '♙',
  k: '♚', q: '♛', r: '♜', b: '♝', n: '♞', p: '♟',
};
function fentohtml() {
  html = document.getElementById('fen').value.trim()
    .replace(/\s+.*/, '')
    .replace(/\d+/g, (n) => ' '.repeat(n))
    .replace(/./g, (char) => '<td>' + (pieces[char] || char))
    .replace(/^|<td>\//g, '\n  <tr>');
  html = '<table class="chess">' + html + '\n</table>';
  document.getElementById('out').innerHTML = html;
  document.getElementById('outhtml').innerHTML = html.replace(/</g, '&lt;').replace(/>/g, '&gt;');
}
fentohtml();
</script>
