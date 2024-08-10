var builder = DistributedApplication.CreateBuilder(args);
builder.AddProject<Projects.razorpageapp>("razorpageapp");
builder.Build().Run();
