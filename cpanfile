requires 'parent', 0;
requires 'Future', '>= 0.30';
requires 'URI', 0;
requires 'HTTP::Request', 0;
requires 'HTTP::Response', 0;

recommends 'IO::Async', '>= 0.64';
recommends 'Net::Async::HTTP', '>= 0.36';

on 'test' => sub {
	requires 'Test::More', '>= 0.98';
	requires 'Test::Fatal', '>= 0.010';
	requires 'Test::Refcount', '>= 0.07';
};

