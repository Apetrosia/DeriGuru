# DeriGuru

A gem for symbolic differentiation of polynomials containing only integers or fractional numbers and variables

## Installation

## Usage

DeriGuru have one public method you can use. This method takes a string type parameter and converts it to a new string with a differentiated polynomial.

```ruby
    dif
````

In order for the method to process the string and find the derivative, the data must be correct.

### Valid characters

In a polynomial, you can use numbers, a dot, a multiplication sign, and lowercase Latin letters. Capital letters are prohibited.

### Valid terms

As terms, you can use integers and fractional numbers, letters and their products. You can write a multiplication sign between the multipliers, but this is not necessary.

There are examples of correct input data:

```ruby
    dif
    dif
    dif
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
    #UnexpectedSymbolError
    dif
````

- Use division sign (fractions must be represented as numbers with a dot):

```ruby
    #UnexpectedSymbolError
    dif
````

- Use characters that are not related to polynomials:

```ruby
    #UnexpectedSymbolError
    dif
````

- Use several identical variables in one term:

```ruby
    #IncorrectSymbolError
    dif
````
- Use single operation symbol or dot several times in a row:

```ruby
    #IncorrectSymbolError
    dif
````

- Use symbols incorrectly:

```ruby
    #IncorrectSymbolError
    dif
````

- Write number after letter:

```ruby
    #IncorrectSymbolError
    dif
````

- Write letter as exponent:

```ruby
    #IncorrectSymbolError
    dif
````