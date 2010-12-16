#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

requires 'Module::Setup' => '0.09';
test_requires 'Test::More' => '0.96';

all_from 'lib/Module/Setup/Flavor/JJNAPIORK.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

WriteAll;

