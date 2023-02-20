#dotnet publish --os linux --arch x64 -c Release -p:PublishProfile=DefaultContainer
#

docker build -t docker-skiasharp-test:latest .

docker run -it --rm -p 5010:80 docker-skiasharp-test:latest
