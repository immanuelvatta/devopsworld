FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS buildstage
#USER root
WORKDIR /aspnet  
#WORKDIR /root/aspnet
COPY ["DevopsDemo.Client/DevopsDemo.Client.csproj", "DevopsDemo.Client/"]
# /root/aspnet/DevopsDemo.Client (new directory)
#ways to change directory
#WORKDIR /aspnet/DevopsDemo.Client (makes this the new working directory)
# RUN cd DevopsDemo.Client (but it only works for that command) only for execution purposes
RUN dotnet restore DevopsDemo.Client/DevopsDemo.Client.csproj
COPY . .
WORKDIR /aspnet/DevopsDemo.Client
RUN dotnet build DevopsDemo.Client.csproj

FROM buildstage AS publishstage
RUN dotnet publish DevopsDemo.Client.csproj --no-restore -c Release -o /app
# app is in /root/aspnet/Devopsdemo.Client/app

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /deploy
COPY --from=publishstage /app .
#dont want entire environemnt, but just the piece i created (in this case it is app)
# /root/deploy/ (inside of deploy i'll have everything that app has)
# /root/deploy/DevopsDemo.Client.dll, DevopsDemo.Client.Views.dll ( i dont want app directory i want whats inside the app directory)
CMD [ "dotnet", "DevopsDemo.Client.dll" ]
