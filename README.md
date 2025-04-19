
## 1. How to Run the Script 

```bash
# Make it executable
chmod +x script.sh

# Run to create folder and file
./script.sh 1

# Run to delete folder
./script.sh 0

## 2. How to Build and Run Dockerfile

```bash
# Build image for cleanup stage (input 0)
docker build -t myimage-cleanup --target=cleanup .

# Build image for create stage (input 1)
docker build -t myimage-create --target=create .

# Run cleanup container
docker run -d --name cleanup-job myimage-cleanup

# Run create container
docker run -d --name create-job myimage-create

## 3. How to Push Image to Azure Container Registry

```bash
# Login to your Azure Container Registry
docker login anupcontaier.azurecr.io -u anupcontaier -p <your-password>

# Tag the cleanup image
docker tag myimage-cleanup anupcontaier.azurecr.io/myimage-cleanup:latest

# Tag the create image
docker tag myimage-create anupcontaier.azurecr.io/myimage-create:latest

# Push both images to ACR
docker push anupcontaier.azurecr.io/myimage-cleanup:latest
docker push anupcontaier.azurecr.io/myimage-create:latest


