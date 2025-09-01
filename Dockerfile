FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

# link when running the docker: https://ryandang7890-8080.theiaopenshiftnext-0-labs-prod-theiaopenshift-4-tor01.proxy.cognitiveclass.ai/
# link when deploying kube: https://accounts-sn-labs-ryandang7890.labs-prod-openshift-san-a45631dc5778dc6371c67d206ba9ae5c-0000.us-east.containers.appdomain.cloud/
