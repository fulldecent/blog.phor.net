---
title: "NPM zero-day: npm installation runs unspecified scripts with shell access"
tags: ["zero-day"]
old-link: https://privacylog.blogspot.com/2021/09/npm-zero-day-npm-installation-runs.html
---

## Description

The `npm install` action (i.e. npm-install) runs scripts  with shell access that are undefined behavior. These can be parlayed for privilege escalation and unauthorized access.

## Steps to reproduce

(Add details for how we can reproduce the issue)

1. Create a clean test directory

   ```shell
   mkdir ~/tmp2 && cd ~/tmp2
   ```

2. Inject the proof of concept evil script

   ```shell
   echo '{"scripts": {"prepare": "echo you have been hacked rm -rf /"}}' > package.json
   ```

3. Run the should-be-innocuous install command

   ```shell
   npm install
   ```

## Expected outcome

The expected outcome is documented at <https://docs.npmjs.com/cli/v7/commands/npm-install> under the appropriate bullet “npm install (in a package directory, no arguments):”

According to specification, this should only install dependencies (of which there are none) and no script is specified to run.

Compare this to the specification which only specifically applies for “npm install :”

> If the package being installed contains a prepare script, its dependencies and devDependencies will be installed, and the prepare script will be run, before the package is packaged and installed.

Aside from the individual specifications which apply to “npm install  (in a package directory, no arguments):” and to “npm install :”, there is more more general specification which indicates any script  will be run, including the “prepare” script for the “npm install (in a  package directory, no arguments):” action.

## Actual outcome

The script `prepare` is run, producing the output

> you have been hacked rm -rf /

And this obviously demonstrates that a script is being run locally with shell access.

Yes, it is well known that `rm -rf /` doesn’t really  format a hard drive, especially if it is not run as root. But for  illustration the point is sufficiently demonstrated.

## Note on severity

The example above is simple to read and, given the specification for  “npm install”, is not expected to have any access to local shell  environment. Anybody could run that `npm install` command  expecting it to be a null operation, or, with the addition of some  dependencies, may reasonably expect the script to only perform  installations of possibly well-known code from respected sources.

However, because of the vulnerability, the script which is reasonably expected to only install dependencies also has access to local shell.  This is a Privilege Escalation. If the example were upstream, this might also be called Code Injection or Resource Injection because the defined behavior is installation of dependencies without running scripts and  the actual behavior does run a script.

## Disclosure timeline

- 2021-07-19 Reported to GitHub through through HackerOne

- 2021-07-20 Vendor explained that this behavior is "expected" even though it is undocumented

Thanks for the submission! This is an intentional design  decision and is working as expected. We may make this functionality more strict in the future, but don't have anything to announce right now. As a result, this is not eligible for reward under the Bug Bounty program.

As documented in the --ignore-scripts option documentation, scripts in a  package.json file are run by default. If one does not want the scripts  as defined in the package.json to be executed, one can set the option  npm install --ignore-scripts. While we may make it more clear in the npm install documentation that the scripts are run by default, we have  nothing further to announce at this time.

- 2021-09-25 I made the final post

I have cited specifically in the documentation where the npm  install command is specified. For the condition "in a package directory, no arguments", it is not specified that any scripts are run.

The note that you have referenced is not normative on the npm install  command because it is not referenced from the npm install command  documentation. Furthermore, even if it were normative, the note you have mentioned does NOT state "file are run by default" as you claim. Your  interpretation relies on "Fallacy of the Inverse" which is not a valid  logical deduction.

You may have "expectations"  that this is working correctly, but those "expectations" are not based  on the actual documentation as written.

- 2021-09-29 Published to Privacy Log
