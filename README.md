# GroundUser

GroundUser is a micro library isolating user management.
It currently relies on MongoDB to persist users.

## Functional approach

This library is built upon functional programming principles,
essentially the immutable data principle. So you will only
be able to manipulate your data through services which
precisely define what you're able to do with your users.

Since the goal of this library is to encapsulate standard user
management features, this shouldn't be a problem, _au contraire_.
Everything that is not standard for an user should go in your
domain code.

## Features

The features are provided by the services:
  - create
  - get
  - verify password
  - change password
  - delete

## Getting started

- Start playing in the console: `script/console`
- Run tests: `rake test`
- Start developing: `guard`

## Examples

```ruby
GroundUser.create 'valid@email.com', 'password'
=> #<struct GroundUser::ServiceResponse
 status=:success,
 data=
  #<struct GroundUser::Data
   id="5495bb916a742d199f000000",
   email="valid@email.com",
   hashed_password="45345dff74c445e2a24c09bfaacc78d3a0d546962dd0b21e30a1856331e1198e",
   salt="d8m2BiCMvZM=">,
 errors=[]>

GroundUser.get('valid@email.com')
=> #<struct GroundUser::ServiceResponse
 status=:success,
 data=
  #<struct GroundUser::Data
   id="5495bb916a742d199f000000",
   email="valid@email.com",
   hashed_password="45345dff74c445e2a24c09bfaacc78d3a0d546962dd0b21e30a1856331e1198e",
   salt="d8m2BiCMvZM=">,
 errors=[]>

GroundUser.create 'invalid@email', 'pass'
=> #<struct GroundUser::ServiceResponse
 status=:failure,
 data=nil,
 errors=[:invalid_email, :password_too_short]>

GroundUser.create 'valid@email.com', 'password'
=> #<struct GroundUser::ServiceResponse
 status=:failure,
 data=nil,
 errors=[:existing_user_with_email]>

GroundUser.delete 'valid@email.com'
=> #<struct GroundUser::ServiceResponse
 status=:success,
 data=
  #<struct GroundUser::Data
   id="5495bb916a742d199f000000",
   email="valid@email.com",
   hashed_password="45345dff74c445e2a24c09bfaacc78d3a0d546962dd0b21e30a1856331e1198e",
   salt="d8m2BiCMvZM=">,
 errors=[]>
```
