FROM resin/nuc-node

# Enable systemd
ENV INITSYSTEM on

# Install Python and Apache.
RUN apt-get update \
	&& apt-get install -y \ 
	python Apache2 \
	# Remove package lists to free up space
	&& rm -rf /var/lib/apt/lists/* \
	
#Publish
EXPOSE 80	

# copy current directory into /app
COPY . /app

#Copy Index
COPY index.html /var/www/html/index.html


# run python script when container lands on device
CMD ["python", "/app/hello.py"]

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND


