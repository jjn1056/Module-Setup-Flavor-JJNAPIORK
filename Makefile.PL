#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

requires 'Module::Setup::Flavor';
test_requires 'Test::More';

all_from 'lib/Module/Setup/Flavor/JJNAPIORK.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

WriteAll;

