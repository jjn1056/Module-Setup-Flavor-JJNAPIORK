package Module::Setup::Flavor::JJNAPIORK;
use base 'Module::Setup::Flavor';

use 5.008005;
use strict;
use warnings FATAL => 'all';

our $VERSION = '0.05';

1;

=head1 NAME

Module::Setup::Flavor::JJNAPIORK - How I use Module::Setup

=head1 SYNOPSIS

    module-setup --flavor-class=JJNAPIORK MyApp

=head1 DESCRIPTION

This is a custom flavor for using L<Module::Setup> so that I can just build
a default project skeleton that comes out reasonable close to the way I expect
it to be.  That way I can avoid copying files around from an existing good
module or running C<module-setup> and then having to delete and massage a lot
of things.

=head1 AUTHOR

John Napiorkowski C< <<jjnapiork@cpan.org>> >

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski

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
  use warnings FATAL =>'all';
  use inc::Module::Install 1.00;
  all_from 'lib/[% module_unix_path %].pm';
  
  requires ''; ## Add project dependencies
  test_requires 'Test::More' => '0.96';

  require 'maint/Makefile.PL.include'
    unless -e 'META.yml';

  WriteAll;
---
file: lib/____var-module_path-var____.pm
template: |
  package [% module %];

  use 5.008008;
  use strict;
  use warnings FATAL =>'all';

  our $VERSION = '0.01';
  
  1;

  =head1 NAME
  
  [% module %] - My Brand New Module
  
  =head1 SYNOPSIS
  
    use [% module %];
  
  =head1 DESCRIPTION
  
  [% module %] is ...
  
  =head1 AUTHOR
  
  [% config.author %] L<email:[% config.email %]>
  
  =head1 SEE ALSO

      TBD
  
  =head1 COPYRIGHT & LICENSE

  Copyright 2011, [% config.author %] L<email:[% config.email %]> 
  
  This library is free software; you can redistribute it and/or modify
  it under the same terms as Perl itself.
  
  =cut
---
file: maint/Makefile.PL.include
template: |
  BEGIN {
    my @modules = qw(
      ReadmeMarkdownFromPod
      AutoLicense
      Repository
      Homepage
    );
    for my $module (@modules) {
      eval "use Module::Install::$module; 1"
  	  || die <<"ERR";

  You are in author mode but are missing Module::Install::$module

  You are getting an error message because you are in author mode and are missing
  some author only dependencies.  You should only see this message if you have 
  checked this code out from a repository.  If you are just trying to install
  the code please use the CPAN version.  If you are an author you will need to
  install the missing modules, or you can bootstrap all the requirements using
  Task::BeLike::JJNAPIORK with:

    cpanm Task::BeLike::JJNAPIORK

  If you think you are seeing this this message in error, please report it as a
  bug to the author.

  ERR
    }
  }

  readme_markdown_from_pod;
  auto_license;
  auto_set_repository;
  auto_set_homepage;
  auto_install;

  sub manifest_include {
    my @files = @_;
    my @parts;
    while (my ($dir, $spec) = splice(@files, 0, 2)) {
      my $re = ($dir ? $dir.'/' : '').
        ((ref($spec) eq 'Regexp')
          ? $spec
          : !ref($spec)
            ? ".*\Q${spec}\E"
            : die "spec must be string or regexp, was: ${spec} (${\ref $spec})");
      push @parts, $re;
    }
    my $final = '^(?!'.join('|', map "${_}\$", @parts).')';
    open(my $skip, '>', 'MANIFEST.SKIP') or die "trouble $!";
    print $skip "${final}\n";
    close $skip;
  }

  manifest_include(
    'lib' => '.pm',
    'inc' => '.pm',
    't' => '.t',
    't/lib' => '.pm',
    'xt' => '.t',
    'xt/lib' => '.pm',
    'script' => qr{.pl|.psgi},
    '' => qr{([^/]+).PL},
    '' => qr{Changes|MANIFEST|README|META\.yml},
  );

  postamble <<"EOP";
  create_distdir: manifest_clean manifest

  distclean :: manifest_clean manifest_skip_clean

  manifest_clean:
  \t\$(RM_F) MANIFEST

  manifest_skip_clean:
  \t\$(RM_F) MANIFEST.SKIP
  EOP
---
file: t/use.t
template: |
  use strict;
  use warnings FATAL =>'all';
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


