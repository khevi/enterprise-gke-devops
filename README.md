# Enterprise GKE DevOps Project

End-to-end DevOps project using Terraform, Docker, Google Kubernetes Engine, Artifact Registry, Kubernetes manifests, and Cloud Build CI/CD.

## Architecture

Terraform provisions:

- Custom VPC
- GKE subnet
- Pod secondary IP range
- Service secondary IP range
- GKE Standard cluster
- Node pool

## Application

The application includes:

- Python Flask API
- Docker image
- Artifact Registry repository
- Kubernetes Deployment
- Kubernetes LoadBalancer Service
- ConfigMap
- Readiness and liveness probes
- CPU and memory requests and limits

## CI/CD Pipeline

Cloud Build performs the following deployment workflow:

1. Builds the Docker image.
2. Tags the image using the Git commit SHA.
3. Pushes the image to Artifact Registry.
4. Connects to the GKE cluster.
5. Updates the Kubernetes Deployment image.
6. Kubernetes performs the application rollout.

Pipeline flow:

Cloud Build -> Docker -> Artifact Registry -> GKE -> Kubernetes Deployment

## Validation

The Flask application was successfully deployed to Google Kubernetes Engine and exposed through a public LoadBalancer.

The Cloud Build pipeline was manually validated using:

gcloud builds submit --config cloudbuild.yaml . --substitutions=SHORT_SHA=manual-test

The pipeline successfully built the container image, pushed it to Artifact Registry, and updated the GKE Deployment.

## Cost Control

The GKE lab is designed to minimize cloud costs when not in use.

Shutdown procedure:

kubectl delete svc enterprise-gke-service

kubectl scale deployment enterprise-gke-app --replicas=0

gcloud container clusters resize gke-dev-cluster \
  --node-pool gke-dev-node-pool \
  --num-nodes 0 \
  --zone us-east1-b \
  --project enterprise-gke-devops \
  --quiet

## Technologies

- Google Cloud Platform
- Google Kubernetes Engine
- Terraform
- Docker
- Kubernetes
- Artifact Registry
- Cloud Build
- Python
- Flask
- Gunicorn
- Git
