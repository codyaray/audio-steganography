msg_txt = 'my secret';
infile = '../../sounds/input_mono.wav';
outfile = '../../sounds/output.wav';

% header = 0-40, data size = 41-43, data = 44-*
in = fopen(infile,'r');
header = fread(in,40,'uint8=>char');
data_size = fread(in,1,'uint32');
[data,count] = fread(in,inf,'uint16');
fclose(in);

% convert message to binary
msg_double = double(msg_txt);
msg_bin = de2bi(msg_double,8);
[m,n] = size(msg_bin);
msg = reshape(msg_bin,m*n,1);
m = de2bi(m,10)';
n = de2bi(n,10)';
len = length(msg);
len_bin = de2bi(len,20)';

% code identity (1-8)
identity = [1 0 1 0 1 0 1 0]';
data(1:8) = bitset(data(1:8),1,identity(1:8));

% code message length (9-28)
data(9:18) = bitset(data(9:18),1,m(1:10));
data(19:28) = bitset(data(19:28),1,n(1:10));

% code message data (29-*)
data(29:28+len)=bitset(data(29:28+len),1,msg_bin(1:len)');

out = fopen(outfile,'w');

% write out the header stuff and "dirty" data
fwrite(out,header,'uint8');
fwrite(out,data_size,'uint32');
fwrite(out,data,'uint16');
fclose(out);

% plots input/output

[x,fs1] = wavread(infile);
subplot(2,1,1), plot(x)
title('input waveform')
xlabel('sample [n]')
ylabel('magnitude')

[out,fs2] = wavread(outfile);
subplot(2,1,2), plot(out)
title('output waveform')
xlabel('sample [n]')
ylabel('magnitude')
