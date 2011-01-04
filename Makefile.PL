#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

requires 'Module::Setup' => '0.09';

## Note:  The following dependencies are not used by the installed Flavor but
## are used by the module you bootstap with it.
#
requires 'Module::Install' => '1.00';
requires 'Module::Install::ReadmeMarkdownFromPod' => '0.03';
requires 'Module::Install::AutoLicense' => '0.08';
requires 'Module::Install::Repository' => '0.06';
requires 'Module::Install::Homepage' => '0.01';

test_requires 'Test::More' => '0.96';
all_from 'lib/Module/Setup/Flavor/JJNAPIORK.pm';
require 'maint/Makefile.PL.include'
  unless -e 'META.yml';

WriteAll;

