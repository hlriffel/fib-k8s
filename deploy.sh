docker build -t hlriffel/fib-client:latest -t hlriffel/fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t hlriffel/fib-server:latest -t hlriffel/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t hlriffel/fib-worker:latest -t hlriffel/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hlriffel/fib-client:latest
docker push hlriffel/fib-server:latest
docker push hlriffel/fib-worker:latest

docker push hlriffel/fib-client:$SHA
docker push hlriffel/fib-server:$SHA
docker push hlriffel/fib-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/client-deployment client=hlriffel/fib-client:$SHA
kubectl set image deployments/server-deployment server=hlriffel/fib-server:$SHA
kubectl set image deployments/worker-deployment worker=hlriffel/fib-worker:$SHA