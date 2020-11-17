FROM ruby:2.5
RUN gem install rails -v 5.1.6
# RUN bundle install --without production