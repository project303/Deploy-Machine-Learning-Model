# FROM ubuntu uncomment if you want to use ubuntu

# Install pip and git
# RUN apt-get update && apt-get install --assume-yes --fix-missing python-pip git

# Clone repository to /app folder in the container image
# RUN git clone https://github.com/deepakiim/Deploy-machine-learning-model.git /app

#####################################################################################################################
FROM python:3.10.0-slim

# Mount current directory to /app in the container image
#VOLUME ./:app/

# Change WORKDIR
WORKDIR /app

# Copy local directory to /app in container
# Dont use COPY * /app/ , * will lead to lose of folder structure in /app
COPY . /app/

# Install dependencies
# use --proxy http://<proxy host>:port if you have proxy
RUN pip install -r requirements.txt
RUN pip install gunicorn

# In Docker, the containers themselves can have applications running on ports. To access these applications, we need to expose the containers internal port and bind the exposed port to a specified port on the host.
# Expose port and run the application when the container is started
#EXPOSE 9999:9999
#ENTRYPOINT python 0703_sentiment_analytics_server.py
CMD [ "gunicorn", "--bind", "0.0.0.0:5000", "server:app" ]
