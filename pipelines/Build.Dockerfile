FROM mcr.microsoft.com/dotnet/sdk:5.0

RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1/' /etc/ssl/openssl.cnf \
    && sed -i 's/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

# EXPOSE 9000 
# EXPOSE 80
# EXPOSE 443

WORKDIR /src

COPY ./FoodTrack.Database.sln ./FoodTrack.Database.sln
COPY ./src/FoodTrack.Database.csproj ./src/FoodTrack.Database.csproj

RUN dotnet restore

COPY ./src ./src
RUN dotnet build \
        --configuration=Release

COPY . .
RUN chmod a+x pipelines/*.sh