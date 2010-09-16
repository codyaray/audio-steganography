filename = '../../sounds/output.wav';

in = fopen(filename,'r'); 
header = fread(in,40,'uint8=>char');
data_size = fread(in,1,'uint32');
[data,count]=fread(in,inf,'uint16');
fclose(in);

identity = bitget(data(1:8),1)';
if identity == [1 0 1 0 1 0 1 0]
    % recover the data size (9-28)
    m = zeros(10,1);
    n = zeros(10,1);
    len = zeros(20,1);
    m(1:10) = bitget(data(9:18),1);
    n(1:10) = bitget(data(19:28),1);
    len = bi2de(m')*bi2de(n');
    
    % recover the message (29-*)
    msg_bin = zeros(len,1);
    msg_bin(1:len) = bitget(data(29:28+len),1);
    msg_bin = reshape(msg_bin,len/8,8);
    msg_double = bi2de(msg_bin_re);
    secmsg = char(msg_double)'
end