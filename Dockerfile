# ----------------- build -----------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
# copia tudo (evita erro de caminho relativo)
COPY . .
# restaura e publica APONTANDO para o .csproj exato do backend
RUN dotnet restore backend/PoupAi_Backend/PoupAI/PoupAI.csproj
RUN dotnet publish backend/PoupAi_Backend/PoupAI/PoupAI.csproj -c Release -o /app/publish /p:UseAppHost=false

# ---------------- runtime ----------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
EXPOSE 8080
# ATENÇÃO ao case do DLL (Linux diferencia maiúsc/minúsc)
ENTRYPOINT ["dotnet","PoupAI.dll"]
