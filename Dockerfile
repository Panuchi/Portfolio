FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["TimofeiJaagerPortfolio.csproj", "./"]
RUN dotnet restore "TimofeiJaagerPortfolio.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "TimofeiJaagerPortfolio.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TimofeiJaagerPortfolio.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TimofeiJaagerPortfolio.dll"]
