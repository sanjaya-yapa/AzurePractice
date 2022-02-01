FROM mcr.microsoft.com/dotnet/sdk AS build-env 
WORKDIR /app

#Copy csproj and restore
COPY webapp/*.csproj ./
RUN dotnet restore

# Copy everytihng else and build
COPY ./webapp ./
RUN dotnet publish -c Release -o out

#Build runtme image
FROM mcr.microsoft.com/dotnet/aspnet
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "webapp.dll" ]
