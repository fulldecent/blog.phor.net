---
title: "How to open SealedMedia files on Mac with Adobe Acrobat"
tags:
  - how-to
old-link: https://fulldecent.blogspot.com/2007/04/opening-sealedmedia-files-using-adobe.html
---

*UPDATE 2013-12-16*. If you are still using spdf files, please contact me so I can update these instructions.

I could not find instructions for opening DRM-encumbered .spdf files using Acrobat 8 on Mac OSX. So I'm including my own instructions:

**The first part is to get these files up on your screen.**

You will have to download Acrobat 7 for Mac first. Use this link: [ftp://ftp.adobe.com/pub/adobe/reader/mac/7x/7.0/enu/AdbeRdr70_enu_full.dmg](ftp://ftp.adobe.com/pub/adobe/reader/mac/7x/7.0/enu/AdbeRdr70_enu_full.dmg)

Note that the installation will succeed with no indication that the process is complete.

You will need to install SealedMedia unsealer first [https://download.sealedmedia.com/unsealer/index.asp](https://download.sealedmedia.com/unsealer/index.asp)

Unfortunately, you will need to provide root access to the DRM installer for this to work, and it will not work with a low-privilege test account.

**The second part is to get these files into postscript format:**

To do this, I installed a virtual printer driver for Mac OS X. [https://www.codepoetry.net/projects/cups-pdf-for-mosx](https://www.codepoetry.net/projects/cups-pdf-for-mosx)

What this program will do is let a program save raw printer postscript to a file, and then it tries to convert this postscript to a PDF file. But that would be too easy. Unfortunately, the PS files can't be converted to PDF that easily, so we need some modifications.

After you install this program, we will need to edit the file /etc/cups/cups-pdf.conf. Change the line "GhostScript /usr/bin/pstopdf" to "GhostScript /bin/cp" and "#GSCall %s %s -o %s %s" to "GSCall %s %s %s %s /tmp/ps"

This will prevent the virtual printer driver from converting the PS on its own, which will normally fail.

Next, make the directory:

```shell
mkdir /tmp/ps
chmod 777 /tmp/ps
```

Open your sealed files and print to this printer, and you will now have the PS files you need.

**Part three is to convert these PS to PDF**

I did this step on Linux since that's where my dev tools are. Download the source for Ghostscript at [https://www.cs.wisc.edu/~ghost/doc/GPL/gpl856.htm](https://www.cs.wisc.edu/~ghost/doc/GPL/gpl856.htm) and edit the file libs/gs_pdfwr.ps and change

```postscript
currentdevice .devicename /pdfwrite eq {
```

to

```postscript
currentdevice .devicename /pdfwritexxx eq {
```

This idea came from [https://www.cs.cmu.edu/~dst/Adobe/Gallery/anon-ebook-to-pdf.txt](https://www.cs.cmu.edu/~dst/Adobe/Gallery/anon-ebook-to-pdf.txt)

Compile and install this code, and run ps2pdf on your PS files.

**Finally, open the files**

Now you can open Adobe Reader 8 on Mac and open these new PDF files. Assuming you are the owner of these files, you should now publish these files online at thepiratebay.com

Please let me know if there is an easier way to get this Ghostscript on Mac to avoid the nonsense or any other way to make this easier. Naturally, I only recommend that you do this with .spdf files that do not have any access controls for copyrighted materials, because that would be illegal.

For example, you should not use this method to open Harvard Business Cases, unless you are the copyright holder.

Keywords: DRM, SealedMedia, Harvard Business School cases, Unsealer
