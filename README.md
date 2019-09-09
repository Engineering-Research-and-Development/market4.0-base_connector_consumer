# MARKET4.0 Base Connector Consumer
The Base Connector Consumer is an IDS connector, based on the IDS Base Connector, used in the Market4.0 project with the consumer role.
The main objective is to communicate with the Base Connector Producer in order to exchange data. The main components are:
* Apache ActiveMQ for data exchanging, supporting both openwire and ssl as the communication protocol
* Apache Camel for routes defining in order to forward the JMS messages to application endpoints

In order to use SSL, please use dummy certificates or creating new ones as illustrated by ActiveMQ documentation.
