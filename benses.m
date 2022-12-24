clc
clear all
[tel,fs] = audioread('ses.wav');
n=11;
d = floor(length(tel)/n);
id=zeros(n,1);
for c=(1:n)
    k=(c-1)*d;
    tel1=tel(k+1:k+d);
    Y = fft(tel1);
    P2=abs(Y/d);
    t=(1:d/2);
    P1 = P2(t);
    
    f = fs*(t)/d;
    figure(c);
    plot(f,P1)
    max=0;
    u=1;
    max_second=0;
    last=0;
    for i =(1:length(P1))
        tmp=P1(i);
        if((P1(i)>0.05) && (P1(i+1)<0.05))
            id(c,u)=f(i);
            u=u+1;
        end
    end
    if(id(c,1)>id(c,2))
        tmp=id(c,1);
        id(c,1)=id(c,2);
        id(c,2)=tmp;
    end
end
sat(1)=697;
sat(2)=770;
sat(3)=852;
sat(4)=941;
sat(5)=1209;
sat(6)=1336;
sat(7)=1477;
ch(1,1)='1';
ch(1,2)='2';
ch(1,3)='3';
ch(2,1)='4';
ch(2,2)='5';
ch(2,3)='6';
ch(3,1)='7';
ch(3,2)='8';
ch(3,3)='9';
ch(4,1)='*';
ch(4,2)='0';
ch(4,3)='#';

min_id=zeros(7,2);
for c=(1:n)
    for k=(1:2)
        mins=sat(7);
        mina=0;
        for i=(1:7)
        mina=abs(id(c,k)-sat(i));
            if(mins>mina)
                mins=mina;
                min_id(c,k)=i;
            end
        end
    end
    fprintf("%c ",ch(min_id(c,1) ,min_id(c,2)-4 ));
end

