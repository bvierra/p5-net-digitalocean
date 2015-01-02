package Net::DigitalOcean::Role::UserAgent;

use DateTime;
use HTTP::Status qw(:constants :is status_message);
use JSON();
use LWP::UserAgent;
use Modern::Perl;
use Moo::Role;
use MooX::Types::MooseLike::Base qw(:all);
use utf8;


has ua => (
  is => 'lazy'
);

has agent => (
  isa     => Str,
  is      => 'rw',
  default => 'Net::DigitalOcean/'
);

sub _build_ua {
  my ($self) = @_;
  
  my $version = __PACKAGE__->VERSION || 'devel';
  my $ua = LWP::UserAgent->new(
    agent => $self->agent
  );

  $ua->default_header('Authorization' => 'Bearer ' . $self->token);
  $ua->default_header('Content-Type' => 'application/json; charset=utf-8');

  return $ua;
}

sub make_request {
    my ($self, $method, $uri, $data) = @_;

    my $response = $self->ua->request(
        HTTP::Request->new(
            $method,
            $self->api_base_url . $uri,
            undef,
            $data ? JSON::encode_json($data) : undef
        )
    );

    my $result = {
        response_object => $response,
        is_success      => $response->is_success,
        status_line     => $response->status_line,
        status_code     => $response->code
    };

    if ($response->content_type eq 'application/json') {
        my $decoded_response = JSON::decode_json($response->decoded_content);

        if (is_HashRef($decoded_response)) {
            $result->{meta}  = delete $decoded_response->{meta};
            $result->{links} = delete $decoded_response->{links};

            if (keys(%$decoded_response) == 1) {
                my @key = keys %$decoded_response;
                $result->{content} = delete $decoded_response->{$key[0]};
            }
            else {
                $result->{content} = $decoded_response;
            }
        }
        else {
            $result->{content} = $decoded_response;
        }
    }

    if (my $ratelimit = $response->header('RateLimit-Limit')) {
        $result->{ratelimit} = {
            limit     => $ratelimit,
            remaining => $response->header('RateLimit-Remaining'),
            reset     => DateTime->from_epoch(
                epoch => $response->header('RateLimit-Reset')
            ),
        };
    }

    return $result;
}

1;
