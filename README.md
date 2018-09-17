# Kele API Client

### REST API Client

API Client Gem built to access [Bloc's REST API](http://docs.blocapi.apiary.io/#). With kind inspiration by [Kasey Markham](https://medium.com/@builtbykasey/kele-api-client-gem-case-study-5566b947fb46).

## Project Objectives

- Kele retrieves and stores an authentication token when passed valid credentials
- Students can retrieve their info as a JSON blog
- Students can retrieve a list of their mentor's availability
- Students can retrieve roadmaps and checkpoints
- Students can retrieve a list of their messages, respond to an existing message, and create a new message thread
- Students can submit checkpoint assignments

## Built With

- Ruby 2.3.3
- HTTParty Gem
- JSON Gem

## Setup and Configuration

### Setup

Add this line to your application's Gemfile:

`gem 'kele'`

And then execute:

`$ bundle install`

Or install it yourself as:

`$ gem install ./kele-0.0.1.gem`

### Getting started

Require kele Gem on irb:

    require 'kele'

Create a new variable using your Bloc login email and password. Kele will securely post your credentials to Bloc's API for an authentication token!

    kele_client = Kele.new('student@bloc.com', 'SecretPassword')

### Retrieving user info

On irb, using the `get_me` method users can retrieve user info as JSON and convert it into a Ruby hash.

    kele_client.get_me

### Getting Mentor Availability

With a `mentor_id`, can retrieve mentor's available time with `get_mentor_availability` and convert it into a ruby array.

    kele_client.get_mentor_availability(mentor_id)


### Checking Roadmaps and Checkpoints

With `roadmap_id` and `checkpoint_id`, user can retrieve associated Bloc's roadmap and checkpoint information using `get_roadmap(roadmap_id)` and `get_checkpoint(checkpoint_id)`, respectively.

    kele_client.get_roadmap(roadmap_id)
    kele_client.get_checkpoint(checkpoint_id)


### Retrieving and sending messages

Kele can retrieve all message in history using `get_messages` method. If given an argument `page`, `get_messages(page)` will return message thread `page` (message thread is pagninated with 10 messages per page); `get_messages` without argument will return all messages.

    kele_client.get_messages

Kele can create messages using `create_message(sender, recipient_id,  subject, stripped_text, token)` whereas subject is message subject and stripped is message's content.

    kele_client.create_message(sender, recipient_id, subject, stripped_text, token)
