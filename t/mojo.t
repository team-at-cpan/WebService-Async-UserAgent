use strict;
use warnings;

use Test::More;
use Test::Fatal;

BEGIN {
	eval {
		require IO::Async::Loop;
		require Mojo::UserAgent;
	} or do {
		plan skip_all => 'needs IO::Async and Mojo::UserAgent to test';
	}
}

use WebService::Async::UserAgent::MojoUA;

my $loop = IO::Async::Loop->new;
my $ua = new_ok('WebService::Async::UserAgent::MojoUA', [
]);

my $listener = $loop->listen(
	addr => {
		family => 'inet',
		socktype => 'stream',
		ip => '127.0.0.1',
		port => 0,
	},
	on_stream => sub {
		my ($stream) = @_;
		$stream->configure(
			on_read => sub {
				my ($stream, $buf, $eof) = @_;
				$stream->debug_printf("Had line: %s", $1) while $$buf =~ s/^(.+)\x0D\x0A//;
				if($$buf =~ s/^\x0D\x0A//) {
					$stream->write(
						join "\x0D\x0A",
							"HTTP/1.1 200 OK",
							"Host: localhost",
							"Content-Length: 4",
							"Content-Type: text/plain",
							"",
							"test"
					);
					$stream->close;
				}
			}
		);
		$loop->add($stream);
	}
)->get;

my $port = $listener->read_handle->sockport;

$loop->spawn_child(
	code => sub {
		is(exception {
			$ua->get(
				'http://127.0.0.1:' . $port
			)->get
		}, undef, 'no exception on GET');
	},
	setup => [
		stdin => \*STDIN,
		stdout => \*STDOUT,
		stderr => \*STDERR,
	],
	on_exit => sub {
		pass('child returned');
		$loop->stop;
	}
);
$loop->run;

done_testing;
