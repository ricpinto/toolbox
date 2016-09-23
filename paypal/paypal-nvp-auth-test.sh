#!/usr/bin/env bash
#####################################################
# Paypal NVP api account test
# The script will try to place a payment request
# for the amount of 1 USD
####################################################

# apis
PAYPAL_PROD="https://api-3t.paypal.com/nvp"
PAYPAL_SANDBOX="https://api-3t.sandbox.paypal.com/nvp"

# get definitions
ENV=0
echo ""
echo "-------------------------------------"
echo " Choose environment"
echo "-------------------------------------"
echo " Production  (1)"
echo " Sandbox     (2)"
read -p "> " ENV

echo ""
case $ENV in
	1) echo " * Production API" && API_URL=$PAYPAL_PROD;;
	2) echo " * Sandbox API" && API_URL=$PAYPAL_SANDBOX;;
	*) echo " INVALID OPTION!" && exit 0;;
esac

echo ""
echo "-------------------------------------"
echo " Credentials"
echo "-------------------------------------"
read -p " User          : " USER
read -p " Password      : " PASSWORD
read -p " Signature     : " SIGNATURE
read -p " Callback URL  : " CALLBACK

echo ""
echo " * Processing request..."

RESULT=$(curl https://api-3t.paypal.com/nvp \
  -s \
  -d USER=$USER \
  -d PWD=$PASSWORD \
  -d SIGNATURE=$SIGNATURE \
  -d METHOD=SetExpressCheckout \
  -d VERSION=98 \
  -d PAYMENTREQUEST_0_AMT=1 \
  -d PAYMENTREQUEST_0_CURRENCYCODE=USD \
  -d PAYMENTREQUEST_0_PAYMENTACTION=SALE \
  -d cancelUrl=$CALLBACK \
  -d returnUrl=$CALLBACK)

DECODED_RESPONSE=$(printf '%b' "${RESULT//%/\\x}")

echo ""
echo "-------------------------------------"
echo " Service response"
echo "-------------------------------------"
PARAMS=$(echo ${DECODED_RESPONSE//&/ })
for PARAM in $PARAMS
do
    echo $PARAM
done
