---
title: "A list of all numbers on Google Voice"
tags: 
  - user-interface
old-link: https://privacylog.blogspot.com/2009/08/full-google-hack.html
comments:
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-3504958419579781176
    name: Anonymous
    text: "did you use Activeperl?  Which packages did you enable?"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-6975637090401301260
    name: William Entriken
    text: "I ran this on Mac with the built in Perl and no packages. This should also work on Windows/Linux with ActivePerl. This should also work on Windows/Linux with ActivePerl.<br /><br />The important part here is that the command `open -g &quot;$_&quot;; sleep 0.2` on Mac will open Safari (which already has your GV login cookie) and download the requested JSON file.<br /><br />If you are using another platform you may need to edit this line. I imagine the best solution would be to use wget --save-cookies once to login and then pipe that command to wget --header &quot;Cookie:...&quot; -i -  . In fact, that will probably be 100 times faster."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-133080260039954207
    name: Alex M
    text: "Great post! Still works too, just replace:<br /><br />URL=&quot;https://www.google.com/voice/setup/search/&quot;<br /><br />with<br /><br />URL=&quot;https://www.google.com/voice/?setup=1#setup/&quot;<br /><br />Thanks for this."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-6552820783876195346
    name: William Entriken
    text: "I'm getting nasty unauthorized responses.  [phor@oriskany gvoice]$ curl --header &quot;$HEADER&quot; &quot;${URL}?ac=484&amp;start=0&quot;<br /><br />https://www.google.com/voice/b/0/setup/searchnew/?ac=484&amp;start=0 --&gt; &lt;stdout&gt;<br />--_curl_--https://www.google.com/voice/b/0/setup/searchnew/?ac=484&amp;start=0<br />&lt;HTML&gt;<br />&lt;HEAD&gt;<br />&lt;TITLE&gt;Unauthorized&lt;/TITLE&gt;<br />&lt;/HEAD&gt;<br />&lt;BODY BGCOLOR=&quot;#FFFFFF&quot; TEXT=&quot;#000000&quot;&gt;<br />&lt;H1&gt;Unauthorized&lt;/H1&gt;<br />&lt;H2&gt;Error 401&lt;/H2&gt;<br />&lt;/BODY&gt;<br />&lt;/HTML&gt;"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-133080260039954207
    name: Alex M
    text: "Try it on an account that does not have a number assigned yet."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-1725906280826490346
    name: William Entriken
    text: "As of today, here&#39;s the latest list of area codes on Google Voice: # 201 202 203 205 206 207 208 209 214 215 216 218 219 224 231 234 240 248 251 252 253 256 260 262 267 269 276 281 301 302 303 304 307 310 312 313 314 315 316 317 318 319 320 321 323 330 331 334 336 339 347 352 360 361 385 401 402 404 405 406 408 409 410 412 413 414 415 419 423 424 425 430 432 434 435 440 443 469 478 480 484 502 505 507 508 510 513 515 516 518 530 540 541 551 559 561 562 567 570 571 573 575 585 586 601 602 605 607 608 609 614 615 616 617 630 646 650 657 661 662 678 701 702 704 706 707 708 716 717 719 720 724 727 731 732 734 740 747 754 757 760 762 765 769 770 772 773 774 775 779 781 786 801 802 803 804 805 810 812 813 814 815 816 828 832 845 847 848 856 857 858 859 860 862 863 864 865 872 904 908 909 910 914 918 919 920 925 931 937 941 951 954 956 970 971 973 978 980 985"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-2313670470606874549
    name: natarajan
    text: "can anyone run this script and tell me if any numbers are still available because I can&#39;t seem to get any."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-2969015201701669552
    name: William Entriken
    text: "Numbers are available. I updated the list of area codes based on numbers that are available yesterday."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-5981568545760794511
    name: Kris Aubuchon
    text: "Does this work for anyone else anymore? It&#39;s shooting blanks for me."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-962126380905649328
    name: William Entriken
    text: "Still working for me. What are you getting stuck on."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-2044524023508060467
    name: William
    text: "Shooting blanks for me, as well. I&#39;m getting &quot;Moved temporarily&quot; messages for each url pattern... looks like google has caught on to this. When I go to the example link ( https://www.google.com/voice/b/0/setup/searchnew/?ac=484&amp;start=0 ) I get a nice JSON response with all the available numbers, though. So that&#39;s working just fine. I&#39;m not a pro at json, but if anyone comes up with a new solution, I&#39;ll be happy and grateful."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-341808619143215846
    name: William
    text: "Nevermind - I had some issues with my cookies."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-1280961834277851371
    name: Matthew
    text: "What am I doing wrong? I am in terminal and I run <br />URL=&quot;https://www.google.com/voice/b/0/setup/searchnew/&quot;<br />And then I am hopping into Firefox and grabbing my cookie<br />COOKIES=&quot;gv=DQAAA3TB2BmcUVc6DzxDfuUO53L705ne8ei1F_qMzzKp1jWXP0No7totxK3gVlVEF73UDCb_ytJlGniwSpUG8HIAb44-RFWRs3R25jxW86QMav9ZIn7Ot5t_tDGP-8u6eunq8ls4W2G4GR1HipGoMSdz2F-_b2qtA-gYotHzTdXkKtEkqsiBpKQKpDJs-onAXt5; PREF=ID=55d9f73f17:U=2d069e04e:FF=0:TM=1340314:LM=10372:GM=1:S=uosNGAjhIfX; NID=63=y2kb7aZloPM2ialZKbl8yivebhdo8MQehY_1MCMj4zFhzMwz5liYxtzrmXliL0xhyc5AIZeEk30Uz4QOnN0ukcGqwlFz9GTA; SID=DQAAAM0Ao4E_d3H4NKgU7Gcmcek7PQaEiDm0BzqwcgVroAcUtuWxgYftOmWWOn26FvKQlhcyJKim7iNPtQL7q_tgEsvdm1OkKWgvOUOvcEB-rxUwCAilLt0W5uv10sx1BSr3vqV0NG8XQF1WU3-uIOjNF5aVmLnoNxhYBpmzQ585tmv8ao5ZbDi1PuOJZnAKg05_Ex7s54tVj4h_Zfzg55VVb; HSID=AQhS9YX1gR9k; SSID=A9kCyI8ybCvr4; APISID=WWWfJxHafrVWG; SAPISID=8HuWouUe-2wCk0vGw6cUE2gf; S=grandcentral=bMOGegvxYy_FACXbU2DQ&quot;<br /><br />I assign that in Terminal and it comes back with only actually assigning up to the first space. Am I doing something wrong?"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-172412128627707261
    name: Unknown
    text: "Here&#39;s a PHP script I made derived from this post. I&#39;m sharing this as my way of saying thank you. to run the script below you need to supply the ac and s parameters like so https://localhost/gv.php?ac=121$s=0 s should be looped and incremented by 5 each time since google will give you 5 numbers each page. ------------ 'GOOGLE',  'Email' => 'username@gmail.com',  'Passwd' => 'password',  'source'=>'PHI-cUrl-Example',  'service'=>'grandcentral';  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);  curl_setopt($ch, CURLOPT_POST, true);  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  curl_setopt($ch, CURLOPT_POSTFIELDS, $data); $msg = curl_exec($ch); $cookies = split(&quot;\n&quot;,$msg); //print_r($cookies);$ch = curl_init(&quot;https://www.google.com/voice/b/0/setup/searchnew/?ac=&quot;.$_GET[&#39;ac&#39;].&quot;&amp;start=&quot;. $_GET[&#39;s&#39;]);  $header[] = 'Authorization: GoogleLogin ' . $cookies[2];curl_setopt($ch, CURLOPT_HTTPHEADER, $header);  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  curl_setopt($ch, CURLOPT_HEADER, false); $msg = curl_exec($ch); curl_close($ch);$arr_data = json_decode($msg);echo &quot;matches found = &quot; . $arr_data->JSON->num_matches . &quot;<br>&quot;;foreach($arr_data->JSON->vanity_info as $numbers=>$whatever){ echo $numbers . &quot;<br>&quot;;}?> ------------"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-9186223796125575906
    name: Unknown
    text: "Here&#39;s a PHP script I made derived from this post. I&#39;m sharing this as my way of saying thank you. to run the script below you need to supply the ac and s parameters like so https://localhost/gv.php?ac=121$s=0 s should be looped and incremented by 5 each time since google will give you 5 numbers each page. ------------ 'GOOGLE',  'Email' => 'username@gmail.com',  'Passwd' => 'password',  'source'=>'PHI-cUrl-Example',  'service'=>'grandcentral';  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);  curl_setopt($ch, CURLOPT_POST, true);  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  curl_setopt($ch, CURLOPT_POSTFIELDS, $data); $msg = curl_exec($ch); $cookies = split(&quot;\n&quot;,$msg); //print_r($cookies);$ch = curl_init(&quot;https://www.google.com/voice/b/0/setup/searchnew/?ac=&quot;.$_GET[&#39;ac&#39;].&quot;&amp;start=&quot;. $_GET[&#39;s&#39;]);  $header[] = 'Authorization: GoogleLogin ' . $cookies[2];curl_setopt($ch, CURLOPT_HTTPHEADER, $header);  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  curl_setopt($ch, CURLOPT_HEADER, false); $msg = curl_exec($ch); curl_close($ch);$arr_data = json_decode($msg);echo &quot;matches found = &quot; . $arr_data->JSON->num_matches . &quot;<br>&quot;;foreach($arr_data->JSON->vanity_info as $numbers=>$whatever){ echo $numbers . &quot;<br>&quot;;}?> ------------"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-7082274782904371814
    name: Anonymous
    text: "The script works and prints a bunch of numbers. But  when I log into google voice and try to get one of the numbers (through a search it says the number is not available). any reason why?"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-2290654324796500910
    name: William Entriken
    text: "Just bad luck. Numbers come and go very fast, you&#39;ll need to register immediately when you choose one. In one week, a majority of the numbers in your search could be gone. The good numbers will go even faster."
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-395692927011449221
    name: Anonymous
    text: "Thank you Will for the response. I had another question. Why is there a need to do BFS? When I run it using the search 201* it returns a set of results which are then repeated on searches for 2010*, 2011* and so on. Why is there a need for BFS? Shouldn&#39;t 201* cover all possibilities? What am I missing to understand here? Very useful article, many thanks! Thanks"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-7484356470799175783
    name: William Entriken
    text: "Cheers. The problem with 201* or just * for that matter is that you only get 10 results per search. So a search for 201 might only return 2011* numbers. BFS allows you to seek 201? and then 201?* by induction (glob notation here)"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-4670563192896513015
    name: Anonymous
    text: "could someone check 360 availability for me please? FF has been giving me java script error msgs since last upgrade. I need to make sure it is local for the 629 prefix. Thanks"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-5375608098233082851
    name: William Entriken
    text: "360 confirmed available 629 confirmed not available"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-6704982918470054664
    name: Unknown
    text: "OK - I&#39;m an idiot - let&#39;s start from that understanding.  I&#39;m looking for a 509 Google Voice area code, and am happy to run a script to help me.  They are all out - once every 2 days there are numbers that come up in Yakima or other long-distance area that is in the 509 area code.  I need a Spokane area code.  I&#39;ll pay for it.  I see your script, but here&#39;s the issue.  I&#39;m a moron.  Where do I cut and paste the script into to make it run and continually search for Google Voice numbers?  What program (if any) do I use?  Where do I input this script to work?  Thanks!"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-3507337372542055332
    name: William Entriken
    text: "Leif, how do you know which numbers are in Spokane?"
  - link: https://privacylog.blogspot.com/2009/08/full-google-hack.html#comment-8328607769323707155
    name: Unknown
    text: "Thanks for the script; got me a nice numero now."
