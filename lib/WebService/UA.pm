package WebService::UA;
# ABSTRACT: HTTP useragent abstraction for webservices
use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

WebService::UA - common API for making HTTP requests to webservices

=head1 SYNOPSIS

 use WebService::Amazon::DynamoDB;
 use WebService::UA::NaHTTP;
 use Data::Dumper;
 my $ua = WebService::UA::NaHTTP->new;
 print Dumper(WebService::Amazon::DynamoDB->new(
  ua => $ua,
 )->describe_table(...)->get);

=head1 DESCRIPTION

=head1 METHODS

=cut

=head2 new

Instantiate.

=cut

sub new { my $class = shift; bless { @_ }, $class }

sub parallel { 0 }

sub timeout { 60 }

sub request { ... }

sub ssl_args { () }

1;

__END__

=head1 SEE ALSO

=head1 AUTHOR

Tom Molesworth <cpan@perlsite.co.uk>

=head1 LICENSE

Copyright Tom Molesworth 2013-2015. Licensed under the same terms as Perl itself.

