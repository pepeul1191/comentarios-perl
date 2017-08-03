package Lib::Database;
use MongoDB;
use utf8;
binmode STDOUT, ":encoding(utf8)";


sub new {
    my $class = shift;
    my $userid = "";
    my $password = "";
    my $client = MongoDB->connect("mongodb://192.168.1.3");
    my $db = $client->get_database("db_monta");
    my $self = {
        _db => $db
    };

    bless $self, $class;
    return $self;
}

sub getConnection {
    my( $self ) = @_;
    return $self->{_db};
}

1;