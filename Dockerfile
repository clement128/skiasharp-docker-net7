FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["docker-skiasharp.csproj", "./"]
RUN dotnet restore "docker-skiasharp.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "docker-skiasharp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "docker-skiasharp.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "docker-skiasharp.dll"]
