ARG BASE

FROM ${BASE} as build

RUN dotnet publish \
        --configuration=Release \
        --output /output

FROM mcr.microsoft.com/dotnet/sdk:5.0

WORKDIR /app

# ENV ASPNETCORE_URLS=https://+:443

COPY --from=build /output .

ARG BUILD_NUMBER

ENTRYPOINT [ "dotnet", "FoodTrack.Grpc.dll" ]
EXPOSE 443  
EXPOSE 80  