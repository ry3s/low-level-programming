FROM alpine:3.4

RUN apk update
RUN apk add binutils nasm gdb
