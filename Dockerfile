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

#Create app dir for sync sym link
CMD mkdir /usr/src/app

#Remove index.html
CMD rm /var/www/html/index.html

# copy current directory into /usr/src/app
COPY . /usr/src/app

#Copy index from app to Apache default
CMD cp /usr/src/app/index.html /var/www/html/index.html

#Copy Index
#COPY index.html /var/www/html/index.html

# Update the default apache site with the config we created.
# ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

# run python script when container lands on device
CMD ["python", "/usr/src/app/hello.py"]



