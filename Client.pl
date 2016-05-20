use IO::Socket::SSL;
 
# auto-flush on socket
$| = 1;
 
# create a connecting socket
my $socket = IO::Socket::SSL->new (
    PeerHost => 'LocalHost',
    PeerPort => '7777',
    Proto => 'tcp',
);
die "Cannot connect to the server $!\n" unless $socket;
print "Server reply: connection established\n";
 
# data to send to a server
my $str = "Hello Server";
my $req = $socket->syswrite($str); 
print "The word $str has been sent to the Server\n"; 
 
# notify server that request has been sent
shutdown($socket, 1);
 
# receive a response from server
my $response = " ";
$socket->read($response, 1024);
print "Received response: $response\n";
 
$socket->close();
