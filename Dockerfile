FROM artifactory.services.dicedev.dhiaws.com:5000/dice/dice-locust-qa:latest

#==============
# Expose Ports
#==============
EXPOSE 8089
EXPOSE 5557
EXPOSE 5558

#======================
# Install dependencies
#======================
COPY requirements.txt /tmp/
RUN rm -rf /opt/script
RUN pip3 install -r /tmp/requirements.txt --upgrade

#=====================
# Start docker-locust
#=====================
COPY src /opt/src/
COPY setup.cfg /opt/
RUN mkdir /opt/result /opt/reports
RUN ln -s /opt/src/app.py /usr/local/bin/locust-wrapper
WORKDIR /opt
ENV PYTHONPATH /opt
ARG DL_IMAGE_VERSION=latest
ENV DL_IMAGE_VERSION=$DL_IMAGE_VERSION \
    SEND_ANONYMOUS_USAGE_INFO=true

CMD ["locust-wrapper"]
