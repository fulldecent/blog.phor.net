Estimated time: 1 hour

Note about affiliate links

PASSWORD CARD

Print this password card

1. Backup user account ----
2. Other computer on your network 1...
3. User account: backup-for-people-outside-my-house

Print this page and check off each step as you go along. You will need check off if you have a problem.

# How to double backups with two Macs across different houses

You'll get encrypted backups, automatically, every hour, across both your and your friend's houses.

And your friend gets the same.

## Introduction

:information_source: This guide will show you how to **double backup** your files. That means your files will live primarily on your own phones and computers. Then a backup will reside at your house. And lastly, another backup will reside at your friend's house.

:muscle: Even if your own phone, computer and backup in your house disappeared overnight... you would still have the extra backup at your friend's house. And it is no more that one hour behind your own primary backup.

:handshake: While you are keeping a backup at your friend's house, they are also keeping a backup at yours.

:lock: Your friend has no access to your backup files. And you have no access to theirs.

:arrow_down: Following are all the instructions you'll need to set this up and a conclusion at the bottom. Enojy! And if you have any questions, reply to this post on <https://x.com/fulldecent>.

## What you'll need

1. **One always-on Mac in each of two different houses.** Most people will use an iMacs or Mac Minis. But any device you choose, plan on keeping in plugged in and online 24/7. Choose Macs that are [compatible with the latest version of macOS](https://support.apple.com/en-us/105113).
2. **A USB stick that fits into both of those Macs**.
3. **An external hard drive with USB type-C connectivity, for each computer.** Whatever capacity you think you need, double that. And then double that again because half of the space will be shared out to your friend. Both disks should be the same size.

## Basic Mac setup

We will setup these Macs using Apple's built-in software. Some improvements are possible with third-party software which we will show below as appropriate.

The remaining steps all apply to the first Mac you will use of the two. But you will repeat everything on the other one as well later.

1. Open System Settings
2. Click General on the left
3. Update to the latest version of macOS

## Setup disk

This step requires math. See your disk capacity shown in Disk Utility after

1. Open Disk Utility
2. Plug in your hard disk
3. On the left, click External and the name of your disk
4. Format the disk
   1. Select APFS. Do not select encrypted. ADD SIDE NOTES ABOUT THIS CHOICE
5. On the toolbar click the Partition button
   1. Click the + button under the pie chart
   2. Click add partition (not the default option)
   3. Click on the "Backup" partition and change the size so that it is a little less than half of the full disk available amount. E.g. for a 5 TB disk you would choose 2.4 TB rather than strictly half which would be 2.5 TB. ADD SIDE NOTES ABOUT THIS CHOICE
   4. Click on the "Untitled" partition and change the name to "Backup for people outside my house". Again the "Backup for people outside my house" must be a little bit (at least 5%) greater than the "Backup" drive. ADD SIDE NOTE
   5. Click Apply

## Create user account for sharing inside your house

1. Open Apple menu > System Settings > Users
2. Create a new Sharing only user account
3. Name it `Backup` and use the password generator to pick a letters and numbers password with length 20
   If you do not use this password generator, please leave yourself a note now. Ten days from now you will probably being messaging me

## Setup file sharing for inside your house

1. Go to System Settings > Sharing
2. Click the :information_source: next to File Sharing
3. Delete any other file sharing you have set up ADD NOTES ABOUT WHY
4. Turn file sharing on
5. Under Shared folders, click +
   1. Select the "Backup" disk. If you can't find it type Command+D on your keyboard and then press Command+Up a four times to find it.
   2. Hold control and click that Backup disk then Advanced settings
   3. (This may parrtially crash System Settings. If that happens, quit System Settings, reopen and get back to that page and repeat the prior step. It will work the second time.)
   4. Turn off Allow guest users
   5. Turn on Only allow SMB encrypted connectitons
   6. Turn on Share as a Time Machine backup destination
6. Under users, carefully edit these settings
   1. For your own name, keep it, it should be Read & Write
   2. Select the Staff option and click the minus button
   3. Click the Everyone option and change to No access
   4. Click plus, select the Backup user and change to Read & Write
7. Click Options... at the bottom of the dialog
   1. Ensure that Windows File Sharing is disabled (unchecked) for each account
   2. Ensure that share files and folders using SMB is enabled (checked)
   3. Click done
8. Click done.

## (Optional) Backup that computer to that disk

DO NOT DO THIS // the backup will work // but then the disk will crash when other computers in your house connect to this disk

You will only need this section if the Mac that is hosting the shared disk is also used for other important stuff.

If your Mac hosting the backup disk is dedicated for only sharing this disk then you can skip this section.

1. Go to System Settings > Time Machine
2. Click + in the section of disks (which may be empty, and which may have other backups already shown, which is none of my business)
   1. Select the new Backup disk you just created
   2. Open Terminal app
      1. Type `uuidgen` and press enter, this will be your password
      2. Carefully select that text (including the up to the first letter/digit, and up to the letter/digit, but not including an extra space or line breaks around either)
   3. Use that password
   4. Do not leave a hint
   5. Click okay

## Setup time machine on each computer in your house

Repeat this step for each computer in your house. They must be on the same network (Wi-Fi or cable).

1. Open System Settings > General and update to the latest version of macOS
2. Open System Settings > Time Machine
3. Click the + button to add a new backup location (you may have others already which is none of my business)
4. Select "Backup on XXX" where XXX is the name of your computer sharing the backup disk
   1. You will need to enter your backup user account password (remember it is 20 letters-numbers). This is different than the backup password for the specific Mac sharing the disk (if you did that step above).
   2. You will need to type this really long password and you can't see it while you're typing. It may be helpful to first open Textedit on that computer, type it in there and then copy-paste over.
   3. On macOS 14 and maybe later This will produce an error ""The operation could'nt be completed. com.apple.TimeMachine.SettingsExtension error 5.) The workaround follows (SIDENOTE thank you Apple support... cite this note)
      1. Go back to the server which is hosting the shared disk
      2. Open System Settings > Privacy & Security
      3. Click Full Disk Access
      4. Click the + button (requires your account password)
      5. Press Command-Shift-G, type in exactly `/usr/sbin/smbd`
      6. Press enter to select it
      7. Also then press okay to select that

## Set up user for people outside your house (your fiend)

1. Open System Settings > Users & Groups
2. Add a user
3. Set name to: Backup for people outside my house
4. Set account name to: backup-for-people-outside-my-house
5. Use the password generator to set a password with 20 letters & numbers
6. Make it a "sharing only" account
7. Install homebrew
8. /usr/homebrew/bin/brew install rsync
9. sudo zsh
   1. chown backup-for-people-outside-my-house /Volumes/Backup\ for\ people\ outside\ my\ house
   2. chown 700 /Volumes/Backup\ for\ people\ outside\ my\ house

chroot // rsync fails after boot

## Set up strong passwords

Because your SSH server only for this server will be on the public internet. LIke a DMZ.

## Set up rsync server

- Mac already has rync 2 from 2006.
- You don't need rsync server, when you use rsync to send files over ssh it will already call the rsync process on the remote server.
- You can upgrade to the new rsync with homebrew which is much faster, especiall for sparse bundles which mac backups use.

## File sharing

- Create user on server
- Create client key pair
- Put public key in authorized keys
- On server
  - PasswordAuthentication no
    ChallengeResponseAuthentication no
    PubkeyAuthentication yes
- sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
  sudo launchctl load /System/Library/LaunchDaemons/ssh.plist
- To restrict the rsyncuser so that they can only run rsync commands over SSH, you can modify the authorized_keys file to specify a forced command.
  - command="rsync --server --daemon .",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQE... your_key_here
- Test it
  - rsync -avz -e ssh /path/to/local/files/ rsyncuser@your_mac_ip:/path/to/remote/directory/

## Make a vpn when you are behind residental routers

Serveo

for demo purpose use iphone to share person internet (this is a different network that is separate!) over wifi. But then later for speed put them on the same network.

MOAR IDEAS

- How to do backups with two mac minis.md

- Make a drive for encrypted backups (10 TB? spinning?)

- Sync to that server from your laptop

- Set up a firewall and vpn connection with your friend’s mac (how to get dynamic DDNS?)

- Use rsync both directions. (Need rsync server?) with cron

- Need to punch router holes??

- Set up notifications if rsync fails (you already get notified if laptop to server fails)

- Then try it with Foggie

  <https://tidbits.com/2022/01/14/network-time-machine-backups-moving-on-from-the-time-capsule/>

---

- Make a tl-dr video for setting all this up too.
- Make a email signup for Foggie on making this cheaper.
- Title / sub title "without install any additional software"

## External HDD

- get two different 4tb or 8tb HDDs because ssd is faster than the network bottleneck

## Promoting this article

- Owner of Serveo // send him a donation
- Hackernoon (I have a contact there?!)
- Hackernews
- Ask GPT
