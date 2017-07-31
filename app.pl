use Mojolicious::Lite;
use Data::Dumper;
use JSON;
use JSON::XS 'decode_json';
use Lib::Database;

hook(before_dispatch => sub {
	my $self = shift;

	$self->res->headers->header('Access-Control-Allow-Origin'=> '*');
	$self->res->headers->header('Access-Control-Allow-Credentials' => 'true');
	$self->res->headers->header('Access-Control-Allow-Methods' => 'GET, OPTIONS, POST, DELETE, PUT');
	$self->res->headers->header('Access-Control-Allow-Headers' => 'Content-Type, X-CSRF-Token');
	$self->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
	$self->res->headers->header('Access-Control-Max-Age' => '1728000');
	#$self->respond_to(any => { data => '', status => 200 });
});

get '/' => sub {
	my $c = shift;
	my $db = 'Lib::Database'; my $odb= $db->new(); my $conn = $odb->getConnection();
	my $docs = $conn->get_collection('criadores')->find();
	my @rpta;
   while (my $d = $docs->next) {
       $d->{'_id'} = $d->{'_id'} . '';
       push @rpta, $d;
   }
   my $json_text = to_json \@rpta;
   
  	$c->render(text => ("$json_text"));
};

app->start;