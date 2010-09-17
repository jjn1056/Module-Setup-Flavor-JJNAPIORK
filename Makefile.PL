#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install 1.00;
all_from 'lib/Module/Setup/Flavor/JJNAPIORK.pm';

requires 'Module::Setup::Flavor';
test_requires 'Test::More';

readme_markdown_from_pod;
auto_set_repository;
auto_set_homepage;
auto_manifest;
auto_license;
auto_install;
WriteAll;

