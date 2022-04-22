FROM rust:1-buster

WORKDIR /

RUN cargo install cargo-nextest
RUN apt-get update && apt-get -y install python3 python3-pip coreutils
RUN pip3 install junit-xml

RUN mkdir /student_dir
COPY . /

WORKDIR /deps
RUN cargo vendor

WORKDIR /

ENTRYPOINT ["/entry.sh"]
