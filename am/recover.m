[x,fs1] = wavread('../../sounds/input.wav');
[w,fs2] = wavread('../../sounds/output.wav');

len = length(x);
msg = [1 0 1 0 1 0 1 0];
msg_len = length(msg);
blk_len = floor(len/msg_len);

for K=1:blk_len:(msg_len*blk_len)
    x(K:(K-1)+blk_len) = .98*x(K:(K-1)+blk_len);
    if (abs(w(K:(K-1)+blk_len)) >= abs(x(K:(K-1)+blk_len)))
        1
    else
        0
    end
end

subplot(2,1,1), plot(x)
title('input waveform')
xlabel('sample [n]')
ylabel('magnitude')

subplot(2,1,2), plot(out)
title('output waveform')
xlabel('sample [n]')
ylabel('magnitude')