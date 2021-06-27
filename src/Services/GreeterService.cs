using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;

namespace src
{
    public class GreeterService : Greeter.GreeterBase
    {
        private readonly ILogger<GreeterService> _logger;
        public GreeterService(ILogger<GreeterService> logger)
        {
            _logger = logger;
        }  

        public Task<HelloReply> SayHello(HelloRequest request)
        {
            var reply = new HelloReply{
                Message = $"Hello {request.Name}"
            };
            return Task.FromResult(reply);
        }
    }
}
