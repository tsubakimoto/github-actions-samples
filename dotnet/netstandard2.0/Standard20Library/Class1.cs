using System;

namespace Standard20Library;

public interface ICalculator
{
    public int Add(int a, int b);
    public int Subtract(int a, int b);
    public int Multiply(int a, int b);
    public int Divide(int a, int b);
}

public class Calculator : ICalculator
{
    public int Add(int a, int b)
    {
        return a + b;
    }

    public int Divide(int a, int b)
    {
        return a / b;
    }

    public int Multiply(int a, int b)
    {
        return a * b;
    }

    public int Subtract(int a, int b)
    {
        return a - b;
    }
}
