package WebService::Async::UserAgent;
# ABSTRACT: HTTP useragent abstraction for webservices
use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

WebService::Async::UserAgent - common API for making HTTP requests to webservices

=head1 SYNOPSIS

 use WebService::Amazon::DynamoDB;
 use WebService::Async::UserAgent::NaHTTP;
 use Data::Dumper;
 my $ua = WebService::Async::UserAgent::NaHTTP->new;
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

sub get {
	my ($self, $uri) = @_;
	$uri = URI->new($uri) unless ref $uri;
	my $req = HTTP::Request->new(
		GET => $uri
	);
	$self->request($req)
}

sub user_agent { $_[0]->{user_agent} //= "Mozilla/5.0 (Perl) $_[0]" }

sub ssl_args { () }

1;

__END__

=head1 SEE ALSO

=head1 AUTHOR

Tom Molesworth <cpan@perlsite.co.uk>

=head1 LICENSE

Copyright Tom Molesworth 2013-2015. Licensed under the same terms as Perl itself.