---

Update 2017-10-20: If you just want a good vanity number and don't want to spend 1-2 days setting up Unix, contact me with your area code(s). I ask $30 for this service in BTC or PayPal.

Update 2011-01-27: thanks to A. Manessi for bug reports

Update 2010-07-09:  thanks to Michael Poon at MIT for showing how to login via curl

---

1. Login to Google Voice with Chrome, Safari or any other browser with web developer tools

2. Open web developer tools, and load https://voice.google.com/signup?pli=1

3. In the developer network tab, click clear, and then search for `9999`




search=$1
curl 'https://clients6.google.com/voice/v1/voiceclient/accountphonecandidate/search?alt=protojson&key=AIzaSyDTYc1N4xiODyrQYK0Kl6g_y279LjYkrBg' \
  -H 'accept: */*' \
...


# seq 201 989 | xargs -P 50 -n 1 -I {} sh tmp.sh {} 2>/dev/null | egrep -o '\+1\d{10}' > numbers.txt

4.  with Firefox / LiveHTTPHeaders

    Don't use Chrome, I know, I know... just download Firefox

5. Find which area codes Google Voice has
    ```sh
    mkdir GOOGLEVOICE; cd GOOGLEVOICE
    
    # open https://voice.google.com/signup?pli=1
    
    # use LiveHTTPHeaders and get the cookies
    URL="https://www.google.com/voice/b/0/setup/searchnew/"
    COOKIES="gv=DQAAAxxxxxx; PREF=xxxxx; xxxx SSID=xxxx" # PUT YOUR COOKIES IN HERE
    curl --cookie "$COOKIES" "${URL}?ac=[201-999]&amp;start=0" | grep -ho "+1[0-9]\{3\}" | cut -b3-5 | sort -u &gt;&gt; areacodes
    
    # area codes available as of 2016-03-26
    # 201 203 205 207 208 209 210 215 216 218 219 224 225 229 231 234 240 248 251 
    # 252 254 256 260 262 267 269 276 302 304 305 307 312 314 315 316 317 318 319 
    # 320 321 323 325 330 331 334 336 337 339 346 347 352 361 385 386 401 402 405 
    # 406 407 408 409 412 413 414 415 417 419 423 424 432 434 435 440 442 443 458 
    # 469 470 475 478 480 484 501 502 503 504 505 507 508 509 510 512 513 515 516 
    # 517 518 520 530 531 539 540 541 551 559 562 563 567 570 571 573 574 575 585 
    # 586 601 605 607 608 609 612 614 615 616 617 619 620 626 628 630 631 636 641 
    # 646 650 651 657 660 661 662 669 678 681 682 701 702 703 704 706 707 708 712 
    # 715 716 717 718 719 720 724 727 731 732 737 740 747 754 757 760 762 763 765 
    # 769 770 772 773 774 775 779 781 785 786 801 802 803 804 805 806 810 812 813 
    # 814 815 816 817 818 828 830 831 843 845 847 848 850 856 857 858 859 860 862 
    # 863 864 865 872 901 903 904 908 909 910 912 913 914 915 916 917 918 919 920 
    # 925 929 931 936 937 940 941 949 951 956 970 971 972 973 978 979 980 984 985 
    # 989

6. Get numbers in your target area codes

    ```sh
    # add a full number from each area code you want to NUMBERS
    printf "4840000000\n8480000000\n" &gt; numbers

    # BFS on each digit to find all numbers, about 30 minutes per area code</b>
    cut -b1-3 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-4 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-5 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-6 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-7 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-8 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=0"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers
    
    cut -b1-8 numbers | sort -u | (while read LINE; do curl --cookie "$COOKIES" "${URL}?ac=${LINE:0:3}&amp;q=$LINE[0-9]&amp;start=5"; done) | grep -Pho '\d{10}\b' | sort -u &gt;&gt; numbers</pre>

