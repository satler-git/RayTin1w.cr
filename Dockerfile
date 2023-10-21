FROM debian:bookworm

RUN apt update & apt install curl

RUN curl -fsSL https://crystal-lang.org/install.sh | bash

CMD ["/bin/bash"]
