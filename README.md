# DeriGuru

A gem for symbolic differentiation of polynomials containing only integers or fractional numbers and variables

## Usage

DeriGuru offers you singleton class for symbolic polynomials differentiating - PolyDiffer. 
This class contains one method differentiate, which will provide you with all necessary functionality.
It takes a string type parameter and converts it to a new string with a differentiated polynomial.

In order for the method to process the string and find the derivative, the data must be correct.

### Valid characters

In a polynomial, you can use numbers, a dot, a multiplication sign, and lowercase Latin letters. Capital letters are prohibited.

### Valid terms

As terms, you can use integers and fractional numbers, letters and their products. You can write a multiplication sign between the multipliers, but this is not necessary.

There are examples of correct input data:

```ruby
    output = PolyDiffer.differentiate("5+46", "x")
    output = PolyDiffer.differentiate("-4.98x-5.57x", "x")
    output = PolyDiffer.differentiate("x^2+x^3+x^6", "x")
    output = PolyDiffer.differentiate("5*x+12*y", "x")
    output = PolyDiffer.differentiate("y^32+3*y^2+9.8*x", "x")
    output = PolyDiffer.differentiate("78.89*x^3+0*y^1+12*z^2", "x")
````

the method can only process correctly specified strings, so there are some restrictions on the input data.

### Exceptions

if the input string is incorrect, user may get one of three errors:

#### ArgumentError

You get this exception if you pass non-string data as arguments to the method or if arguments' length is incorrect.

#### UnexpectedSymbolError

You get get this exception if unexpected (forbidden) characters are used in the input string.

#### IncorrectSymbolError

You can get this exception if the input string contains only allowed characters, but some of them are used incorrectly.

In order for the method to work without exceptions, user must follow a number of rules. User cannot:

- Pass non-string data:
```ruby
    # ArgumentError
    output = PolyDiffer.differentiate(482, 5)
    output = PolyDiffer.differentiate(["x^2", "x^3"], "x")
````

- Pass empty strings
```ruby
    # ArgumentError
    output = PolyDiffer.differentiate("", "x")
    output = PolyDiffer.differentiate(["x^3"], "")
````

- Use brackets:

```ruby
    # UnexpectedSymbolError
    output = PolyDiffer.differentiate("x^(-12-9)+x^(12-4)", "x")
````

- Use division sign (fractions must be represented as numbers with a dot):

```ruby
    # UnexpectedSymbolError
    output = PolyDiffer.differentiate("12.95/34", "x")
````

- Use characters that are not related to polynomials:

```ruby
    # UnexpectedSymbolError
    output = PolyDiffer.differentiate("1<5+x>y+x^7+x^0!", "x")
````

- Use several identical variables in one term:

```ruby
    # IncorrectSymbolError
    output = PolyDiffer.differentiate("2xyy", "x")
````
- Use symbols incorrectly

```ruby
    # IncorrectSymbolError
    output = PolyDiffer.differentiate("x^^4", "x")
    output = PolyDiffer.differentiate("x^-4+x", "x")
    output = PolyDiffer.differentiate("x-+x", "x")
    output = PolyDiffer.differentiate("4.2**x+x--x", "x")
````

- Write number after letter:

```ruby
    # IncorrectSymbolError
    output = PolyDiffer.differentiate("x9-3+y", "x")
````

- Write letter as exponent:

```ruby
    # IncorrectSymbolError
    output = PolyDiffer.differentiate("x^y", "x")
````