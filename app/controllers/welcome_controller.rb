class WelcomeController < ApplicationController
  def index
    @welcome_message = "Welcome to viewing party! Be sure to grab some extra popcorn."
    @description = "Viewing party is an application that allows you to schedule showings with your friends or anyone you'd like. If you are new here be sure to register with us!"
  end
end
