---
title: "Reference for Chris—dupe merge"
tags:
  - good-find
old-link: https://fulldecent.blogspot.com/2010/09/reference-for-chris-dupe-merge.html
comments:
  - link: https://fulldecent.blogspot.com/2010/09/reference-for-chris-dupe-merge.html#comment-2215846764135909467
    name: William Entriken
    text: "Posted in full for posterity. Current downloadable link at: https://hungrycats.org/~zblaxell/dupemerge/faster-dupemerge"
  - link: https://fulldecent.blogspot.com/2010/09/reference-for-chris-dupe-merge.html#comment-3739159674132772033
    name: Anonymous
    text: "Nice dispatch and this fill someone in on helped me alot in my college assignement. Gratefulness you for your information."
---

Posting this for reference, for Chris, and for anyone else who manages LARGE sets of media files. I've been using this script for 10 years, here is the latest version:

```perl
#!/usr/bin/perl -w
use strict;
use Fcntl qw(:DEFAULT :flock);
use File::Compare;
use File::Temp;

# Copyright (C) 2002-2010 Zygo Blaxell

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

my $input_links = 0;
my $input_files = 0;
my $input_bogons = 0;
my $hash_bytes = 0;
my $hash_files = 0;
my $hash_errors = 0;
my $compare_bytes = 0;
my $compare_count = 0;
my $compare_errors = 0;
my $compare_differences = 0;
my $trivially_unique = 0;
my $merges_attempted = 0;
my $hard_links = 0;
my $link_errors = 0;
my $link_retries = 0;
my $recovered_bytes = 0;
my $recovered_files = 0;
my $lost_files = 0;
my $lost_bytes = 0;
my $surprises = 0;

eval '
 use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);
';

if ($@) {
 warn "Digest::SHA1: $@\nUsing external md5sum program to generate hashes.\nPlease install Digest::SHA1 (libdigest-sha1-perl)";

 eval <<'DIGEST';
  sub really_digest {
   my ($filename) = (@_);
   my $fv = open(MD5SUM, "-|"); 
   die "fork: $!" unless defined($fv);
   if ($fv) {
    my ($sum_line) = ;
    close(MD5SUM) or die "md5sum: exit status $? (error status $!)";
    die "hash error:  got EOF instead of md5sum output" unless defined($sum_line);
    my ($sum) = $sum_line =~ m/^([a-fA-F0-9]{32})/o;
    die "hash error:  got \Q$sum_line\E instead of md5sum output" unless defined($sum);
    return $sum;
   } else {
    sysopen(STDIN, $filename, O_RDONLY|O_NONBLOCK) or die "open: $filename: $!";
    exec('md5sum');
    # Perl guarantees it will die here
   }
  }
DIGEST
} else {
 eval <<'DIGEST';
  sub really_digest {
   my ($filename) = (@_);
   die "'$filename' is not a plain file" if (-l $filename) || ! (-f _);
   my $ctx = Digest::SHA1->new;
   sysopen(FILE, $filename, O_RDONLY|O_NONBLOCK) or die "open: $filename: $!";
   binmode(FILE);  # FIXME:  Necessary?  Probably harmless...
   $ctx->addfile(\*FILE);
   close(FILE) or die "close: $filename: $!";
   return $ctx->b64digest;
  }
DIGEST
}
 
my $collapse_access = 0;
my $collapse_timestamp = 0;
my $collapse_zero = 0;
my $skip_compares = 0;
my $skip_compare_preference = 0;
my $skip_hashes = 0;
my $skip_hashes_threshold = 0;
my $progress = 0;
my $verbose = 0;
my $debug = 0;
my $dry_run = 0;
my $humane = 0;
my @extra_find_opts = ();
my @extra_sort_opts = ();
my $lock_file;
my $lock_rm = 0;
my $lock_obtained = 0;

sub digest {
 my ($filename) = (@_);
 if ($skip_hashes) {
  return "SKIPPING HASHES";
 } else {
  print STDERR 'H' if $progress;
  my $digest = &really_digest($filename);
  $hash_bytes += -s $filename;
  $hash_files++;
  return $digest
 }
}

my @directories;

sub usage {
 my $name = shift(@_);
 die <
Usage: $name [--opts] directory [directory...]
Finds duplicate files in the given directories, and replaces all identical
copies of a file with hard-links to a single file.

Several options modify the definition of a "duplicate".  By default, files
which have differences in owner uid or gid, permission (mode), or
modification time (mtime) are considered different, so that hardlinking
files does not also change their attributes.  Additionally, all files of
zero size are ignored for performance reasons (there tend to be many
of them, and they tend not to release any space when replaced with
hard links).

        --access        uid, gid, and mode may be different for identical
                        files

        --debug         show all steps in duplication discovery process
                        (implies --verbose)

        --dry-run       do not lock files or make changes to filesystem

        --find          pass next options (up to --) to find command

        --humane        human-readable statistics (e.g. 1 048 576)

        --lock FILE     exit immediately (status 10) if unable to obtain a
                        flock(LOCK_EX|LOCK_NB) on FILE

        --lock-rm       remove lock file at exit

        --progress      output single-character progress indicators:
                        C - compare
                        H - hash
                        L - link(2)
                        R - rename(2)
                        S, s - lstat(2) (see source for details)
                        U - unlink(2)
                        . - all inodes with similar attributes done
                        (123456) - current file size in bytes

        --sort          pass next options (up to --) to sort command

        --timestamps    mtime may be different for identical files

        --skip-compare  skip byte-by-byte file comparisons

        --skip-hash[=N] skip calculation of hash function on files
                        larger than N bytes (default 1M).
                        Scalars KMGT specify KiB, MiB, GiB, and TiB.
                        Scalars kmgt specify KB, MB, GB, and TB.

        --trust         old name for --skip-compare
                        (trust the hash function)

        --verbose       report files as they are considered

        --zeros         hard-link zero-length files too
USAGE
}

while ($#ARGV >= 0) {
 my $arg = shift(@ARGV);
 if ($arg eq '--access') {
  $collapse_access = 1;
 } elsif ($arg eq '--timestamps') {
  $collapse_timestamp = 1;
 } elsif ($arg eq '--zeros') {
  $collapse_zero = 1;
 } elsif ($arg eq '--trust' || $arg eq '--skip-compare') {
  $skip_compares = $skip_compare_preference = 1;
 } elsif ($arg =~ /^--skip-hash(?:=(\d+)([KkMmGgTt]?))?$/os) {
  my ($quantity, $unit) = ($1, $2);
  $unit ||= '_';
  $quantity ||= 1048576;
  my %scale = (
   _ => 1,
   k => 1000,
   K => 1024,
   m => 1000*1000,
   M => 1024*1024,
   g => 1000*1000*1000,
   G => 1024*1024*1024,
   t => 1000*1000*1000*1000,
   T => 1024*1024*1024*1024,
  );
  $skip_hashes = 0;
  $skip_hashes_threshold = $quantity * $scale{$unit};
 } elsif ($arg eq '--progress') {
  $progress = 1;
 } elsif ($arg eq '--verbose') {
  $verbose = 1;
 } elsif ($arg eq '--lock-rm') {
  $lock_rm = 1;
 } elsif ($arg eq '--lock') {
  $lock_file = shift(@ARGV);
  unless (defined($lock_file)) {
   usage($0);
   exit(1);
  }
 } elsif ($arg eq '--debug') {
  $debug = $verbose = 1;
 } elsif ($arg eq '--dry-run') {
  $dry_run = 1;
 } elsif ($arg eq '--humane') {
  $humane = 1;
 } elsif ($arg eq '--find') {
  while ($#ARGV >= 0) {
   my $extra_arg = shift(@ARGV);
   last if $extra_arg eq '--';
   push(@extra_find_opts, $extra_arg);
  }
 } elsif ($arg eq '--sort') {
  while ($#ARGV >= 0) {
   my $extra_arg = shift(@ARGV);
   last if $extra_arg eq '--';
   push(@extra_sort_opts, $extra_arg);
  }
 } elsif ($arg =~ /^-/o) {
  usage($0);
  exit(1);
 } else {
  push(@directories, $arg);
 }
}

@directories or usage($0);

if (defined($lock_file) && !$dry_run) {
 sysopen(LOCK_FILE, $lock_file, O_CREAT|O_RDONLY, 0666) or die "open: $lock_file: $!";
 flock(LOCK_FILE, LOCK_EX|LOCK_NB) or die "flock: $lock_file: LOCK_EX|LOCK_NB: $!";
 print STDERR "Locked '$lock_file' in LOCK_EX mode.\n" if $verbose;
 $lock_obtained = 1;
}

END {
 if ($lock_obtained && !$dry_run) {
  print STDERR "Removing '$lock_file'.\n" if $verbose;
  unlink($lock_file) or warn "unlink: $lock_file: $!";
 }
}

sub tick_quote {
 my ($text) = (@_);
 $text =~ s/'/'\\''/go;
 return "'$text'";
}

my @find_command = ('find', @directories, @extra_find_opts, '-type', 'f');
my $printf_string = '%s ' .
 ($collapse_access    ? '0 0 0 ' : '%U %G %m ') .
 ($collapse_timestamp ? '0 '     : '%T@ ') .
 '%D %i %p\0';

push(@find_command, '!', '-empty') unless $collapse_zero;
push(@find_command, '-printf', $printf_string);

my @sort_command = ('sort', '-znr', @extra_sort_opts);
my @quoted_sort_command = @sort_command;
grep(tick_quote($_), @quoted_sort_command);
my $quoted_sort_command = "'" . join("' '", @quoted_sort_command) . "'";

my @quoted_find_command = @find_command;
grep(tick_quote($_), @quoted_find_command);
my $quoted_find_command = "'" . join("' '", @quoted_find_command) . "'";
print STDERR "find command:  $quoted_find_command | $quoted_sort_command\n" if $verbose;

open(FIND, "$quoted_find_command | $quoted_sort_command |") or die "open: $!";
$/ = "\0";

# Input is sorted so that all weak keys are contiguous.
# When the key changes, we have to process all files we previously know about.
my $current_key = -1;

# $inode_to_file_name{$inode} = [@file_names]
my %inode_to_file_name = ();

# Link files
sub link_files {
 my ($from, $to) = (@_);

 my $quoted_from = tick_quote($from);
 my $quoted_to = tick_quote($to);
 print STDERR "\n" if $progress;
 print STDERR "ln -f $quoted_from $quoted_to\n";

 return if $dry_run;

 my $inode_dir = $to;
 my $inode_base = $to;
 $inode_dir =~ s:[^/]*$::o;
 $inode_base =~ s:^.*/::os;
 my $tmp_to = File::Temp::tempnam($inode_dir, ".$inode_base.");
 print STDERR "\tlink: $from -> $tmp_to\n" if $debug;
 print STDERR 'L' if $progress;
 link($from, $tmp_to) or die "link: $from -> $tmp_to: $!";
 print STDERR "\trename: $tmp_to -> $to\n" if $debug;
 print STDERR 'R' if $progress;
 unless (rename($tmp_to, $to)) {
  my $saved_bang = $!;
  print STDERR 'U' if $progress;
  unlink($tmp_to) or warn "unlink: $tmp_to: $!"; # Try, possibly in vain, to clean up
  die "rename: $tmp_to -> $from: $saved_bang";
 }
}

# Convert $dev,$ino into a single string where lexical and numeric orderings are equivalent
sub format_inode ($$) {
 my ($dev, $ino) = @_;
 # 64 bits ought to be enough for everybody!
 return sprintf('%016x:%016x', $dev, $ino);
}

# Process all known files so far.
sub merge_files {
 $merges_attempted++;

 my %hash_to_inode;
 # Used to stop link retry loops (there is a goto in here!  Actually two...)
 my %stop_loop;

 my @candidate_list = keys(%inode_to_file_name);
 $input_files += @candidate_list;
 if (@candidate_list < 2) {
  print STDERR "Merging...only one candidate to merge..." if $debug;
  $trivially_unique++;
  goto end_merge;
 }

 print STDERR "Merging...\n" if $debug;
 foreach my $candidate (sort @candidate_list) {
  print STDERR "\tDigesting candidate $candidate\n" if $debug;
  my $ok = 0;
  my $digest;

hash_file:

  foreach my $filename (sort keys(%{$inode_to_file_name{$candidate}})) {
   print STDERR "\t\tDigesting file $filename\n" if $debug;
   if ((-l $filename) || ! -f _) {
    print STDERR "\n" if $progress;
    warn "Bogon file " . tick_quote($filename);
    $input_bogons++;
    delete $inode_to_file_name{$candidate}->{$filename};
    next;
   }
   eval {
    $digest = digest($filename);
   };
   if ($@) {
    warn "Digest($filename)(#$candidate) failed: $@";
    $hash_errors++;
   } else {
    $ok = 1;
    last hash_file;
   }
  }
  if ($ok) {
   print STDERR "\t\tDigest is $digest\n" if $debug;

   my $incumbent_list = ($hash_to_inode{$digest} ||= []);
   my $incumbent_matched = 0;
   for my $incumbent (sort @$incumbent_list) {
    print STDERR "\t\tInodes $incumbent and $candidate have same hash\n" if $debug;

    my $finished = 0;

link_start:

    until ($finished) {
     my @incumbent_names = sort keys(%{$inode_to_file_name{$incumbent}});
     my @candidate_names = sort keys(%{$inode_to_file_name{$candidate}});
     print STDERR "\t\tLinks to $incumbent:", join("\n\t\t\t", '', @incumbent_names), "\n" if $debug;
     print STDERR "\t\tLinks to $candidate:", join("\n\t\t\t", '', @candidate_names), "\n" if $debug;

incumbent_file:

     foreach my $incumbent_file (@incumbent_names) {
      print STDERR 'S' if $progress;
      my ($incumbent_dev,$incumbent_ino,$incumbent_mode,$incumbent_nlink,$incumbent_uid,$incumbent_gid,$incumbent_rdev,$incumbent_size,$incumbent_atime,$incumbent_mtime,$incumbent_ctime,$incumbent_blksize,$incumbent_blocks) = lstat($incumbent_file);
      print STDERR "\t\tINCUMBENT dev=$incumbent_dev ino=$incumbent_ino mode=$incumbent_mode nlink=$incumbent_nlink uid=$incumbent_uid gid=$incumbent_gid rdev=$incumbent_rdev size=$incumbent_size atime=$incumbent_atime mtime=$incumbent_mtime ctime=$incumbent_ctime blksize=$incumbent_blksize blocks=$incumbent_blocks _=$incumbent_file\n" if $debug;

      if (!defined($incumbent_blocks) || ! (-f _)) {
       warn "lstat: $incumbent_file: $!";
       $surprises++;
       next incumbent_file;
      }

      if (format_inode($incumbent_dev, $incumbent_ino) ne $incumbent) {
       warn "$incumbent_file: expected inode $incumbent, found ".format_inode($incumbent_dev, $incumbent_ino);
       $surprises++;
       next incumbent_file;
      }

      my $at_least_one_link_done = 0;

candidate_file:

      foreach my $candidate_file (@candidate_names) {
       print STDERR 's' if $progress;
       my ($candidate_dev,$candidate_ino,$candidate_mode,$candidate_nlink,$candidate_uid,$candidate_gid,$candidate_rdev,$candidate_size,$candidate_atime,$candidate_mtime,$candidate_ctime,$candidate_blksize,$candidate_blocks) = lstat($candidate_file);
       print STDERR "\t\t\tCANDIDATE dev=$candidate_dev ino=$candidate_ino mode=$candidate_mode nlink=$candidate_nlink uid=$candidate_uid gid=$candidate_gid rdev=$candidate_rdev size=$candidate_size atime=$candidate_atime mtime=$candidate_mtime ctime=$candidate_ctime blksize=$candidate_blksize blocks=$candidate_blocks _=$candidate_file\n" if $debug;

       if (!defined($candidate_blocks) || ! (-f _)) {
        warn "lstat: $candidate_file: $!";
        $surprises++;
        next candidate_file;
       }

       if (format_inode($candidate_dev, $candidate_ino) ne $candidate) {
        warn "$candidate_file: expected inode $candidate, found ".format_inode($candidate_dev, $candidate_ino);
        $surprises++;
        next candidate_file;
       }

       if ($candidate_size != $incumbent_size) {
        warn "$candidate_file, $incumbent_file: file sizes are different";
        $surprises++;
        next candidate_file;
       }

       my $identical;

       eval {
        if ($skip_compares) {
         print STDERR "\t\t\t\tSkipping compare!\n" if $debug;
         $identical = 1;
        } else {
         my $quoted_incumbent_file = tick_quote($incumbent_file);
         my $quoted_candidate_file = tick_quote($candidate_file);
         print STDERR "cmp $quoted_incumbent_file $quoted_candidate_file\n" if $debug;
         print STDERR 'C' if $progress;
         if (compare($incumbent_file, $candidate_file)) {
          $compare_differences++;
          $identical = 0;
          # It is significant for two non-identical files to have identical SHA1 or MD5 hashes.
          # Some kind of I/O error is more likely, so this message cannot be turned off.
          # On the other hand, if we're skipping hashes, _all_ files will have the same hash,
          # so the warning in that case is quite silly.  Hmmm.
          print STDERR "$quoted_incumbent_file and $quoted_candidate_file have same hash but do not compare equal!\n" unless $skip_hashes;
         } else {
          $identical = 1;
          $incumbent_matched = 1;
         }
         $compare_count++;
         $compare_bytes += $incumbent_size;
        }
       };
       if ($@) {
        warn $@;
        $compare_errors++;
        next candidate_file;
       }

       if ($identical) {
        print STDERR "\t\t\t\tincumbent_nlink=$incumbent_nlink, candidate_nlink=$candidate_nlink\n" if $debug;

        # We have to do this to break out of a possible infinite loop.
        # Given file A, with hardlinks A1 and A2, and file B, with hardlink B1,
        # such that A1 and B1 are in non-writable directories, we will loop
        # forever hardlinking A2 with A and B.
        # To break the loop, we never attempt to hardlink any files X and Y twice.

        if (defined($stop_loop{$incumbent_file}->{$candidate_file}) ||
           defined($stop_loop{$candidate_file}->{$incumbent_file})) {
         print STDERR "Already considered linking '$incumbent_file' and '$candidate_file', not trying again now\n";
        } else {
         $stop_loop{$incumbent_file}->{$candidate_file} = 1;
         $stop_loop{$candidate_file}->{$incumbent_file} = 1;

         my $link_done = 0;

         my ($from_file, $to_file, $from_inode, $to_inode, $from_nlink, $to_nlink);

         # If the candidate has more links than incumbent, replace incumbent with candidate.
         # If the incumbent has more links than candidate, replace candidate with incumbent.
         # If the link counts are equal, we saw incumbent first, so keep the incumbent.
         # "We saw incumbent first" is significant because we explicitly sort the inodes.
         # Thank Johannes Niess for this idea.
         if ($candidate_nlink > $incumbent_nlink) {
          $from_file = $candidate_file;
          $to_file = $incumbent_file;
          $from_inode = $candidate;
          $to_inode = $incumbent;
          $from_nlink = $candidate_nlink;
          $to_nlink = $incumbent_nlink;
         } else {
          $to_file = $candidate_file;
          $from_file = $incumbent_file;
          $to_inode = $candidate;
          $from_inode = $incumbent;
          $to_nlink = $candidate_nlink;
          $from_nlink = $incumbent_nlink;
         }

         eval {
          link_files($from_file, $to_file);
          $link_done = 1;
         };

         if ($@) {
          warn $@;
          $link_errors++;

          print STDERR "\t\t\t\t...retrying with swapped from/to files...\n" if $debug;
          $link_retries++;

          eval {
           ($from_file, $to_file) = ($to_file, $from_file);
           ($from_inode, $to_inode) = ($to_inode, $from_inode);
           ($from_nlink, $to_nlink) = ($to_nlink, $from_nlink);
           link_files($from_file, $to_file);
           $link_done = 1;
          };

          if ($@) {
           warn $@;
           $link_errors++;
          }
         }

         # Note since the files are presumably identical, they both have the same size.
         # My random number generator chooses the incumbent's size.

         if ($link_done) {
          delete $inode_to_file_name{$to_inode}->{$to_file};
          $inode_to_file_name{$from_inode}->{$to_file} = undef unless ($dry_run);
          $hash_to_inode{$digest} = [ $from_inode ];

          $hard_links++;
          if ($to_nlink == 1) {
           $recovered_files++;
           $recovered_bytes += $incumbent_size;
          }

          # FIXME:  Now we're really confused for some reason.
          # Start over to rebuild state.
          next link_start;
         } else {
          warn "Could not hardlink '$incumbent_file' and '$candidate_file'";

          # FIXME:  This is a lame heuristic.  We really need to know if we've
          # tried all possible ways to hardlink the file out of existence first;
          # however, that is complex and only benefits a silly statistic.
          if ($to_nlink == 1 || $from_nlink == 1) {
           $lost_files++;
           $lost_bytes += $incumbent_size;
          }
         }
        }
       }
      }
     }
     $finished = 1;
    }
   }
   unless ($incumbent_matched) {
    print STDERR "\t\tNew hash entered\n" if $debug;
    push(@$incumbent_list, $candidate);
   }
  } else {
   warn "No digests found for inode $candidate\n";
   delete $inode_to_file_name{$candidate};
  }
 }
 print STDERR '.' if $progress;

end_merge:

 print STDERR "Merge done.\n" if $debug;
 undef %inode_to_file_name;
}

my $last_time = 0;
my $last_size = 0;

while () {
 my ($weak_key, $size, $dev, $ino, $name) = m/^((\d+) \d+ \d+ \d+ -?[\d.]+) (\d+) (\d+) (.+)\0$/so;
 die "read error: $!\nLast input line was '$_'" unless defined($name);

 my $inode = format_inode($dev, $ino);

 print STDERR "weak_key=$weak_key inode=$inode name=$name\n" if $debug;

 if ($skip_hashes_threshold && $size >= $skip_hashes_threshold) {
  $skip_hashes = 1;
  $skip_compares = 0;
 } else {
  $skip_hashes = 0;
  $skip_compares = $skip_compare_preference;
 }

 if ($progress) {
  my $this_time = time();
  if ($this_time != $last_time && $size != $last_size) {
   $last_time = $this_time;
   $last_size = $size;
   print STDERR "($size)";
  }
 }

 $input_links++;
 merge_files if $weak_key ne $current_key;
 $current_key = $weak_key;

 $inode_to_file_name{$inode}->{$name} = undef;

 print STDERR "$name\n" if $verbose;
}

merge_files;

my $stats_blob = <
compare_bytes           $compare_bytes
compare_count           $compare_count
compare_differences     $compare_differences
compare_errors          $compare_errors
hard_links              $hard_links
hash_bytes              $hash_bytes
hash_errors             $hash_errors
hash_files              $hash_files
input_bogons            $input_bogons
input_files             $input_files
input_links             $input_links
link_errors             $link_errors
link_retries            $link_retries
lost_bytes              $lost_bytes
lost_files              $lost_files
merges_attempted        $merges_attempted
recovered_bytes         $recovered_bytes
recovered_files         $recovered_files
surprises               $surprises
trivially_unique        $trivially_unique
STATS

if ($humane) {
 my $max_num_len = 0;

 sub measure_numbers {
  my ($num) = @_;
  my $len = length($num);
  $len += int( (length($num) - 1) / 3);
  $max_num_len = $len if $len > $max_num_len;
 }

 (my $dummy = $stats_blob) =~ s/\d+/measure_numbers($&)/geos;

 sub space_numbers {
  my ($num) = @_;
  1 while $num =~ s/(\d)(\d\d\d)((?: \d\d\d)*)$/$1 $2$3/os;
  $num = ' ' x ($max_num_len - length($num)) . $num;
  return $num;
 }

 $stats_blob =~ s/\d+/space_numbers($&)/geos;
}

$stats_blob =~ s/([^\n]*\n[^\n]*? )(\s+)( [^\n]*\n)/$1 . ('.' x length($2)) . $3/oemg;

print STDERR "\n" if $progress;
print STDERR $stats_blob;

exit(0);

__END__
```
