#!/bin/bash

# Prompt the user for the domain name.
echo -n "Please enter the domain name: "
read DOMAIN
apt-get update
apt-get upgrade

# Define URLs and filenames.
CLI_URL="https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.deb"
CLI_DEB="step-cli_amd64.deb"
CA_URL="https://ca.myaxmann.com/"
FINGERPRINT="3337758da95967faa3793756a741e48a023f0de41567886ef2a79ffbbf9cba25"

# Download the CLI package.
echo "Downloading the step CLI package..."
wget $CLI_URL -O $CLI_DEB

# Install the package.
echo "Installing the step CLI package..."
dpkg -i $CLI_DEB

# Bootstrap the Certificate Authority.
echo "Bootstrapping the Certificate Authority..."
step ca bootstrap --ca-url $CA_URL --fingerprint $FINGERPRINT --install

# Generate the certificate and private key.
echo "Generating certificate and private key for $DOMAIN..."
CERT_FILE="$DOMAIN.crt"
KEY_FILE="$DOMAIN.key"
step ca certificate $DOMAIN $CERT_FILE $KEY_FILE

echo "Certificate and key have been generated:"
echo "  Certificate: $CERT_FILE"
echo "  Private Key: $KEY_FILE"
