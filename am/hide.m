% Use amplitude modulation to embed a given binary message
% Must be modified slightly for stereo sound

msg = [1 0 1 0 1 0 1 0];
[in,fs,n] = wavread('../../sounds/input.wav'); 

sig_len = length(in);
msg_len = length(msg);
out = zeros(sig_len,1);
blk = floor(sig_len/msg_len);
cnt = 1;

for K=1:blk:(msg_len*blk)
    if (msg(cnt) == 1)
        % Apply AM scale corresponding to message
        % Scale by .98 if bit='0' and .99 if bit='1' , 
        out(K:(K-1)+blk) = .99*in(K:(K-1)+blk);
    else
        out(K:(K-1)+blk) = .98*in(K:(K-1)+blk); 
    end
    cnt = cnt+1;
end

wavwrite(out,fs,'../../sounds/output.wav');