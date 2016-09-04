FROM resin/nuc-node

# Enable systemd
ENV INITSYSTEM on

# Install Python.
RUN apt-get update \
	&& apt-get install -y python \
	# Remove package lists to free up space
	&& rm -rf /var/lib/apt/lists/*

# copy current directory into /app
COPY . /app


# run python script when container lands on device
CMD ["python", "/app/hello.py"]

#See what the hell happens when I try to chain images for fun

FROM httpd:2.4

COPY ./public-html/ /usr/local/apache2/htdocs/