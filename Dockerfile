# ---------- build ----------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore backend/PoupAI_Backend/PoupAI/PoupAI.csproj
RUN dotnet publish backend/PoupAI_Backend/PoupAI/PoupAI.csproj -c Release -o /app/publish /p:UseAppHost=false

# ---------- runtime ----------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
EXPOSE 8080
# se der erro, troque para PoupAi.dll (note o "i") — Linux diferencia maiúsc/minúsc
ENTRYPOINT ["dotnet","PoupAI.dll","--urls","http://0.0.0.0:8080"]
