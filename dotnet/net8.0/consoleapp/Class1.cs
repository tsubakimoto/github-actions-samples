namespace consoleapp;

internal class Class1
{
    private string field1 = "hello world";

    public string Property1
        => field1;

    public string Greet()
    {
        return $"Hello, World {Property1}!";   // comment
    }
}
