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

In a polynomial, you can use numbers, a dot, a multiplication sign, and uppercase Latin letters. Capital letters are prohibited.

### Valid terms

As terms, you can use integers and fractional numbers, letters and their products. You can write a multiplication sign between the multipliers, but this is not necessary.

There are examples of correct input data:

```ruby
    dif
    dif
    dif
````

the method can only process correctly specified strings, so there are some restrictions on the input data. User cannot:

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
- Use a single operation symbol or dot several times in a row:

```ruby
    #IncorrectSymbolError
    dif
````

- Use symbols incorrectly:

```ruby
    #IncorrectSymbolError
    dif
````

- Write a number after a letter:

```ruby
    #IncorrectSymbolError
    dif
````

- Write a letter as an exponent:

```ruby
    #IncorrectSymbolError
    dif
````

- Use the multiplication sign between numbers and a differentiable variable:

```ruby
    #IncorrectSymbolError
    dif
````

- But user can use multiplication sign between different variables:

```ruby
    dif
````