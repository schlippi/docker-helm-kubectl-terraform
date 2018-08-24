FROM dtzar/helm-kubectl:2.8.2

RUN wget -O terraform.zip  "https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip" && \
    unzip terraform.zip -d /bin && \
    rm -rf terraform.zip
