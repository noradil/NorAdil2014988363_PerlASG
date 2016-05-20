use IO::Socket::SSL;
 
# auto-flush on socket
$| = 1;
 
# creating a listening socket
my $socket = IO::Socket::SSL->new (
    LocalHost => '0.0.0.0',
    LocalPort => '7777',
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1,
    SSL_cert_file=> 'ca.crt',
    SSL_key_file=> 'ca.key',
);
die "Unable to create socket $!\n" unless $socket;
print "Server is waiting for client connection on port 7777\n";
 
while(1)
{
    # waiting for a new client connection
    my $client_socket = $socket->accept();
 
    # get information about a newly connected client
    my $client_address = $client_socket->peerhost();
    my $client_port = $client_socket->peerport();
    print "Connection called from : $client_address:$client_port\n";
 
    # read characters from the connected client
    my $data = "";
    $client_socket->read($data, 1024);
    print "Received data: $data\n";
 
    # write response data to the connected client
    $data = "Ok";
    $client_socket->syswrite($data);
 
    # notify client that response has been sent
    shutdown($client_socket, 1);
}
 
$socket->close();