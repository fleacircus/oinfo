# ruby encoding: utf-8
class TestingController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def generate_message
    Delayed::Job.enqueue MessageJob.new(current_user), 0, 5.minutes.from_now
    redirect_to testing_index_path, :notice => 'Die Nachricht wird in ungefähr 5 Minuten generiert.'
  end

end
