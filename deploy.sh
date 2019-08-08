docker build -t hammerandnail/multi-client:latest -t hammerandnail/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hammerandnail/multi-server:latest -t hammerandnail/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hammerandnail/multi-worker:latest -t hammerandnail/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hammerandnail/multi-client:latest
docker push hammerandnail/multi-server:latest
docker push hammerandnail/multi-worker:latest

docker push hammerandnail/multi-client:$SHA
docker push hammerandnail/multi-server:$SHA
docker push hammerandnail/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hammerandnail/multi-server:$SHA
kubectl set image deployments/client-deployment client=hammerandnail/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hammerandnail/multi-worker:$SHA
