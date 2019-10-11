# SSLPoke
**Java SSL handshake issue testing tool**

## Compiling
`javac SSLPoke.java`

## Usage
`java SSLPoke google.com 443`

*useful options :*
- -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2
- -Djavax.net.debug=ssl

for more useful info on this check [here](https://confluence.atlassian.com/jira/connecting-to-ssl-services-117455.html)
