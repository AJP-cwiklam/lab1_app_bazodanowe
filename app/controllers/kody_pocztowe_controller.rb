class KodyPocztoweController < ApplicationController
  require 'csv'

  def new

  end

  def write
    csv = CSV.read("../files/kody.csv")
    binding.pry
  end
end