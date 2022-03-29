class KodyPocztoweController < ApplicationController
  require 'csv'

  def new


  end

  def write
    @start_date = DateTime.current
    @end_date = DateTime.current
    csv = CSV.read('/Users/prosper/Ajp/lab1_app_bazodanowe/app/files/kody.csv', liberal_parsing: true)
    binding.pry
    render 'new'
  end
end