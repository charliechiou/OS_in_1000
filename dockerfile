FROM ubuntu:22.04

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g "${GROUP_ID}" mygroup \
    && useradd -u "${USER_ID}" -g "${GROUP_ID}" -m myuser

RUN apt update && apt install -y sudo clang llvm lld qemu-system-riscv32 curl bsdmainutils libwww-perl

# 確認 hexdump 存在並檢查路徑
RUN which hexdump || echo "hexdump not found in PATH" && find / -name hexdump

# 添加 PATH 到普通用戶環境
RUN echo 'export PATH=$PATH:/usr/bin' >> /home/myuser/.bashrc

WORKDIR /usr/src
USER myuser

CMD ["bash"]
