
## Test SIP server

BEST

```sh
stdbuf -i0 -o0 -e0 nc -u -l -p 5060 | stdbuf -i0 -o0 -e0 egrep -o '^From:(.*);' | stdbuf -i0 -o0 -e0 uniq

```

```sh
stdbuf -i0 -o0 -e0 nc -u -l -p 5060 | stdbuf -i0 -o0 -e0 egrep -o '^From:(.*);'
```

```sh
echo welcome | nc -l -u -p 5061
nc -u -l -p 5060 | stdbuf -i0 -o0 -e0 egrep -o '^From:(.*);tag=' | stdbuf -i0 -o0 -e0  uniq

```

```
echo <<EOL
INVITE sip:123457@medtalk.pacificmedicaltraining.com SIP/2.0
Content-Length: 0

EOL | nc 173.193.85.18 -u -p 5060


```

## SIP Protocol

<https://en.wikipedia.org/wiki/List_of_SIP_response_codes>

<http://toncar.cz/Tutorials/VoIP/VoIP_Protocols_SIP_Messages.html>

<https://tools.ietf.org/html/rfc3261>

The FROM header: <https://tools.ietf.org/html/rfc3261#section-8.1.1.3>

## Typical invite

```
INVITE sip:123457@medtalk.pacificmedicaltraining.com SIP/2.0
Via: SIP/2.0/UDP 173.193.85.18:5060;branch=z9hG4bK6dcfba15;rport
Max-Forwards: 70
From: "JAN" <sip:2152588220@173.193.85.18>;tag=as0537304d
To: <sip:123457@medtalk.pacificmedicaltraining.com>
Contact: <sip:2152588220@173.193.85.18:5060>
Call-ID: 2af426080350571045e2c9762f17baf7@173.193.85.18:5060
CSeq: 102 INVITE
root@discourse-pmt-medtalk:~# ls
response  response2  response3
root@discourse-pmt-medtalk:~# cat response
INVITE sip:123457@medtalk.pacificmedicaltraining.com SIP/2.0
Via: SIP/2.0/UDP 173.193.85.18:5060;branch=z9hG4bK4603f4e4;rport
Max-Forwards: 70
From: "JAN" <sip:2152588220@173.193.85.18>;tag=as5de480b0
To: <sip:123457@medtalk.pacificmedicaltraining.com>
Contact: <sip:2152588220@173.193.85.18:5060>
Call-ID: 64cff6e92abcf201746a31a539c17e61@173.193.85.18:5060
CSeq: 102 INVITE
User-Agent: voip.ms
Date: Sat, 14 Dec 2019 02:14:37 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Remote-Party-ID: "JAN" <sip:2152588220@173.193.85.18>;party=calling;privacy=off;screen=no
Content-Type: application/sdp
Content-Length: 0

```

## Response

```
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 10.10.1.13:5060;
  branch=z9hG4bK78946131-99e1-de11-8845-080027608325;
received=10.10.1.13;rport=5060
From: <sip:13@10.10.1.99>;
  tag=d60e6131-99e1-de11-8845-080027608325
To: <sip:13@10.10.1.99>;tag=as5489aead
Call-ID: e4ec6031-99e1-de11-8845-080027608325@vvt-laptop
CSeq: 1 REGISTER
User-Agent: Asterisk PBX
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER,
  SUBSCRIBE, NOTIFY
Supported: replaces
WWW-Authenticate: Digest algorithm=MD5, realm="asterisk",
  nonce="343eb793"
Content-Length: 0
```

```
SIP/2.0 603 Decline
```

## Example messages

```
root@discourse-pmt-medtalk:~# echo -e "SIP/2.0 603 Decline\r\n" | nc -l -u -p 5060
INVITE sip:123457@medtalk.pacificmedicaltraining.com SIP/2.0
Via: SIP/2.0/UDP 173.193.85.18:5060;branch=z9hG4bK4603f4e4;rport
Max-Forwards: 70
From: "JAN" <sip:2152588220@173.193.85.18>;tag=as5de480b0
To: <sip:123457@medtalk.pacificmedicaltraining.com>
Contact: <sip:2152588220@173.193.85.18:5060>
Call-ID: 64cff6e92abcf201746a31a539c17e61@173.193.85.18:5060
CSeq: 102 INVITE
User-Agent: voip.ms
Date: Sat, 14 Dec 2019 02:14:37 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Remote-Party-ID: "JAN" <sip:2152588220@173.193.85.18>;party=calling;privacy=off;screen=no
Content-Type: application/sdp
Content-Length: 319
```

```

```

## Using TCP

<https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms776001(v=vs.85)>

```
SIP: someone@example.com;transport=TCP

sip:123457@medtalk@pacificmedicaltraining.com;transport=TCP

   sip:bob@biloxi.com:6000;transport=tcp


sip:aaa@medtalk.pacificmedicaltraining.com;transport=tcp
```
