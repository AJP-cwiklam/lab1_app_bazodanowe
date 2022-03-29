class KodyPocztoweController < ApplicationController
  require 'csv'
  before_action :read_csv

  def new
  end

  def write1
    kody_pocztowe = @csv.enum_for(:each_with_index).map do |row, i|
      next if i == 0

      KodyPocztowe.new(kod_pocztowy: row[0], adres: row[1], miejscowosc: row[2], wojewodztwo: row[3], powiat: row[4])
    end.compact
    @start_date   = time_now
    kody_pocztowe.each(&:save)
    @end_date   = time_now
    @difference = difference
    render 'new'
  end

  def write2
    sqls = @csv.enum_for(:each_with_index).map do |row, i|
      next if i == 0

      "INSERT INTO kody_pocztowes (kod_pocztowy, adres, miejscowosc, wojewodztwo, powiat) "\
      "VALUES ('#{replace_char(row[0]).to_s}', '#{replace_char(row[1]).to_s}', '#{replace_char(row[2]).to_s}', '#{replace_char(row[3]).to_s}', '#{replace_char(row[4]).to_s}')"
    end.compact
    @start_date = time_now
    sqls.each { |sql| ActiveRecord::Base.connection.execute(sql) }
    @end_date   = time_now
    @difference = difference
    render 'new'
  end

  def write3
    kody_pocztowe = (@csv.enum_for(:each_with_index).map do |row, i|
      next if i == 0

      {kod_pocztowy: row[0], adres: row[1], miejscowosc: row[2], wojewodztwo: row[3], powiat: row[4]}
    end.compact)
    @start_date   = time_now
    KodyPocztowe.create(kody_pocztowe)
    @end_date   = time_now
    @difference = difference
    render 'new'
  end

  private

  def read_csv
    @csv = CSV.read('/Users/prosper/Ajp/lab1_app_bazodanowe/app/files/kody.csv', liberal_parsing: true, col_sep: ";")
  end

  def time_now
    DateTime.current
  end

  def difference
    "#{((@end_date - @start_date) * 24 * 60).to_i} min : #{((@end_date - @start_date) * 24 * 60 * 60).to_i - ((@end_date - @start_date) * 24 * 60).to_i} sec "
  end

  def replace_char(char)
    char.tr('\'', '')
  end
end