7. Harvest out your winnings
    ```sh
    sort -u numbers &gt; sorted; mv sorted numbers 
    ```

8. Find cool numbers, using my definition of cool
    ```sh
    # repeated set of 4 digits
    grep -P "(\d{4}).*\1" numbers
    # 4843248432

    # the whole number, with a limited number of unique digits
    grep -P "^(\d)\1*(\d)\1*\2*\1*\2*\1*\2*\1*\2*(\d)(\1|\2|\3)*$" numbers
    grep -P "^...(\d)\1*(\d)(\1|\2)*$" numbers
    # 7722020227

    # triple double
    grep -P "(\d)\1.*(\d)\2.*(\d)\3" numbers
    # 4842220022
    # 4842220044

    # triples
    grep -P "(\d)\1\1.*(\d)\2\2" numbers
    grep -P '(\d)\1{2,}' numbers
    # 4849388886

    # 4842220002
    # 4842220020
    # 4842220022
    # 4842220220

    # palindrome
    grep -P "(\d)(\d)(\d)(\d)(\d)\5?\4\3\2\1" numbers
    grep -P "(\d)(\d)(\d)(\d)\4?\3\2\1" numbers
    # 4846399364
    # 4842020248

    # toggles
    grep -P "(\d)(\d)\1\2\1" numbers
    grep -P "(\d)(\d)\1\2\1\2" numbers
    # 4848421212

    # use two digits
    grep -P "(\d)(\d)(\1|\2){4}" numbers
    # 4842020002
    # 4842020020
    # 4842020022
    # 4842020220
    ```
    
See also the [repository for all this code](https://github.com/fulldecent/google-voice-numbers).
