
use strict;
use warnings;

use Test::More tests => 5;
use Test::Warnings qw[ :no_end_test had_no_warnings ];

use Shared::Examples::Net::Amazon::S3::Request (
    qw[ behaves_like_net_amazon_s3_request ],
);

behaves_like_net_amazon_s3_request 'initiate multipart upload' => (
    request_class   => 'Net::Amazon::S3::Request::InitiateMultipartUpload',
    with_bucket     => 'some-bucket',
    with_key        => 'some/key',

    expect_request_method   => 'POST',
    expect_request_uri      => 'https://some-bucket.s3.amazonaws.com/some/key?uploads',
    expect_request_headers  => { },
    expect_request_content  => '',
);

behaves_like_net_amazon_s3_request 'initiate multipart upload with acl' => (
    request_class   => 'Net::Amazon::S3::Request::InitiateMultipartUpload',
    with_bucket     => 'some-bucket',
    with_key        => 'some/key',
    with_acl_short  => 'private',

    expect_request_method   => 'POST',
    expect_request_uri      => 'https://some-bucket.s3.amazonaws.com/some/key?uploads',
    expect_request_headers  => { 'x-amz-acl' => 'private' },
    expect_request_content  => '',
);

behaves_like_net_amazon_s3_request 'initiate multipart upload with service side encryption' => (
    request_class   => 'Net::Amazon::S3::Request::InitiateMultipartUpload',
    with_bucket     => 'some-bucket',
    with_key        => 'some/key',
    with_encryption => 'AES256',

    expect_request_method   => 'POST',
    expect_request_uri      => 'https://some-bucket.s3.amazonaws.com/some/key?uploads',
    expect_request_headers  => { 'x-amz-server-side-encryption' => 'AES256' },
    expect_request_content  => '',
);

behaves_like_net_amazon_s3_request 'initiate multipart upload with headers' => (
    request_class   => 'Net::Amazon::S3::Request::InitiateMultipartUpload',
    with_bucket     => 'some-bucket',
    with_key        => 'some/key',
    with_headers    => { 'x-amz-meta-test' => 99 },

    expect_request_method   => 'POST',
    expect_request_path     => 'some-bucket/some/key?uploads',
    expect_request_headers  => { 'x-amz-meta-test' => 99 },
    expect_request_content  => '',
);

had_no_warnings;
