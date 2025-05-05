# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything
COPY . .

# Restore and publish
RUN dotnet restore
RUN dotnet publish /src/testing-out-docker-with-CSharp.csproj -c Release -o /app-publish 

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app-publish .

# Replace 'Toosh3.dll' with your actual DLL name
ENTRYPOINT ["dotnet", "testing-out-docker-with-CSharp.dll"]
