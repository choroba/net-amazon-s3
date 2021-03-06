
use strict;
use warnings;

use Test::More tests => 5;
use Test::Deep;
use Test::Warnings qw[ :no_end_test had_no_warnings ];

use Shared::Examples::Net::Amazon::S3::Client (
    qw[ with_response_fixture ],
    qw[ expect_client_object_delete ],
);

expect_client_object_delete 'delete object' => (
    with_bucket             => 'some-bucket',
    with_key                => 'some-key',
    expect_request          => { DELETE => 'https://some-bucket.s3.amazonaws.com/some-key' },
    expect_data             => bool (1),
);

expect_client_object_delete 'error access denied' => (
    with_bucket             => 'some-bucket',
    with_key                => 'some-key',
    with_response_fixture ('error::access_denied'),
    expect_request          => { DELETE => 'https://some-bucket.s3.amazonaws.com/some-key' },
    throws                  => qr/^AccessDenied: Access denied error message/,
);

expect_client_object_delete 'error no such bucket' => (
    with_bucket             => 'some-bucket',
    with_key                => 'some-key',
    with_response_fixture ('error::no_such_bucket'),
    expect_request          => { DELETE => 'https://some-bucket.s3.amazonaws.com/some-key' },
    throws                  => qr/^NoSuchBucket: No such bucket error message/,
);

expect_client_object_delete 'error no such key' => (
    with_bucket             => 'some-bucket',
    with_key                => 'some-key',
    with_response_fixture ('error::no_such_key'),
    expect_request          => { DELETE => 'https://some-bucket.s3.amazonaws.com/some-key' },
    throws                  => qr/^NoSuchKey: No such key error message/,
);

had_no_warnings;
