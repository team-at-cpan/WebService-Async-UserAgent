package WebService::Async::UserAgent::MojoUA;

use strict;
use warnings;

=head1 NAME

WebService::Async::UserAgent::MojoUA - make requests using L<Mojo::UserAgent>

=head1 DESCRIPTION

Provides a L</request> method which will use L<Mojo::UA> to make
requests and return a L<Future> containing the result. Used internally by
L<WebService::Async::UserAgent>.

=cut

use Future;
use Mojo::UserAgent;

=head2 new

Instantiate.

=cut

sub new { my $class = shift; bless {@_}, $class }

=head2 request

Issues the request. Expects a single L<HTTP::Request> object,
and returns a L<Future> which will resolve to the decoded
response content on success, or the failure reason on failure.

=cut

sub request {
	my $self = shift;
	my $req = shift;
	my $method = lc $req->method;
	my $resp = $self->ua->$method(''.$req->uri => { map {; $_ => ''.$req->header($_) } $req->header_field_names } => $req->content);
	if(my $res = $resp->success) {
		return Future->done($res->body)
	}

	my $status = join ' ', $resp->error;
	return Future->fail($status, $resp, $req)
}

=head2 ua

Returns the L<LWP::UserAgent> instance.

=cut

sub ua { shift->{ua} ||= Mojo::UserAgent->new }

1;

=head1 AUTHOR

Tom Molesworth <cpan@perlsite.co.uk>

=head1 LICENSE

Copyright Tom Molesworth 2012-2013. Licensed under the same terms as Perl itself.

