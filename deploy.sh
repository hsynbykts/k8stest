docker build -t hsynbykts/multi-client:latest -t hsynbykts/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hsynbykts/multi-server:latest -t hsynbykts/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hsynbykts/multi-worker:latest -t hsynbykts/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hsynbykts/multi-client:latest
docker push hsynbykts/multi-server:latest
docker push hsynbykts/multi-worker:latest

docker push hsynbykts/multi-client:$SHA
docker push hsynbykts/multi-server:$SHA
docker push hsynbykts/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hsynbykts/multi-server:$SHA
kubectl set image deployments/client-deployment client=hsynbykts/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hsynbykts/multi-worker:$SHA