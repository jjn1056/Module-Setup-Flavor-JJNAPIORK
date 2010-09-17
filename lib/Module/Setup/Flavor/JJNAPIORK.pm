package Module::Setup::Flavor::JJNAPIORK;
use base 'Module::Setup::Flavor';

use 5.008008;
use strict;
use warnings;

our $VERSION = '0.01';

1;

=head1 NAME

Module::Setup::Flavor::JJNAPIORK - How I use Module::Setup

=head1 SYNOPSIS

    module-setup  --direct --flavor-class=JJNAPIORK MyApp 

=head1 DESCRIPTION

This is a custom flavor for using L<Module::Setup> so that I can just build
a default project skeleton that comes out reasonable close to the way I expect
it to be.  That way I can avoid copying files around from an existing good
module or running C<module-setup> and then having to delete and massage a lot
of things.

=head1 AUTHOR

John Napiorkowski C< <<jjnapiork@cpan.org>> >

=head1 COPYRIGHT & LICENSE

Copyright 2010, John Napiorkowski

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

__DATA__
---
file: Changes
template: |
  Revision history for Perl extension [% module %]
  
  0.01    [% localtime %]
          - original version
---
file: Makefile.PL
template: |
  #!/usr/bin/env perl

  use strict;
  use warnings;
  use inc::Module::Install 1.00;
  name '[% dist %]';
  all_from 'lib/[% module_unix_path %].pm';
  
  requires ''; ## Add project dependencies
  test_requires 'Test::More';  
  tests 't/*.t';
  
  readme_markdown_from_pod;
  auto_set_repository;
  auto_set_homepage;
  auto_manifest;
  auto_license;
  auto_install;
  WriteAll;
---
file: MANIFEST.SKIP
template: |
  \bRCS\b
  \bCVS\b
  ^MANIFEST\.
  ^MANIFEST\.SKIP$
  ^MANIFEST\.bak$
  ^Makefile$
  ~$
  ^#
  \.old$
  ^blib/
  ^pm_to_blib
  ^MakeMaker-\d
  \.gz$
  \.cvsignore
  ^t/9\d_.*\.t
  ^t/perlcritic
  ^tools/
  \.svn/
  ^\.shipit$
  ^\.git/
  ^\.gitignore
  ^\.gitmodules
  \.sw[po]$
  \.DS_Store$
  ^core$
  ^out$
---
file: lib/____var-module_path-var____.pm
template: |
  package [% module %];

  use 5.008008;
  use strict;
  use warnings;

  our $VERSION = '0.01';
  
  1;
  __END__
  
  =head1 NAME
  
  [% module %] - My Brand New Module
  
  =head1 SYNOPSIS
  
    use [% module %];
  
  =head1 DESCRIPTION
  
  [% module %] is ...
  
  =head1 AUTHOR
  
  [% config.author %] E<lt>[% config.email %]E<gt>
  
  =head1 SEE ALSO
  
  =head1 COPYRIGHT & LICENSE

  Copyright 2010, John Napiorkowski
  
  This library is free software; you can redistribute it and/or modify
  it under the same terms as Perl itself.
  
  =cut
---
file: t/use.t
template: |
  use strict;
  use Test::More tests => 1;
  
  BEGIN { use_ok '[% module %]' }
---
config:
  author: John Napiorkowski
  class: Module::Setup::Flavor::Default
  email: jjnapiork@cpan.org
  plugins:
    - Config::Basic
    - Template
    - Test::Makefile
    - Additional
    - VC::Git



