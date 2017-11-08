# IMAGE: notuscloud/kafka
# VERSION: 0.10.1.1

# As Kafka require JAVA, we build this image from openjdk
FROM openjdk

# Install vim, this make edition more confortable
# Can be deleted any time to make the docker image lighter
RUN apt-get update && apt-get install -y vim

# Create the install directory and install Kafka
RUN mkdir /install
WORKDIR /install
RUN curl -O http://mirrors.ircam.fr/pub/apache/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
RUN tar xvf kafka_2.11-0.10.1.1.tgz 
RUN rm kafka_2.11-0.10.1.1.tgz
RUN mv kafka_2.11-0.10.1.1 kafka

# Expose ports
# The default port is 9092
EXPOSE 9092

# Volumes
VOLUME /data

# Defining entrypoint
WORKDIR /install/kafka
COPY entrypoint.sh /install/kafka/entrypoint.sh
RUN chmod 755 entrypoint.sh

# Defining CMD
CMD ["/install/kafka/entrypoint.sh"]