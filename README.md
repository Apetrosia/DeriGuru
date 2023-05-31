# DeriGuru

A gem for symbolic differentiation of polynomials containing only integers or fractional numbers and variables

## Usage



DeriGuru have one public class you can use - PolyDiffer. This class has one public method differentiate. It takes a string type parameter and converts it to a new string with a differentiated polynomial.

```ruby
    polydiffer = PolyDiffer.new
````

In order for the method to process the string and find the derivative, the data must be correct.

### Valid characters

In a polynomial, you can use numbers, a dot, a multiplication sign, and lowercase Latin letters. Capital letters are prohibited.

### Valid terms

As terms, you can use integers and fractional numbers, letters and their products. You can write a multiplication sign between the multipliers, but this is not necessary.

There are examples of correct input data:

```ruby
    output = polydiffer.differentiate("5+46")
    output = polydiffer.differentiate("-4.98x-5.57x")
    output = polydiffer.differentiate("x^2+x^3+x^6")
    output = polydiffer.differentiate("5*x+12*y")
    output = polydiffer.differentiate("y^32+3*y^2+9.8*x")
    output = polydiffer.differentiate("78.89*x^3+0*y^1+12*z^2")
````

the method can only process correctly specified strings, so there are some restrictions on the input data.

### Exceptions

if the input string is incorrect, user may get one of two errors:

#### UnexpectedSymbolError

You get get this exception if unexpected (forbidden) characters are used in the input string.

#### IncorrectSymbolError

You can get this exception if the input string contains only allowed characters, but some of them are used incorrectly.

In order for the method to work without exceptions, user must follow a number of rules. User cannot:

- Use brackets:

```ruby
    # UnexpectedSymbolError
    output = polydiffer.differentiate("x^(-12-9)+x^(12-4)")
````

- Use division sign (fractions must be represented as numbers with a dot):

```ruby
    # UnexpectedSymbolError
    output = polydiffer.differentiate("12.95/34")
````

- Use characters that are not related to polynomials:

```ruby
    # UnexpectedSymbolError
    output = polydiffer.differentiate("1<5+x>y+x^7+x^0!")
````

- Use several identical variables in one term:

```ruby
    # IncorrectSymbolError
    output = polydiffer.differentiate("2xyy")
````
- Use symbols incorrectly

```ruby
    # IncorrectSymbolError
    output = polydiffer.differentiate("x^^4")
    output = polydiffer.differentiate("x^-4+x")
    output = polydiffer.differentiate("x-+x")
    output = polydiffer.differentiate("4.2**x+x--x")
````

- Write number after letter:

```ruby
    # IncorrectSymbolError
    output = polydiffer.differentiate("x9-3+y")
````

- Write letter as exponent:

```ruby
    # IncorrectSymbolError
    output = polydiffer.differentiate("x^y")
````