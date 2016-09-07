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

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

#Create app dir for sync sym link
CMD mkdir /usr/src/app

# copy current directory into /usr/src/app
COPY . /usr/src/app

# run python script when container lands on device
CMD ["python", "/usr/src/app/hello.py"]



