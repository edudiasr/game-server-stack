FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY --from=src db ./db
COPY --from=src src/GameStore.Api ./src/GameStore.Api
RUN dotnet publish src/GameStore.Api -c Release -o /out --nologo

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /out ./
USER app
EXPOSE 8080
ENTRYPOINT ["dotnet", "GameStore.Api.dll"]
